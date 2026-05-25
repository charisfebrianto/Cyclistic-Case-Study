/*
Key Question
How do annual members and casual riders use Cyclistic bikes differently?
*/

-- Cleaned number of rows
SELECT COUNT(*) cleaned_user_total
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_cleaned`; -- 3.491.006 rows

-- Number of users
SELECT usertype, COUNT(usertype) user_numbers, 
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as users_percentage
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_cleaned`
WHERE  usertype IN('Customer', 'Subscriber')
GROUP BY 1
ORDER BY user_numbers DESC;

-- Min, Avg, Max of tripduration based on usertype
SELECT 
usertype, 
MIN(tripduration / 60) min_duration,
ROUND(AVG(tripduration / 60), 2) avg_duration,  
ROUND(MAX(tripduration / 60), 2) max_duration 
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_cleaned`
WHERE usertype IN ('Customer', 'Subscriber')
GROUP BY 1;

-- Total Users and Avg Duration by Peak Hours
SELECT 
  usertype,
  ride_hour,
  COUNT(*) AS total_trips,
  ROUND(AVG(tripduration) / 60, 2) avg_tripduration
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_cleaned`
WHERE usertype IN ('Customer', 'Subscriber')
GROUP BY usertype, ride_hour
ORDER BY ride_hour;

-- Total user and Avg duration by Day of Week
SELECT 
usertype, 
day_of_week,
COUNT(*) total_trips,
ROUND(AVG(tripduration) / 60, 2) avg_tripduration
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_cleaned`
WHERE usertype IN ('Customer', 'Subscriber')
GROUP BY 1,2
ORDER BY 2 ASC;

-- Total Trips and Avg Duration by Month
SELECT
usertype, 
ride_month,
COUNT(*) total_trips,
ROUND(AVG(tripduration) / 60, 2) avg_tripduration
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_cleaned`
WHERE usertype IN ('Customer', 'Subscriber')
GROUP BY 1, 2
ORDER BY 2, 1 ASC;

-- Age segmentation
SELECT 
usertype, 
CASE
  WHEN age < 25 THEN 'Gen Z'
  WHEN age BETWEEN 25 AND 40 THEN 'Millenials'
  WHEN age BETWEEN 41 AND 55 THEN 'Gen X'
  ELSE 'Boomers'
END AS age_group,
COUNT(*) total_user,
ROUND(AVG(tripduration) / 60, 2) avg_tripduration_in_minute
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_cleaned`
WHERE usertype IN('Customer', 'Subscriber')
GROUP BY 1, age_group
ORDER BY 1 ASC, total_user DESC;


-- Top 3 Departure Station of each usertype
WITH StationCounts AS (
-- Step 1: Calculate the number of trips per station for each user type.
  SELECT 
    usertype,
    from_station_name,
    COUNT(*) AS num_of_trips
  FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_cleaned`
  GROUP BY usertype, from_station_name
),
RankedStations AS (
  -- Step 2: Assign row numbers based on the highest number of trips.
  -- PARTITION BY will separate the calculation between Customer and Subscriber
  SELECT 
    usertype,
    from_station_name,
    num_of_trips,
    ROW_NUMBER() OVER(
      PARTITION BY usertype 
      ORDER BY num_of_trips DESC
    ) AS ranking
  FROM StationCounts
)
-- Step 3: Filter to only take sequences 1, 2, and 3
SELECT 
  usertype,
  ranking,
  from_station_name,
  num_of_trips
FROM RankedStations
WHERE ranking <= 3 AND usertype IN ('Customer', 'Subscriber')
ORDER BY 1, 2;


-- Top 3 Destination Station of each usertype
WITH StationCounts AS (
  -- Step 1: Calculate the number of trips per station for each user type.
  SELECT 
    usertype,
    to_station_name,
    COUNT(*) AS num_of_trips
  FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_cleaned`
  GROUP BY 1, 2
),
RankedStations AS (
  -- Step 2: Assign row numbers based on the highest number of trips
  -- PARTITION BY will separate the calculation between Customer and Subscriber
  SELECT 
    usertype,
    to_station_name,
    num_of_trips,
    ROW_NUMBER() OVER(
      PARTITION BY usertype 
      ORDER BY num_of_trips DESC
    ) AS ranking
  FROM StationCounts
)
-- Step 3: Filter to only take sequences 1, 2, and 3
SELECT 
  usertype,
  ranking,
  to_station_name,
  num_of_trips
FROM RankedStations
WHERE ranking <= 3 AND usertype IN ('Customer', 'Subscriber')
ORDER BY usertype, ranking;



-- CORRELATION BY SEASON
WITH SeasonalDailyStats AS (
  -- Step 1: Calculate daily statistics and determine the season
  SELECT 
    CASE 
      WHEN ride_month IN (12, 1, 2) THEN 'Winter'
      WHEN ride_month IN (3, 4, 5) THEN 'Spring'
      WHEN ride_month IN (6, 7, 8) THEN 'Summer'
      WHEN ride_month IN (9, 10, 11) THEN 'Fall'
    END AS season,
    DATE(start_time) AS date_trip,
    usertype,
    COUNT(*) AS num_of_trips,
    AVG(tripduration / 60) AS avg_duration
  FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_cleaned`
  WHERE usertype IN ('Subscriber', 'Customer')
  GROUP BY season, date_trip, usertype
)
-- Step 2: Calculate the correlation of volume vs duration for each season.
SELECT 
  season,
  usertype,
  ROUND(CORR(num_of_trips, avg_duration), 5) AS corr_value,
  COUNT(*) AS num_of_sampleday,
  ROUND(AVG(num_of_trips), 0) AS avg_daily_trips,
  ROUND(AVG(avg_duration), 2) AS avg_daily_duration
FROM SeasonalDailyStats
GROUP BY season, usertype
ORDER BY season, usertype;


-- Gender
SELECT 
usertype, 
gender_cleaned,
COUNT(gender_cleaned) num_of_users,
ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) genders_percentage,
FROM `steadfast-sound-480713-j1.cyclistic.cyclistic_cleaned`
WHERE usertype IN ('Customer', 'Subscriber')
GROUP BY 1, 2
ORDER BY 1;


