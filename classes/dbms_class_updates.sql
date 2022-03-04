-- 17 feb

SHOW DATABASES;

CREATE DATABASE HOSPITAL_BED_AVAILIBILITY;
USE HOSPITAL_BED_AVAILIBILITY;
SHOW TABLES;

-- 18 feb

CREATE TABLE BEDS(
    HOSPITAL_ID INTEGER,
    PATIENT_ID INTEGER PRIMARY KEY,
    DISEASE VARCHAR(40),
    DAYS_BED_AVAILIBILITY INTEGER
                 );

INSERT INTO BEDS VALUES(21002,10001,'fever',2),(21006,10002,'stroke',2);

-- Records were inserted from excel to BEDS
-- https://docs.google.com/spreadsheets/d/18mcakEtf8PICwVpuExcfL6W6Ic5EVStZfoPGW1gRRzA/edit?usp=sharing
 
-- 22 feb

SELECT *FROM BEDS;

CREATE TABLE PATIENT(
    S_NO INTEGER PRIMARY KEY,
    NAME VARCHAR(40),
    BLOOD_GROUP VARCHAR(40),
    DIABETES VARCHAR(40),
    AREA_PIN_CODE INTEGER
                    );
                    
-- 23 feb

INSERT INTO PATIENT VALUES(1,'Pranjal','A+','Y',102),(2,'shiva','B-','N',102);
 
-- Records were inserted from excel to PATIENT
-- https://docs.google.com/spreadsheets/d/1VPw1Lb-eq7CnUFpvjMRzkVhJ2iKL6dN3b1kBhSt2p58/edit?usp=sharing
-- 
SELECT *FROM PATIENT;

SELECT * FROM BEDS INNER JOIN PATIENT;


-- 25 FEB
-- # JOIN

UPDATE PATIENT SET S_NO = S_NO+10000;

SELECT * FROM BEDS LEFT JOIN PATIENT ON BEDS.PATIENT_ID = PATIENT.S_NO;

SELECT * FROM BEDS RIGHT JOIN PATIENT ON BEDS.PATIENT_ID = PATIENT.S_NO;

SELECT * FROM PATIENT RIGHT JOIN BEDS ON PATIENT.S_NO = BEDS.PATIENT_ID ;

-- create new table using the output of JOIN of two tables

CREATE TABLE BEDS_AND_PATIENT AS SELECT * FROM PATIENT RIGHT JOIN BEDS ON PATIENT.S_NO = BEDS.PATIENT_ID ;

SELECT * FROM BEDS_AND_PATIENT;


-- 26 feb
-- # SUM() | COUNT() | GROUP BY | ORDER BY

SELECT * FROM BEDS GROUP BY DISEASE;

SELECT DISEASE FROM BEDS GROUP BY DISEASE;

SELECT COUNT(HOSPITAL_ID), SUM(TOTAL) FROM BEDS GROUP BY DISEASE;

-- 2 march
-- # UNION ALL | SUM 

SELECT DISEASE, COUNT(HOSPITAL_ID) AS count FROM BEDS GROUP BY DISEASE UNION ALL SELECT 'SUM' DISEASE, COUNT(HOSPITAL_ID) FROM BEDS;

-- The sum of patients with particular diseases 

SELECT
       DISEASE,
       COUNT(PATIENT_ID) AS No_of_patient
   FROM BEDS
   WHERE
      DISEASE IN('tonsilitis','malaria')
   GROUP BY DISEASE
   UNION ALL
   SELECT 'TOTAL',
       COUNT(PATIENT_ID)
   FROM BEDS
   WHERE
      DISEASE IN('tonsilitis','malaria');

-- 3 march
-- # MAX()

-- Find the disease that has the maximum number of patients

SELECT
       t.DISEASE,
       t.CNT
   FROM (
     SELECT
             DISEASE,
             COUNT(DISEASE) AS CNT, 
             MAX(COUNT(DISEASE)) OVER () AS MAX_CNT 
     FROM BEDS 
     GROUP BY DISEASE
   ) AS t
   WHERE 
      t.CNT=t.MAX_CNT;


-- # AVG()

SELECT AVG(DAYS_BED_AVAILIBILITY) FROM BEDS;


-- 4th feb
-- # DISTINCT() # NOT # LIKE # RLIKE # CHARACTER SEARCHING # EVEN ROWS # ODD ROWS

-- RLIKE: This operator in MySQL is used to performs a pattern match of a string expression against a pattern.
-- DISTINCT: It is used to return only distinct (different) values.

/* Query the list of Patient names from Beds and patient that start with vowels.
 Your result cannot contain duplicates. */

SELECT DISTINCT(NAME)
FROM BEDS_AND_PATIENT
WHERE NAME LIKE 'A%'
   OR NAME LIKE 'E%'
   OR NAME LIKE 'I%'
   OR NAME LIKE 'O%'
   OR NAME LIKE 'U%'
ORDER BY NAME ASC;


/* Query the list of Patient names from Beds and patient that do not start with vowels.
 Your result cannot contain duplicates. */

-- 1st method

SELECT DISTINCT(NAME)
FROM BEDS_AND_PATIENT
WHERE Name not LIKE 'A%'
    AND NAME NOT LIKE 'E%'
    AND NAME NOT LIKE 'I%'
    AND NAME NOT LIKE 'O%'
    AND NAME NOT LIKE 'U%'
ORDER BY NAME ASC;

-- 2nd method

SELECT DISTINCT NAME
FROM BEDS_AND_PATIENT
WHERE NAME
      NOT RLIKE '^[aeiouAEIOU].*$';

/* Query the list of Patient names from Beds and patient that do not have second or thirdalphabet as vowels.
 Your result cannot contain duplicates. */
 -- 1st method: for second char '_A%' and for third char '__A%' and so on (ADD _ FOR EACH CHARACTER )
 -- 2nd method: for second char '^.[aeiouAEIOU].*$' and for third char '^..[aeiouAEIOU].*$' and so on (ADD . FOR EACH CHARACTER IN BETWEEN ^ AND [] ) 

-- 1st method 

SELECT DISTINCT(Name)
FROM BEDS_AND_PATIENT
WHERE NAME LIKE '_A%'
   OR NAME LIKE '_E%'
   OR NAME LIKE '_I%'
   OR NAME LIKE '_O%'
   OR NAME LIKE '_U%'
ORDER BY NAME ASC;

-- 2nd method 

Select DISTINCT NAME
from BEDS_AND_PATIENT
where name
      not RLIKE  '^..[aeiouAEIOU].*$';
      
/* Query a list of Patient names from BEDS_AND_PATIENT table with even ID numbers only. 
You may print the results in any order,
but must exclude duplicates from your answer. */

SELECT DISTINCT NAME, PATIENT_ID
FROM BEDS_AND_PATIENT
WHERE NOT( PATIENT_ID%2 = 1);
      
   
      
