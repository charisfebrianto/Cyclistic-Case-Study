-- Count the record of data
SELECT COUNT(*) total_data FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_data`; -- has a 3.829.014 rows

-- Looking for data duplicates
SELECT COUNT (*) - COUNT(DISTINCT trip_id) trip_id -- only the trip_id column must be unique
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_data`; -- has a 11 duplicate data

-- looking for the missing value of each columns
SELECT COUNT(*) - COUNT(trip_id) trip_id,
 COUNT(*) - COUNT(start_time) start_time,
 COUNT(*) - COUNT(end_time) end_time,
 COUNT(*) - COUNT(bikeid) bikeid, 
 COUNT(*) - COUNT(tripduration) tripduration,   
 COUNT(*) - COUNT(from_station_id) from_station_id,
 COUNT(*) - COUNT(from_station_name) from_station_name,
 COUNT(*) - COUNT(to_station_id) to_station_id,
 COUNT(*) - COUNT(to_station_name) to_station_name,
 COUNT(*) - COUNT(usertype) usertype,
 COUNT(*) - COUNT(gender) gender, -- has 78580 missing values
 COUNT(*) - COUNT(birthyear) birthyear -- has 836758 missing values
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_data`;


-- THEN I WILL CHECK SEVERAL COLUMN FROM THE LEFT TO THE RIGHT

-- 1) Ensure the trip_id length has a same length as the others
SELECT LENGTH(CAST(trip_id AS STRING)) trip_id_str
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_data`
GROUP BY 1;
-- has a consistent length with 8 char


-- 2) Ensure the length of bikeid
SELECT LENGTH(CAST(bikeid AS STRING)) bikeid_character, COUNT(bikeid) bikeid_total
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_data`
GROUP BY 1
ORDER BY 1 ASC;
-- there are 4,3,2, and 1 character length


-- 3) Check the tripduration column
SELECT MIN(tripduration) min_duration, MAX(tripduration) max_duration
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_data`;
-- the min is 60 sec (1 minute), the max is 86338 sec (almost 24 hours)

-- Check the outliers of tripduration
WITH MedTripDuration AS (  
  SELECT
    PERCENTILE_CONT(tripduration, 0.25) OVER() AS q1,
    PERCENTILE_CONT(tripduration, 0.50) OVER() AS median,
    PERCENTILE_CONT(tripduration, 0.75) OVER() AS q3,
    PERCENTILE_CONT(tripduration, 0.75) OVER() - PERCENTILE_CONT(tripduration, 0.25) OVER() AS iqr
  FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_data`
  WHERE tripduration IS NOT NULL
  LIMIT 1)
-- create a distribution table of tripduration
SELECT                                            
  (Q1 - 1.5 * IQR) AS lower_bound,
  Q1, Median, Q3,
  (Q3 + 1.5 * IQR) AS upper_bound,
  iqr
FROM MedTripDuration;
-- I'll remove data that is outside the upper and lower limits in data cleaning


-- 4) Ensure the length of from_station_id
SELECT
LENGTH(CAST(from_station_id AS STRING)) from_station_id_character, 
COUNT(from_station_id) from_station_id_total
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_data`
GROUP BY 1
ORDER BY 1 ASC;
-- there are 3, 2, and 1 character length


-- 5) Ensure the length of to_station_id
SELECT LENGTH(CAST(to_station_id AS STRING)) to_station_id_str, COUNT(to_station_id) to_station_id_total
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_data`     
GROUP BY 1
ORDER BY 1 ASC;
-- there are 3, 2, and 1 character length


-- 6) Ensure the segmentatin of user_type
SELECT usertype, COUNT(usertype) usertype_total
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_data`
GROUP BY 1;  
-- three types of usertype: dependent, subscriber, and customer (no inconsistent data)


-- 7) Check Gender column
SELECT gender, COUNT(gender) total
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_data`
GROUP BY 1; 
-- There is inconsistent data, those are null and empty string besides 'Male' and'Female'

-- because i got inconsistent data, we must check the real missing values first
SELECT COUNT(*) missing_gender
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_data`
WHERE gender IS NULL OR TRIM(gender) = ''; -- we got 836827 missing values on gender

-- Ensure the gender based on usertype
SELECT 
  usertype, 
    CASE 
    WHEN gender IS NULL OR gender = '' THEN 'Null/Empty Data'
    ELSE 'Filled Data'
  END AS gender_status,
  COUNT(*) AS total_trips,
  ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS total_percentage
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_data`
GROUP BY usertype, gender_status
ORDER BY usertype, total_trips DESC;
/*
Many Null/Empty Data in Customer, while in Subscriber data was filled, I will handle it with give the label 'Unknown' on it
*/


-- 8) Check Birthyear column
SELECT MIN(birthyear) birthyear_min, MAX(birthyear) birthyear_max
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_data`;
-- 1899 is a minimum and 2017 is a maximum

SELECT COUNT(*) missing_birthyear
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_data`
WHERE birthyear IS NULL;
-- then missing values in birthyear column is 836758 

-- Looking for the outliers of birthyear
WITH Quartiles AS (  
  SELECT
    PERCENTILE_CONT(birthyear, 0.25) OVER() AS q1,
    PERCENTILE_CONT(birthyear, 0.50) OVER() AS median,
    PERCENTILE_CONT(birthyear, 0.75) OVER() AS q3,
    PERCENTILE_CONT(birthyear, 0.75) OVER() - PERCENTILE_CONT(birthyear, 0.25) OVER() AS iqr
  FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_data`
  WHERE birthyear IS NOT NULL
  LIMIT 1)
-- create a distribution table of birthyear
SELECT                                            
  (Q1 - 1.5 * IQR) AS lower_bound,
  Q1, Median, Q3,
  (Q3 + 1.5 * IQR) AS upper_bound,
  iqr
FROM Quartiles;

-- Count Outliers of Birthyear
SELECT 
  COUNTIF(birthyear < 1955) AS elderly_number,    
  COUNTIF(birthyear > 2011) AS children_number,
  COUNT(*) total_origin_data
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_data`;
-- There are 60647 data (1.58%) identified as outliers.


-- Last Validation: Distribution check
SELECT ROUND(AVG(birthyear), 2) mean_birthyear
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_data`
WHERE birthyear BETWEEN 1955 AND 2011;
-- median = 1985, mean before filtering = 1981, after filtering = 1982
-- After being cleaned or filtered, the mean value is close to the median, this means that the data is distributed much more normally
