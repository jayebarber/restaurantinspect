SELECT DISTINCT zip, score
FROM inspections1
WHERE score IS NOT NULL
GROUP BY score, zip;

SELECT AVG(score), zip
FROM inspections1
WHERE score IS NOT NULL
GROUp BY ZIP;



UPDATE inspections1
SET zip = '37220'
WHERE zip = '372207';

DELETE FROM inspections1
WHERE zip IN ('29412','14240');


SELECT AVG(score), zip
FROM inspections1
WHERE score IS NOT NULL
GROUp BY ZIP;

SELECT *
FROM householdincome

#finding the 7 outlining zipcodes that are not reported within the census data:
SELECT DISTINCT zip
FROM inspections1 i
LEFT JOIN race r ON i.zip = r.zipcode
WHERE r.zipcode IS NULL;

SELECT zip, COUNT(*) AS num_reports
FROM inspections1
WHERE zip IN ('37243','37202','37116','37230','37235','37240','37067')
GROUP BY zip;


SELECT *
FROM zipcodepop
WHERE zipcode, population, householdcount, medianincome, averageincome IS NOT NULL


SELECT *
from education2


SELECT SUM("Associate's degree" + "Bachelor's degree" + "Master's degree" + "Professional school degree" + "Doctorate degree") AS sum_result
FROM education2;
		   
SELECT SUM(CAST("Associate's degree" AS INT)) + SUM(CAST("Bachelor's degree" AS INT)) + SUM(CAST("Master's degree" AS INT)) + SUM(CAST("Professional school degree" AS INT)) + SUM(CAST("Doctorate degree" AS INT)) AS total_sum
FROM education2;

SELECT SUM(CASE WHEN ISNUMERIC("Associate's degree") = 1 THEN CAST("Associate's degree" AS INT) ELSE 0 END) + SUM(CASE WHEN ISNUMERIC("Bachelor's degree" ) = 1 THEN CAST("Bachelor's degree"  AS INT) ELSE 0 END) + SUM(CASE WHEN ISNUMERIC("Master's degree") =  1 THEN CAST("Master's degree" AS INT) ELSE 0 END) + SUM(CASE WHEN ISNUMERIC("Professional school degree") = 1 THEN CAST("Professional school degree" AS INT) ELSE 0 END) + SUM(CASE WHEN ISNUMERIC("Doctorate degree") = 1 THEN CAST("Doctorate degree" AS INT) ELSE 0 END) AS total_sum
FROM education2;


SELECT DISTINCT ZIPCODE,
SUM(CASE WHEN "Associate's degree" ~ '^\d+$' THEN CAST("Associate's degree" AS INT) ELSE 0 END) +
       SUM(CASE WHEN "Bachelor's degree" ~ '^\d+$' THEN CAST("Bachelor's degree" AS INT) ELSE 0 END) + SUM(CASE WHEN "Master's degree" ~ '^\d+$' THEN CAST("Master's degree" AS INT) ELSE 0 END) +
       SUM(CASE WHEN "Professional school degree" ~ '^\d+$' THEN CAST("Professional school degree" AS INT) ELSE 0 END) +  SUM(CASE WHEN "Doctorate degree" ~ '^\d+$' THEN CAST("Doctorate degree"AS INT) ELSE 0 END) 
	   AS Degreed_residents
FROM education2
GROUP BY zipcode;


#residents with no degree acquired 
SELECT DISTINCT ZIPCODE,
SUM(CASE WHEN "Regular high school diploma" ~ '^\d+$' THEN CAST("Regular high school diploma" AS INT) ELSE 0 END) +   SUM(CASE WHEN "GED or alternative credential" ~ '^\d+$' THEN CAST("GED or alternative credential" AS INT) ELSE 0 END) + SUM(CASE WHEN "Some college, less than 1 year" ~ '^\d+$' THEN CAST("Some college, less than 1 year" AS INT) ELSE 0 END)   AS No_Degree
FROM education2
GROUP BY zipcode;


---- JOINING RESIDENTS WITH NO DEGREE WITH AVG SCORES ----- 

SELECT e.ZIPCODE, e.No_Degree_acquired, i.AVG_SCORE
FROM
(
    SELECT DISTINCT ZIPCODE,
    SUM(CASE WHEN "Regular high school diploma" ~ '^\d+$' THEN CAST("Regular high school diploma" AS INT) ELSE 0 END) + 
	SUM(CASE WHEN "GED or alternative credential" ~ '^\d+$' THEN CAST("GED or alternative credential" AS INT) ELSE 0 END) + 
	SUM(CASE WHEN "Some college, less than 1 year" ~ '^\d+$' THEN CAST("Some college, less than 1 year" AS INT) ELSE 0 END) AS No_Degree_acquired
    FROM education2
    GROUP BY ZIPCODE
) AS e
LEFT JOIN
(
    SELECT AVG(score) AS AVG_SCORE, zip
    FROM inspections1
    WHERE score IS NOT NULL
    GROUP BY zip
) AS i
ON e.ZIPCODE = i.zip
WHERE i.AVG_SCORE IS NOT NULL;




--- Residents with a degree for each zipcode and avg score ---
SELECT education_by_zip.ZIPCODE, education_by_zip.Degree_acquired, AVG_score.AVG_SCORE
FROM
(
    SELECT ZIPCODE,
           SUM(CASE WHEN "Associate's degree" ~ '^\d+$' THEN CAST("Associate's degree" AS INT) ELSE 0 END) +
           SUM(CASE WHEN "Bachelor's degree" ~ '^\d+$' THEN CAST("Bachelor's degree" AS INT) ELSE 0 END) +
           SUM(CASE WHEN "Master's degree" ~ '^\d+$' THEN CAST("Master's degree" AS INT) ELSE 0 END) +
           SUM(CASE WHEN "Professional school degree" ~ '^\d+$' THEN CAST("Professional school degree" AS INT) ELSE 0 END) +
           SUM(CASE WHEN "Doctorate degree" ~ '^\d+$' THEN CAST("Doctorate degree" AS INT) ELSE 0 END) AS Degree_acquired
    FROM education2
    GROUP BY ZIPCODE
) AS education_by_zip
JOIN
(
    SELECT zip, AVG(score) AS AVG_SCORE
    FROM inspections1
    WHERE score IS NOT NULL
    GROUP BY ZIP
) AS AVG_score
ON education_by_zip.ZIPCODE = AVG_score.zip
ORDER BY AVG_SCORE DESC;
----------
SELECT DISTINCT ZIPCODE, SUM(CAST("$75,000 to $99,999" AS INT))+ SUM(CAST("$100,000 TO $124,999" AS INT))+
SUM(CAST("$125,000 TO $149,999 AS INT))+SUM(CAST("$150,000 to $199,999" AS INT))+ SUM(CAST("$200,000 or more" AS INT))AS "$75K or more"
FROM education2;

SELECT DISTINCT ZIPCODE,
       SUM(CAST("$75,000 to $99,999" AS INT)) + 
       SUM(CAST("$100,000 TO $124,999" AS INT)) +
       SUM(CAST("$125,000 TO $149,999" AS INT)) +
       SUM(CAST("$150,000 to $199,999" AS INT)) +
       SUM(CAST("$200,000 or more" AS INT)) AS "$75K or more"
FROM householdincome

SELECT DISTINCT ZIPCODE,
       SUM(CAST("$75,000 to $99,999" AS INT)) + 
       SUM(CAST("$100,000 TO $124,999" AS INT)) +
       SUM(CAST("$125,000 TO $149,999" AS INT)) +
       SUM(CAST("$150,000 to $199,999" AS INT)) +
       SUM(CAST("$200,000 or more" AS INT)) AS "$75K or more"
FROM householdincome;

SELECT DISTINCT ZIPCODE,
       SUM(CAST(householdincome."$75,000 to $99,999" AS INT)) + 
       SUM(CAST(householdincome."$100,000 TO $124,999" AS INT)) +
       SUM(CAST(householdincome."$125,000 TO $149,999" AS INT)) +
       SUM(CAST(householdincome."$150,000 to $199,999" AS INT)) +
       SUM(CAST(householdincome."$200,000 or more" AS INT)) AS "$75K or more"
FROM householdincome
GROUP BY ZIPCODE;





SELECT  DISTINCT ZIPCODE,
       SUM(CASE WHEN householdincome."$75,000 to $99,999" ~ '^\d+$' THEN CAST(householdincome."$75,000 to $99,999" AS INT) ELSE 0 END) + 
       SUM(CASE WHEN householdincome."$100,000 to $124,999" ~ '^\d+$' THEN CAST(householdincome."$100,000 to $124,999" AS INT) ELSE 0 END) +
       SUM(CASE WHEN householdincome."$125,000 to $149,999" ~ '^\d+$' THEN CAST(householdincome."$125,000 to $149,999" AS INT) ELSE 0 END) +
       SUM(CASE WHEN householdincome."$150,000 to $199,999" ~ '^\d+$' THEN CAST(householdincome."$150,000 to $199,999" AS INT) ELSE 0 END) +
       SUM(CASE WHEN householdincome."$200,000 or more" ~ '^\d+$' THEN CAST(householdincome."$200,000 or more" AS INT) ELSE 0 END) AS "$75K or more"
FROM householdincome
GROUP BY ZIPCODE;


SELECT DISTINCT zip, AVG(score)
FROM inspections1
WHERE score IS NOT NULL
GROUP BY ZIP
ORDER BY AVG(SCORE), ZIP DESC;


SELECT income_by_zip.ZIPCODE, income_by_zip."$75K or more", AVG_score.AVG_SCORE
FROM
(
    SELECT ZIPCODE,
       SUM(CASE WHEN householdincome."$75,000 to $99,999" ~ '^\d+$' THEN CAST(householdincome."$75,000 to $99,999" AS INT) ELSE 0 END) + 
       SUM(CASE WHEN householdincome."$100,000 to $124,999" ~ '^\d+$' THEN CAST(householdincome."$100,000 to $124,999" AS INT) ELSE 0 END) +
       SUM(CASE WHEN householdincome."$125,000 to $149,999" ~ '^\d+$' THEN CAST(householdincome."$125,000 to $149,999" AS INT) ELSE 0 END) +
       SUM(CASE WHEN householdincome."$150,000 to $199,999" ~ '^\d+$' THEN CAST(householdincome."$150,000 to $199,999" AS INT) ELSE 0 END) +
       SUM(CASE WHEN householdincome."$200,000 or more" ~ '^\d+$' THEN CAST(householdincome."$200,000 or more" AS INT) ELSE 0 END) AS "$75K or more"
    FROM householdincome
    GROUP BY ZIPCODE
) AS income_by_zip
JOIN
(
    SELECT zip, AVG(score) AS AVG_SCORE
    FROM inspections1
    WHERE score IS NOT NULL
    GROUP BY ZIP
) AS AVG_score
ON income_by_zip.ZIPCODE = AVG_score.zip
ORDER BY AVG_SCORE DESC;


SELECT ZIPCODE,
       SUM(CASE WHEN householdincome."Less than $10,000" ~ '^\d+$' THEN CAST(householdincome."Less than $10,000" AS INT) ELSE 0 END) + 
       SUM(CASE WHEN householdincome."$10,000 to $14,999" ~ '^\d+$' THEN CAST(householdincome."$10,000 to $14,999"  AS INT) ELSE 0 END) +
       SUM(CASE WHEN householdincome."$15,000 to $19,999" ~ '^\d+$' THEN CAST(householdincome."$15,000 to $19,999"  AS INT) ELSE 0 END) +
       SUM(CASE WHEN householdincome."$20,000 to $24,999" ~ '^\d+$' THEN CAST(householdincome."$20,000 to $24,999" AS INT) ELSE 0 END) +
       SUM(CASE WHEN householdincome."$25,000 to $29,999" ~ '^\d+$' THEN CAST("$25,000 to $29,999" AS INT) ELSE 0 END) + 
	   SUM(CASE WHEN householdincome."$30,000 to $34,999" ~ '^\d+$' THEN CAST(householdincome."$30,000 to $34,999" AS INT) ELSE 0 END)+ 
	   SUM(CASE WHEN householdincome."$35,000 to $39,999" ~ '^\d+$' THEN CAST("$35,000 to $39,999" AS INT) ELSE 0 END) +
	   SUM(CASE WHEN householdincome."$40,000 to $44,999" ~ '^\d+$' THEN CAST("$40,000 to $44,999" AS INT) ELSE 0 END)   AS "$45K or less"
FROM householdincome
GROUP BY ZIPCODE;

SELECT income_by_zip.ZIPCODE, income_by_zip."$45K or less", AVG_score.AVG_SCORE
FROM
(
    SELECT ZIPCODE,
           SUM(CASE WHEN householdincome."Less than $10,000" ~ '^\d+$' THEN CAST(householdincome."Less than $10,000" AS INT) ELSE 0 END) + 
           SUM(CASE WHEN householdincome."$10,000 to $14,999" ~ '^\d+$' THEN CAST(householdincome."$10,000 to $14,999" AS INT) ELSE 0 END) +
           SUM(CASE WHEN householdincome."$15,000 to $19,999" ~ '^\d+$' THEN CAST(householdincome."$15,000 to $19,999" AS INT) ELSE 0 END) +
           SUM(CASE WHEN householdincome."$20,000 to $24,999" ~ '^\d+$' THEN CAST(householdincome."$20,000 to $24,999" AS INT) ELSE 0 END) +
           SUM(CASE WHEN householdincome."$25,000 to $29,999" ~ '^\d+$' THEN CAST(householdincome."$25,000 to $29,999" AS INT) ELSE 0 END) + 
           SUM(CASE WHEN householdincome."$30,000 to $34,999" ~ '^\d+$' THEN CAST(householdincome."$30,000 to $34,999" AS INT) ELSE 0 END) + 
           SUM(CASE WHEN householdincome."$35,000 to $39,999" ~ '^\d+$' THEN CAST(householdincome."$35,000 to $39,999" AS INT) ELSE 0 END) + 
           SUM(CASE WHEN householdincome."$40,000 to $44,999" ~ '^\d+$' THEN CAST(householdincome."$40,000 to $44,999" AS INT) ELSE 0 END) AS "$45K or less"
    FROM householdincome
    GROUP BY ZIPCODE
) AS income_by_zip
JOIN
(
    SELECT zip, AVG(score) AS AVG_SCORE
    FROM inspections1
    WHERE score IS NOT NULL
    GROUP BY ZIP
) AS AVG_score
ON income_by_zip.ZIPCODE = AVG_score.zip
ORDER BY AVG_SCORE DESC;



SELECT ZIPCODE, "$45K or less" AS "Lower Income Households", AVG_SCORE AS "Average Inspection Score"
FROM
(
    SELECT income_by_zip.ZIPCODE, income_by_zip."$45K or less", AVG_score.AVG_SCORE
    FROM
    (
        SELECT ZIPCODE,
               SUM(CASE WHEN householdincome."Less than $10,000" ~ '^\d+$' THEN CAST(householdincome."Less than $10,000" AS INT) ELSE 0 END) + 
               SUM(CASE WHEN householdincome."$10,000 to $14,999" ~ '^\d+$' THEN CAST(householdincome."$10,000 to $14,999" AS INT) ELSE 0 END) +
               SUM(CASE WHEN householdincome."$15,000 to $19,999" ~ '^\d+$' THEN CAST(householdincome."$15,000 to $19,999" AS INT) ELSE 0 END) +
               SUM(CASE WHEN householdincome."$20,000 to $24,999" ~ '^\d+$' THEN CAST(householdincome."$20,000 to $24,999" AS INT) ELSE 0 END) +
               SUM(CASE WHEN householdincome."$25,000 to $29,999" ~ '^\d+$' THEN CAST(householdincome."$25,000 to $29,999" AS INT) ELSE 0 END) + 
               SUM(CASE WHEN householdincome."$30,000 to $34,999" ~ '^\d+$' THEN CAST(householdincome."$30,000 to $34,999" AS INT) ELSE 0 END) + 
               SUM(CASE WHEN householdincome."$35,000 to $39,999" ~ '^\d+$' THEN CAST(householdincome."$35,000 to $39,999" AS INT) ELSE 0 END) + 
               SUM(CASE WHEN householdincome."$40,000 to $44,999" ~ '^\d+$' THEN CAST(householdincome."$40,000 to $44,999" AS INT) ELSE 0 END) AS "$45K or less"
        FROM householdincome
        GROUP BY ZIPCODE
    ) AS income_by_zip
    JOIN
    (
        SELECT zip, AVG(score) AS AVG_SCORE
        FROM inspections1
        WHERE score IS NOT NULL
        GROUP BY ZIP
    ) AS AVG_score
    ON income_by_zip.ZIPCODE = AVG_score.zip
) AS result_table
ORDER BY "Lower Income Households" DESC;




SELECT zipcode, population
FROM zipcodepop
WHERE zipcode IS NOT NULL
  AND population IS NOT NULL;
  
  
SELECT zipcodepop.zipcode, zipcodepop.population, AVG(inspections1.score) AS avg_score
FROM zipcodepop
JOIN (
    SELECT zip, AVG(score) AS score
    FROM inspections1
    WHERE score IS NOT NULL
    GROUP BY zip
) AS inspections1 ON zipcodepop.zipcode = inspections1.zip
GROUP BY zipcodepop.zipcode, zipcodepop.population
ORDER BY zipcodepop.population DESC;




SELECT  DISTINCT ZIPCODE,
       SUM(CASE WHEN race."Black or African American alone" ~ '^\d+$' THEN CAST( race."Black or African American alone"AS INT) ELSE 0 END) + 
       SUM(CASE WHEN race."American Indian and Alaska Native alone" ~ '^\d+$' THEN CAST(race."American Indian and Alaska Native alone" AS INT) ELSE 0 END) +
       SUM(CASE WHEN race."Asian alone" ~ '^\d+$' THEN CAST( race."Asian alone"  AS INT) ELSE 0 END) +
       SUM(CASE WHEN race."Native Hawaiian and Other Pacific Islander alone" ~ '^\d+$' THEN CAST( race."Native Hawaiian and Other Pacific Islander alone" AS INT) ELSE 0 END)  AS "Minority_Groups"
FROM race
GROUP BY ZIPCODE;




SELECT race_by_zip.ZIPCODE, 
       race_by_zip."White_Alone", 
       race_by_zip."Minority_Groups", 
       AVG_score.AVG_SCORE
FROM
(
    SELECT ZIPCODE,
           SUM(CASE WHEN race."Black or African American alone" ~ '^\d+$' THEN CAST(race."Black or African American alone" AS INT) ELSE 0 END) + 
           SUM(CASE WHEN race."American Indian and Alaska Native alone" ~ '^\d+$' THEN CAST(race."American Indian and Alaska Native alone" AS INT) ELSE 0 END) +
           SUM(CASE WHEN race."Asian alone" ~ '^\d+$' THEN CAST(race."Asian alone" AS INT) ELSE 0 END) +
           SUM(CASE WHEN race."Native Hawaiian and Other Pacific Islander alone" ~ '^\d+$' THEN CAST(race."Native Hawaiian and Other Pacific Islander alone" AS INT) ELSE 0 END) AS "Minority_Groups",
           SUM(CASE WHEN race."White alone" ~ '^\d+$' THEN CAST(race."White alone" AS INT) ELSE 0 END) AS "White_Alone"
    FROM race
    GROUP BY ZIPCODE
) AS race_by_zip
JOIN
(
    SELECT zip, AVG(score) AS AVG_SCORE
    FROM inspections1
    WHERE score IS NOT NULL
    GROUP BY ZIP
) AS AVG_score
ON race_by_zip.ZIPCODE = AVG_score.zip
ORDER BY AVG_SCORE DESC;


#Converting values into percetanges 
SELECT
    "Regular high school", 
    "GED or alternative credential", 
	"Some college, less than 1 year",
	"Some 
    (value / total) * 100 AS percentage
FROM
    (
        SELECT
            column1,
            column2,
            value,
            (SELECT SUM(value) FROM education2) AS total
        FROM
            education2
    ) AS newracetable;




----- JOINING TABLES TO ZIP CODE TOTAL POPULATION ------
SELECT zipcode, population
FROM zipcodepop
WHERE zipcode IS NOT NULL
  AND population IS NOT NULL;


SELECT
    r.ZIPCODE,
    r."White_Alone",
	--r.Not_white_alone,
	CAST(z.population AS int )- r."White_Alone" as "Not_White_alone",
    CAST(z.population AS int),
    CASE WHEN z.population <> '0' AND z.population ~ '^\d+$'
         THEN (r."White_Alone"::numeric / CAST(REPLACE(z.population, ',', '') AS numeric)) * 100
         ELSE NULL
    END AS white_percentage,
 --   CASE WHEN z.population <> '0' AND z.population ~ '^\d+$'
     --    THEN (r."Minority_Groups"::numeric / CAST(REPLACE(z.population, ',', '') AS numeric)) * 100
      --   ELSE NULL
  --  END AS minority_percentage,
   CASE WHEN z.population <> '0' AND z.population ~ '^\d+$'
         THEN ((CAST(z.population AS int )- r."White_Alone")::numeric / CAST(REPLACE(z.population, ',', '') AS numeric)) * 100
         ELSE NULL
    END AS not_white_alone_percentage,
    AVG_score.AVG_SCORE
FROM
    (
        SELECT ZIPCODE,
         SUM(CASE WHEN race."White alone" ~ '^\d+$' THEN CAST(race."White alone" AS INT) ELSE 0 END) AS "White_Alone"
        FROM
            race
        GROUP BY
            ZIPCODE
    ) AS r
JOIN
    (
        SELECT
            zip,
            AVG(score) AS AVG_SCORE
        FROM
            inspections1
        WHERE
            score IS NOT NULL
        GROUP BY
            zip
    ) AS AVG_score ON r.ZIPCODE = AVG_score.zip
JOIN
    zipcodepop AS z ON r.ZIPCODE = z.zipcode
WHERE
    z.zipcode IS NOT NULL
    AND z.population IS NOT NULL
ORDER BY
    AVG_SCORE DESC;
	
	
SELECT zipcode, "60k_and_higher"
FROM higherincomehousehold;
**JOINING TABLES TOGETHER TO GET AVG SCORE FOR EACH ZIPCODE**
SELECT AVG(score), zip
FROM inspections1
WHERE score IS NOT NULL
GROUP BY ZIP;
***JOIN***
SELECT h.zipcode,
	h."60k_and_higher",
	i.avg_score
FROM (
	SELECT zipcode, "60k_and_higher"
	FROM higherincomehousehold
) AS h
JOIN (
	SELECT AVG(score) AS avg_score, zip
	FROM inspections1
	WHERE score IS NOT NULL
GROUP BY zip
) as i on h.zipcode = i.zip;
------------ERROR MSG: USE CAST-------------
SELECT h.zipcode, h."60k_and_higher", i.avg_score
FROM (
    SELECT zipcode, "60k_and_higher"
    FROM higherincomehousehold
) AS h
JOIN (
    SELECT AVG(score) AS avg_score, CAST(zip AS NUMERIC) AS zipcode
    FROM inspections1
    WHERE score IS NOT NULL
    GROUP BY zip
) AS i ON h.zipcode = i.zipcode;
---- changing to %------
SELECT h.zipcode, (h."60k_and_higher"/ total_households) * 100 AS "60k_and_higher_percentage", i.avg_score
FROM (
SELECT zipcode, "60k_and_higher", (SELECT SUM("60k_and_higher") FROM higherincomehousehold) AS total_households
FROM higherincomehousehold
) AS h 
JOIN (
 SELECT AVG(score) AS avg_score, CAST(zip as NUMERIC) AS zipcode
	FROM inspections1
	WHERE score IS NOT NULL
	GROUP BY zip
) AS i ON h.zipcode = i.zipcode;
---------JOINING TO AVG SCORE FOR EACH ZIPCODE---------------------
SELECT l.zipcode, l."59k_and_lower", i.avg_score
FROM (
    SELECT zipcode, "59k_and_lower"
    FROM lowerincomehousehold
) AS l
JOIN (
    SELECT AVG(score) AS avg_score, CAST(zip AS NUMERIC) AS zipcode
    FROM inspections1
    WHERE score IS NOT NULL
    GROUP BY zip
) AS i ON l.zipcode = i.zipcode;

---- made new column for total households in first query, selected both columns (59k_and_lower,60k_and_higher), join those two queries together and then join the resulting data of that query to the subquery that calculates avg score. last step: calculated percentages for each income bracket based on the total number of households and select their average score for each zipcode ----
SELECT l.zipcode, 
       l."59k_and_lower" AS "59k_and_lower_count", 
       h."60k_and_higher" AS "60k_and_higher_count",
       (l."59k_and_lower" + h."60k_and_higher") AS "total_households",
       CASE 
           WHEN (l."59k_and_lower" + h."60k_and_higher") = 0 THEN NULL
           ELSE (l."59k_and_lower" / (l."59k_and_lower" + h."60k_and_higher")) * 100 
       END AS "59k_and_lower_percentage",
       CASE 
           WHEN (l."59k_and_lower" + h."60k_and_higher") = 0 THEN NULL
           ELSE (h."60k_and_higher" / (l."59k_and_lower" + h."60k_and_higher")) * 100 
       END AS "60k_and_higher_percentage",
       i.avg_score
FROM (
    SELECT zipcode, "59k_and_lower"
    FROM lowerincomehousehold
) AS l
JOIN (
    SELECT zipcode, "60k_and_higher"
    FROM higherincomehousehold
) AS h ON l.zipcode = h.zipcode
JOIN (
    SELECT AVG(score) AS avg_score, CAST(zip AS NUMERIC) AS zipcode
    FROM inspections1
    WHERE score IS NOT NULL
    GROUP BY zip
) AS i ON l.zipcode = i.zipcode;

----- Turning Degreed residents and resident W/O a degree values into a percentage (USE CAST to convert to a float)----
SELECT e.ZIPCODE,
       e.No_Degree_acquired,
       education_by_zip.Degree_acquired,
       (e.No_Degree_acquired + education_by_zip.Degree_acquired) AS Total_Residents,
       AVG_score.AVG_SCORE,
       CASE 
    WHEN (e.No_Degree_acquired + education_by_zip.Degree_acquired) = 0 THEN NULL
    ELSE (CAST(e.No_Degree_acquired AS FLOAT) / (e.No_Degree_acquired + education_by_zip.Degree_acquired)) * 100 
END AS "No_Degree_acquired_percentage",
       CASE 
           WHEN (e.No_Degree_acquired + education_by_zip.Degree_acquired) = 0 THEN NULL
           ELSE (CAST(education_by_zip.Degree_acquired AS FLOAT) / (e.No_Degree_acquired + education_by_zip.Degree_acquired)) * 100 
END AS "Degree_acquired_percentage"

FROM
(
    SELECT DISTINCT ZIPCODE,
    SUM(CASE WHEN "Regular high school diploma" ~ '^\d+$' THEN CAST("Regular high school diploma" AS INT) ELSE 0 END) + 
	SUM(CASE WHEN "GED or alternative credential" ~ '^\d+$' THEN CAST("GED or alternative credential" AS INT) ELSE 0 END) + 
	SUM(CASE WHEN "Some college, less than 1 year" ~ '^\d+$' THEN CAST("Some college, less than 1 year" AS INT) ELSE 0 END) AS No_Degree_acquired
    FROM education2
    GROUP BY ZIPCODE
) AS e
LEFT JOIN
(
    SELECT ZIPCODE,
           SUM(CASE WHEN "Associate's degree" ~ '^\d+$' THEN CAST("Associate's degree" AS INT) ELSE 0 END) +
           SUM(CASE WHEN "Bachelor's degree" ~ '^\d+$' THEN CAST("Bachelor's degree" AS INT) ELSE 0 END) +
           SUM(CASE WHEN "Master's degree" ~ '^\d+$' THEN CAST("Master's degree" AS INT) ELSE 0 END) +
           SUM(CASE WHEN "Professional school degree" ~ '^\d+$' THEN CAST("Professional school degree" AS INT) ELSE 0 END) +
           SUM(CASE WHEN "Doctorate degree" ~ '^\d+$' THEN CAST("Doctorate degree" AS INT) ELSE 0 END) AS Degree_acquired
    FROM education2
    GROUP BY ZIPCODE
) AS education_by_zip ON e.ZIPCODE = education_by_zip.ZIPCODE
JOIN
(
    SELECT zip, AVG(score) AS AVG_SCORE
    FROM inspections1
    WHERE score IS NOT NULL
    GROUP BY ZIP
) AS AVG_score ON e.ZIPCODE = AVG_score.zip
WHERE AVG_score.AVG_SCORE IS NOT NULL;
*** query originally outputed 0 as the percentages for each zip code so had to CAST integers as a float***
------- CALCULATING TOTAL POP OF AGES AND TURNING VALUES INTO PERCENTAGES------
ALTER TABLE agegroups ADD COLUMN total_population NUMERIC;
UPDATE agegroups
SET total_population = "18 to 29 years" + "30 to 49 years" + "50 to 74 years" + "75 and over";
UPDATE agegroups
SET "18 to 29 years"= ("18 to 29 years" * 100.0) / total_population,
    "30 to 49 years"= ("30 to 49 years"* 100.0) / total_population,
    "50 to 74 years"= ("50 to 74 years" * 100.0) / total_population,
    "75 and over"= ("75 and over"* 100.0) / total_population;

UPDATE agegroups
SET "18 to 29 years" = CASE WHEN total_population = 0 THEN 0 ELSE ("18 to 29 years" * 100.0) / total_population END,
    "30 to 49 years" = CASE WHEN total_population = 0 THEN 0 ELSE ("30 to 49 years" * 100.0) / total_population END,
    "50 to 74 years" = CASE WHEN total_population = 0 THEN 0 ELSE ("50 to 74 years" * 100.0) / total_population END,
   "75 and over" = CASE WHEN total_population = 0 THEN 0 ELSE ("75 and over" * 100.0) / total_population END;
   
  
  
SELECT AVG(score), zip
FROM inspections1
WHERE score IS NOT NULL
GROUP BY ZIP;

SELECT complete_table.average_score,
       agegroups.*
FROM (
    SELECT AVG(score) AS average_score,
           zip
    FROM inspections1
    WHERE score IS NOT NULL
    GROUP BY zip
) AS complete_table
INNER JOIN agegroups ON complete_table.zip = agegroups.zipcode;