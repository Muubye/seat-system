CREATE DATABASE IF NOT EXISTS seating_db;

USE seating_db;

DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS SeatingChart;

CREATE TABLE SeatingChart (
                              FLOOR_SEAT_SEQ INT PRIMARY KEY,
                              FLOOR_NO INT NOT NULL,
                              SEAT_NO INT NOT NULL,
                              UNIQUE (FLOOR_NO, SEAT_NO)
);

CREATE TABLE Employee (
                          EMP_ID CHAR(5) PRIMARY KEY CHECK (CHAR_LENGTH(EMP_ID) = 5),
                          NAME VARCHAR(100) NOT NULL,
                          EMAIL VARCHAR(100),
                          FLOOR_SEAT_SEQ INT UNIQUE,

                          CONSTRAINT FK_EMP_SEAT
                              FOREIGN KEY (FLOOR_SEAT_SEQ)
                                  REFERENCES SeatingChart(FLOOR_SEAT_SEQ)
);