##-- 17 feb

SHOW DATABASES ;
CREATE DATABASE HOSPITAL_BED_AVAILIBILITY;
USE HOSPITAL_BED_AVAILIBILITY;
SHOW TABLES;

##-- 18 feb
CREATE TABLE BEDS(
    HOSPITAL_ID INTEGER,
    PATIENT_ID INTEGER PRIMARY KEY,
    DISEASE VARCHAR(40),
    DAYS_BED_AVAILIBILITY INTEGER
                 );

INSERT INTO BEDS VALUES(21002,10001,'fever',2),(21006,10002,'stroke',2);

# Records were inserted from excel to BEDS
# https://docs.google.com/spreadsheets/d/18mcakEtf8PICwVpuExcfL6W6Ic5EVStZfoPGW1gRRzA/edit?usp=sharing
# 

##-- 22 feb
SELECT *FROM BEDS;

CREATE TABLE PATIENT(
    S_NO INTEGER PRIMARY KEY,
    NAME VARCHAR(40),
    BLOOD_GROUP VARCHAR(40),
    DIABETES VARCHAR(40),
    AREA_PIN_CODE INTEGER
                    );
                    
##-- 23 feb
INSERT INTO PATIENT VALUES(1,'Pranjal','A+','Y',102),(2,'shiva','B-','N',102);
 
# Records were inserted from excel to PATIENT
# https://docs.google.com/spreadsheets/d/1VPw1Lb-eq7CnUFpvjMRzkVhJ2iKL6dN3b1kBhSt2p58/edit?usp=sharing
# 
SELECT *FROM PATIENT;

SELECT * FROM BEDS INNER JOIN PATIENT;

UPDATE PATIENT SET S_NO = S_NO+10000;

