from flask import Flask, Response, render_template, request, redirect
import mysql.connector

from icalendar import Calendar, Event
import requests

import os
from dotenv import load_dotenv

load_dotenv()

MYSQL_DATABASE = os.getenv("MYSQL_DATABASE")
MYSQL_USER = os.getenv("MYSQL_USER")
MYSQL_PASSWORD = os.getenv("MYSQL_PASSWORD")
MYSQL_ROOT_PASSWORD = os.getenv("MYSQL_ROOT_PASSWORD")
MYSQL_PORT = os.getenv("MYSQL_PORT")
MYSQL_HOST = os.getenv("MYSQL_HOST")

app = Flask(__name__)

CALENDAR_URL = "https://www.smd.lt/events/ical-events"


def get_calendar_from_url(url):
    ics_file = requests.get(url).text
    calendar = Calendar.from_ical(ics_file)
    return calendar


def get_bureliai_from_calendar(calendar):
    bureliai = []
    for component in calendar.walk(name="VEVENT"):
        burelis = component.get("SUMMARY").split(":")[0]
        bureliai.append(burelis)
    return list(dict.fromkeys(bureliai))


def push_bureliai_to_db(db_connection, bureliai_to_push, bureliai_to_compare):
    cur = db_connection.cursor()
    requested_bureliai = [burelis["burelis"] for burelis in bureliai_to_compare]
    for burelis in bureliai_to_push:
        if burelis not in requested_bureliai:
            try:
                sql = "INSERT INTO bureliai(burelis) VALUES (%s);"
                val = (str(burelis),)
                cur.execute(sql, val)
                db_connection.commit()
            except mysql.connector.IntegrityError as err:
                print("Error: {}".format(err))


def get_bureliai_from_db(cnx):

    cur = cnx.cursor()
    cur.execute("SELECT bureliai.id, bureliai.burelis FROM bureliai;")
    fetches = cur.fetchall()

    bureliai = []

    for burelis in fetches:
        burelis_dict = {"id": burelis[0], "burelis": burelis[1]}
        bureliai.append(burelis_dict)

    return bureliai


def connect_to_mysql():
    cnx = mysql.connector.connect(
        user=MYSQL_USER,
        password=MYSQL_PASSWORD,
        host=MYSQL_HOST,
        port=MYSQL_PORT,
        database=MYSQL_DATABASE,
    )
    return cnx


def get_ics_file_out(ics_file, requested_club_names):

    cal_in = ics_file
    cal_out = Calendar()

    # Get required properties
    # prodid = cal_in.get("prodid")
    version = cal_in.get("version")

    # Add required properties
    cal_out.add("PRODID", "-//SMD helper//SMD helper//EN")
    cal_out.add("VERSION", version)

    club_count = 0

    # Go thorugh each VEVENT component -> Check allowed list -> Add to new cal
    for component in cal_in.walk(name="VEVENT"):
        club_name = component.get("SUMMARY").split(":")[0]
        # club_name = component.get("ORGANIZER").split(":")[1]
        if club_name in requested_club_names:
            event = Event()
            url_exists = False
            for key, value in component.items():
                if key in [
                    "UID",
                    "DTSTAMP",
                    "DTSTART",
                    "DTEND",
                    "SUMMARY",
                    "DESCRIPTION",
                ]:
                    event[key] = value
                elif key == "LOCATION":
                    if url_exists == False:
                        event[key] = value.split("\n")[0]
                elif key == "URL":
                    event["LOCATION"] = value
                    url_exists = True

            cal_out.add_component(event)
            club_count = club_count + 1

    if club_count > 0:
        return cal_out.to_ical()
    else:
        return None


def update_database():
    cnx = connect_to_mysql()

    calendar_from_url = get_calendar_from_url(CALENDAR_URL)

    bureliai_from_calendar = get_bureliai_from_calendar(calendar_from_url)
    bureliai_from_database = get_bureliai_from_db(cnx)

    push_bureliai_to_db(
        db_connection=cnx,
        bureliai_to_push=bureliai_from_calendar,
        bureliai_to_compare=bureliai_from_database,
    )

    cnx.close()

    return bureliai_from_database


@app.route("/")
def index():

    bureliai_from_database = update_database()

    return render_template("index.html", bureliai=bureliai_from_database)


@app.route("/api")
def api():

    update_database()

    cnx = connect_to_mysql()
    cur = cnx.cursor()

    all = request.args.get("all")

    if all == "true":

        sql = "SELECT bureliai.burelis FROM bureliai;"

        cur.execute(sql)

        fetches = cur.fetchall()

        bureliai = [burelis_tuple[0] for burelis_tuple in fetches]

        calendar_from_url = get_calendar_from_url(CALENDAR_URL)
        ics_file_out = get_ics_file_out(calendar_from_url, bureliai)

        cnx.close()

        return Response(ics_file_out, mimetype="text/calendar")

    id_list = request.args.getlist("id")

    if id_list:

        if len(id_list) == 1:
            sql = "SELECT bureliai.burelis FROM bureliai WHERE id IN %s;" % str(
                tuple(id_list)
            ).replace("'", "").replace(",", "")
        else:
            sql = "SELECT bureliai.burelis FROM bureliai WHERE id IN %s;" % str(
                tuple(id_list)
            ).replace("'", "")

        cur.execute(sql)

        fetches = cur.fetchall()

        bureliai = [burelis_tuple[0] for burelis_tuple in fetches]

        calendar_from_url = get_calendar_from_url(CALENDAR_URL)
        ics_file_out = get_ics_file_out(calendar_from_url, bureliai)

        cnx.close()
        return Response(ics_file_out, mimetype="text/calendar")
    else:
        cnx.close()
        return redirect("/", code=302)


@app.route("/help-iphone-cal")
def help_iphone():
    return render_template("help-iphone.html")


@app.route("/help-google-cal")
def help_google_cal():
    return render_template("help-google-cal.html")


if __name__ == "__main__":
    app.run(debug=True)
    # app.run(host="0.0.0.0", port=5005)
