SHOW DATABASES ;

CREATE DATABASE HOSPITAL_BED_AVAILIBILITY;
USE HOSPITAL_BED_AVAILIBILITY;
SHOW TABLES;

CREATE TABLE BEDS(
    HOSPITAL_ID INTEGER,
    PATIENT_ID INTEGER PRIMARY KEY,
    DISEASE VARCHAR(40),
    DAYS_BED_AVAILIBILITY INTEGER
                 );
                 
# Records were inserted from excel to BEDS
# https://docs.google.com/spreadsheets/d/18mcakEtf8PICwVpuExcfL6W6Ic5EVStZfoPGW1gRRzA/edit?usp=sharing

SELECT *FROM BEDS;

CREATE TABLE PATIENT(
    S_NO INTEGER PRIMARY KEY,
    NAME VARCHAR(40),
    BLOOD_GROUP VARCHAR(40),
    DIABETES VARCHAR(40),
    AREA_PIN_CODE INTEGER
                    );
                    
 # Records were inserted from excel to PATIENT
 # https://docs.google.com/spreadsheets/d/1VPw1Lb-eq7CnUFpvjMRzkVhJ2iKL6dN3b1kBhSt2p58/edit?usp=sharing

SELECT *FROM PATIENT;
