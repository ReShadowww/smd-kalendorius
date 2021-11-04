DROP DATABASE if EXISTS smd_cal;
CREATE DATABASE smd_cal;

create table smd_cal.bureliai(
    id int auto_increment primary key,
    burelis varchar(255) not null,
    UNIQUE (burelis)
);