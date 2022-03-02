
-- 
SELECT
       HOSPITAL_ID,
       DISEASE,
       COUNT(HOSPITAL_ID) AS PATIENT_IN_HOPITAL,
       SUM(COUNT(HOSPITAL_ID))
           OVER (ORDER BY DISEASE)
           AS RUNNING_TOTAL
FROM
     BEDS
GROUP BY
         DISEASE,
         HOSPITAL_ID;

-- #################################################################################################
-- COUNT OF PATIENT PER DISEASE PER HOSPITAL

SELECT

       DISEASE,
       COUNT(PATIENT_ID) AS COUNT_PATIENTS,
       HOSPITAL_ID,
       SUM(COUNT(DISEASE)) OVER ()
FROM BEDS
GROUP BY DISEASE,
         HOSPITAL_ID;

-- #################################################################################################
-- DISEASE VS CUMULATIVE SUM OF DISEASE USING VARIABLE

SELECT
       l.DISEASE,
       @running_total:= @running_total + l.rental_count
           AS cumulative_sum
FROM
( SELECT
         HOSPITAL_ID,
         DISEASE,
         COUNT(DISEASE)
             AS rental_count
         FROM BEDS
    GROUP BY DISEASE
    ) AS l
JOIN ( SELECT @running_total:=0 ) r ;


-- #################################################################################################
-- DISEASE VS CUMULATIVE SUM OF DISEASE WITHOUT USING VARIABLE

SELECT
       DISEASE,
       SUM(COUNT(DISEASE))
           OVER (ORDER BY DISEASE)
           AS RUNNING_TOTAL
FROM BEDS
GROUP BY
         DISEASE;

-- #################################################################################################
-- SUM OF PATIENTS VS DISEASES

SELECT
    DISEASE,
       COUNT(DISEASE) AS PATIENTS_COUNT,
       SUM(COUNT(DISEASE))
           OVER (ORDER BY DISEASE)
AS TOTAL_PATIENTS
FROM
BEDS
GROUP BY
         DISEASE;


-- #################################################################################################
-- PERCENTAGE OF DISEASES USING VARIABLE

SELECT
       l.DISEASE,
       @PERCENTAGE_OF_DISEASE:= 100*l.COUNT_PATIENT / l.TOTAL_PATIENT
           AS PERCENTAGE_DISEASE
FROM
( SELECT
         DISEASE,
         COUNT(DISEASE)
             AS COUNT_PATIENT,
         SUM(COUNT(PATIENT_ID)) OVER() AS TOTAL_PATIENT
         FROM
              BEDS
                WHERE DISEASE 
                   IN ('tonsilitis','malaria','food poisoning','fever','typhoid')
    GROUP BY DISEASE
    ) AS l
JOIN ( SELECT @PERCENTAGE_OF_DISEASE:=0 ) r ;

-- #################################################################################################
-- PERCENTAGE OF DISEASES USING WITHOUT USING VARIABLE

SELECT DISEASE,
      100*COUNT(PATIENT_ID)/(SUM(COUNT(PATIENT_ID)) OVER()) AS 'PATIENT(%)',
       SUM(COUNT(PATIENT_ID)) OVER(ORDER BY DISEASE) AS SUM
FROM BEDS
WHERE DISEASE 
       IN('tonsilitis','malaria','food poisoning','fever','typhoid')
GROUP BY DISEASE;
