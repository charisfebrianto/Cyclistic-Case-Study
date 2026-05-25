CREATE OR REPLACE TABLE `steadfast-sound-480713-j1.cyclistic.cyclistic_cleaned` AS (

WITH 
-- 1. Count for Outlier and Median of birthyear and tripduration column
Stats AS (
  SELECT 
    PERCENTILE_CONT(birthyear, 0.25) OVER() AS b_q1,
    PERCENTILE_CONT(birthyear, 0.75) OVER() AS b_q3,
    CAST(PERCENTILE_CONT(birthyear, 0.5) OVER() AS INT64) AS b_median,
    PERCENTILE_CONT(tripduration, 0.25) OVER() AS t_q1,
    PERCENTILE_CONT(tripduration, 0.75) OVER() AS t_q3
  FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_data`
  WHERE birthyear IS NOT NULL 
  LIMIT 1
),

-- 2. Determine the upper and lower limit of birthyear and tripduration
Bounds AS (
  SELECT 
    b_median,
    (b_q1 - 1.5 * (b_q3 - b_q1)) AS b_lower,        
    (b_q3 + 1.5 * (b_q3 - b_q1)) AS b_upper,
    (t_q1 - 1.5 * (t_q3 - t_q1)) AS t_lower,
    (t_q3 + 1.5 * (t_q3 - t_q1)) AS t_upper
  FROM Stats
),

-- 3. Remove duplicates based on trip_id
DeDuplicated AS (
  SELECT 
    *,
    ROW_NUMBER() OVER(PARTITION BY trip_id ORDER BY start_time) as row_num
  FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_data`
)

-- 4. Final Selection with the new column
SELECT 
  * EXCEPT(row_num, birthyear, gender, tripduration),
  
  -- A. Fixing birthyear (Impute the median on null and outlier)
  CASE 
    WHEN birthyear IS NULL THEN (SELECT b_median FROM Bounds)
    WHEN birthyear < (SELECT b_lower FROM Bounds) OR birthyear > (SELECT b_upper FROM Bounds) 
      THEN (SELECT b_median FROM Bounds)
    ELSE birthyear 
  END AS birthyear_cleaned,

  -- B. New column: Age
  (2017 - CASE 
    WHEN birthyear IS NULL THEN (SELECT b_median FROM Bounds)
    WHEN birthyear < (SELECT b_lower FROM Bounds) OR birthyear > (SELECT b_upper FROM Bounds) 
      THEN (SELECT b_median FROM Bounds)
    ELSE birthyear 
  END) AS age,

  -- C. Impute 'Unknown' for the null values and empty string on gender
  CASE 
    WHEN gender IS NULL OR gender = '' THEN 'Unknown'
    ELSE gender 
  END AS gender_cleaned,

  -- D. Extracting time
  EXTRACT(MONTH FROM start_time) AS ride_month,
  EXTRACT(HOUR FROM start_time) AS ride_hour,
  EXTRACT(DAYOFWEEK FROM start_time) AS day_of_week, -- Tambahan: Hari dalam seminggu

  -- E. Filtered tripduration
  tripduration

FROM DeDuplicated
WHERE 
  row_num = 1 
  AND end_time > start_time
  AND tripduration BETWEEN (SELECT t_lower FROM Bounds) AND (SELECT t_upper FROM Bounds)
  AND tripduration >= 60 -- tripduration is more than 1 minute
)