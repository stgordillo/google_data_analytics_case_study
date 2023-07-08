-- Each query I used during this project.  I've headed each query chunk with the question I asked myself before creating it

/* 1. How many users are unique for each dataset?
I decided to use COUNT, DISTINCT and FULL JOIN in order to find the unique number of users from the id column. */
SELECT COUNT (DISTINCT daily_activity_merged.id) AS activity_id, COUNT(DISTINCT sleep_day_merged.id) AS sleep_id, COUNT(DISTINCT weight_log_info_merged.id) AS weight_id, COUNT(DISTINCT hourly_steps_merged.id) AS steps_id
FROM fitbit-391618.fitness.daily_activity_merged
FULL JOIN fitness.sleep_day_merged ON daily_activity_merged.id = sleep_day_merged.id
FULL JOIN fitness.weight_log_info_merged ON daily_activity_merged.id = weight_log_info_merged.id
FULL JOIN fitness.hourly_steps_merged ON daily_activity_merged.id = hourly_steps_merged.id

/* 2. How many users overlap between the four tables?
Here I use an INNER JOIN in order to count the number of distinct users. */
SELECT COUNT (DISTINCT `fitbit-391618.fitness.daily_activity_merged`.id) AS active_id, COUNT(DISTINCT `fitbit-391618.fitness.sleep_day_merged`.id) AS sleep_id, COUNT(DISTINCT `fitbit-391618.fitness.weight_log_info_merged`.id) AS weight_id, COUNT(DISTINCT `fitbit-391618.fitness.hourly_steps_merged`.id) AS step_id
FROM `fitbit-391618.fitness.daily_activity_merged`
JOIN `fitbit-391618.fitness.sleep_day_merged` ON `fitbit-391618.fitness.daily_activity_merged`.id = `fitbit-391618.fitness.sleep_day_merged`.id
JOIN `fitbit-391618.fitness.weight_log_info_merged` ON `fitbit-391618.fitness.daily_activity_merged`.id = `fitbit-391618.fitness.weight_log_info_merged`.id
JOIN `fitbit-391618.fitness.hourly_steps_merged` ON `fitbit-391618.fitness.daily_activity_merged`.id = `fitbit-391618.fitness.hourly_steps_merged`.id

/* 3. Which users are missing from each table? 
I use a FULL JOIN in order to get the NULLS values to determine the missing users. */
SELECT DISTINCT `fitbit-391618.fitness.daily_activity_merged`.id AS active_id, `fitbit-391618.fitness.sleep_day_merged`.id AS sleep_id, `fitbit-391618.fitness.weight_log_info_merged`.id AS weight_id,`fitbit-391618.fitness.hourly_steps_merged`.id AS step_id
FROM `fitbit-391618.fitness.daily_activity_merged`
FULL JOIN `fitbit-391618.fitness.sleep_day_merged` ON `fitbit-391618.fitness.daily_activity_merged`.id = `fitbit-391618.fitness.sleep_day_merged`.id
FULL JOIN `fitbit-391618.fitness.weight_log_info_merged` ON `fitbit-391618.fitness.daily_activity_merged`.id = `fitbit-391618.fitness.weight_log_info_merged`.id
FULL JOIN `fitbit-391618.fitness.hourly_steps_merged` ON `fitbit-391618.fitness.daily_activity_merged`.id = `fitbit-391618.fitness.hourly_steps_merged`.id

/* 4. Which of the users overlap tables?
Changed FULL to INNER JOIN to exclude the NULLS. 6 users overlap. */
SELECT DISTINCT `fitbit-391618.fitness.daily_activity_merged`.id AS active_id, `fitbit-391618.fitness.sleep_day_merged`.id AS sleep_id, `fitbit-391618.fitness.weight_log_info_merged`.id AS weight_id,`fitbit-391618.fitness.hourly_steps_merged`.id AS step_id
FROM `fitbit-391618.fitness.daily_activity_merged`
JOIN `fitbit-391618.fitness.sleep_day_merged` ON `fitbit-391618.fitness.daily_activity_merged`.id = `fitbit-391618.fitness.sleep_day_merged`.id
JOIN `fitbit-391618.fitness.weight_log_info_merged` ON `fitbit-391618.fitness.daily_activity_merged`.id = `fitbit-391618.fitness.weight_log_info_merged`.id
JOIN `fitbit-391618.fitness.hourly_steps_merged` ON `fitbit-391618.fitness.daily_activity_merged`.id = `fitbit-391618.fitness.hourly_steps_merged`.id

/* 5. What's the average activity from the users?
Used AVG to find average and then GROUP BY and ORDER BY to organize by id */
SELECT id,
 COUNT(id) AS logs,
 AVG(total_steps) AS average_steps,
 AVG(total_distance) AS average_total_distance,
 AVG(very_active_minutes) AS average_very_minutes,
 AVG(fairly_active_minutes) AS average_fairly_minutes,
 AVG(lightly_active_minutes) AS average_lightly_minutes,
 AVG(sedentary_minutes) AS average_sedentary_minutes,
 AVG(calories) AS average_calories
FROM `fitbit-391618.fitness.daily_activity_merged`
GROUP BY id
ORDER BY id

/* 6. What trends can we find from the users based on the day?
I used the EXTRACT to change the DateTime to a day of the week for better readability, then rounded the total time spent active and non-active.  I then used WHERE to make sure my returns were above 0 and ordered by date.*/
SELECT *, 
  CASE
  WHEN EXTRACT(DAYOFWEEK FROM activity_date) = 1 THEN 'Sunday'
  WHEN EXTRACT(DAYOFWEEK FROM activity_date) = 2 THEN 'Monday'
  WHEN EXTRACT(DAYOFWEEK FROM activity_date) = 3 THEN 'Tuesday'
  WHEN EXTRACT(DAYOFWEEK FROM activity_date) = 4 THEN 'Wednesday'
  WHEN EXTRACT(DAYOFWEEK FROM activity_date) = 5 THEN 'Thursday'
  WHEN EXTRACT(DAYOFWEEK FROM activity_date) = 6 THEN 'Friday'
  ELSE 'Saturday' END AS DayOfWeek,
  (ROUND(sedentary_minutes/60,1)) AS sedentary_hours,
  (ROUND((very_active_minutes + fairly_active_minutes + lightly_active_minutes)/60,1)) AS total_active_hours
FROM fitbit-391618.fitness.daily_activity_merged
WHERE (very_active_minutes + fairly_active_minutes + lightly_active_minutes) > 0 AND
  calories > 0
ORDER BY activity_date

/* 7. How much sleep are users getting on average?
Used a nested query to find the SUM and AVG for time spent in bed awake and asleep*/
SELECT *,
(average_minutes_asleep/60) AS average_hours_asleep     
FROM (      
   SELECT DISTINCT id,      
    COUNT(id) AS logs,      
    SUM(time_before_sleep) AS total_time_before_sleep,     
    AVG(time_before_sleep) AS average_time_before_sleep,     
    SUM(total_minutes_asleep) AS total_time_asleep,      
    AVG(total_minutes_asleep) AS average_minutes_asleep   
 FROM fitbit-391618.fitness.sleep_day_merged    
 GROUP BY Id      
 ORDER BY Id )

/* 8. What's the total time users spend asleep?
I wanted to gather the information using WHERE and operators.*/
SELECT *,
  (ROUND(total_minutes_asleep/60,1)) AS total_hours_asleep,
  (total_minutes_asleep - time_before_sleep) AS minutes_til_sleep
FROM fitbit-391618.fitness.sleep_day_merged  
WHERE (total_minutes_asleep - time_before_sleep) > 0

/* 9. What trends can we find over time in daily_activity_merged?
Found the AVG of the activity, sorted by date to see any trends*/
SELECT DISTINCT activity_date,
 COUNT(id) AS logs,
 AVG(total_steps) AS average_steps,
 AVG(total_distance) AS average_distance, 
 AVG(very_active_minutes) AS average_very_active_minutes,
 AVG(fairly_active_minutes) AS average_fairly_active_minutes,
 AVG(lightly_active_minutes) AS average_lightly_active_minutes,
 AVG(sedentary_minutes) AS avg_sedentary_minutes,
 AVG(calories) AS average_calories
FROM fitbit-391618.fitness.daily_activity_merged
GROUP BY activity_date
ORDER BY activity_date

/* 10. What trends can we find over time in sleep_day_merged?
Used SUM and AVG to look for trends*/ 
SELECT *,
(average_minutes_asleep/60) AS average_hours_asleep
FROM (
 SELECT DISTINCT sleep_day,      
 COUNT(sleep_day) AS logs,      
    SUM(time_before_sleep) AS total_time_before_sleep,     
    AVG(time_before_sleep) AS average_time_before_sleep,     
    SUM(total_minutes_asleep) AS total_time_asleep,      
    AVG(total_minutes_asleep) AS average_minutes_asleep  
 FROM fitbit-391618.fitness.sleep_day_merged     
 GROUP BY sleep_day
 ORDER BY sleep_day ) 

/* 11. What are the average weights of the users? 
I also looked to see how often they logged in through COUNT*/
SELECT 
 DISTINCT id,
 COUNT(id) AS logs,
 AVG(weight_lbs) AS average_weight_lbs,
 AVG(bmi) AS average_bmi
FROM fitbit-391618.fitness.weight_log_info_merged
GROUP BY id
ORDER BY id

/* 12. Which users are overweight, underweight, or healthy?
Added a new column and string criteria to that column, then ordered the data by highest BMI*/
SELECT *,
  CASE
  WHEN bmi > 24.9 THEN 'Overweight'
  WHEN bmi < 18.5 THEN 'Underweight'
  ELSE 'Healthy' END AS Measure
FROM fitbit-391618.fitness.weight_log_info_merged
WHERE bmi > 0
ORDER BY bmi DESC

/* 13. What step trends do we see from users depending on the time of day?
Simple AVG, GROUP BY and ORDER BY to see when the most users were generating steps*/
SELECT DISTINCT activity_hour, AVG(step_total) AS average_steps
FROM fitbit-391618.fitness.hourly_steps_merged
GROUP BY activity_hour 
ORDER BY activity_hour
