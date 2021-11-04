FROM python:3.9.1
WORKDIR /flask-smd-cal
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
COPY FlaskApp/ .
COPY .env .
CMD [ "python3", "-m" , "flask", "run", "--host=0.0.0.0", "-p", "5005"]