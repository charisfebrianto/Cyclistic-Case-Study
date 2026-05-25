-- combing data cyclistic from 2017 Q1 till 2017 Q4 into cyclistic_data table
CREATE TABLE `steadfast-sound-480713-j1.cyclistic.cyclistic_data` AS (
  SELECT * FROM `steadfast-sound-480713-j1.cyclistic.data_q1`
  UNION ALL
  SELECT * FROM `steadfast-sound-480713-j1.cyclistic.data_q2`
  UNION ALL
  SELECT * FROM `steadfast-sound-480713-j1.cyclistic.data_q3`
  UNION ALL
  SELECT * FROM `steadfast-sound-480713-j1.cyclistic.data_q4`
);
