
# In-Depth Analysis
## Explanation

Here I'll answer the questions that guiided my analysis.  You can also find the questions and queries used to answer them in [Queries.sql](https://github.com/stgordillo/google_data_analytics_case_study/blob/6040507f1254c64e0194036fa619314db4deb6c2/Queries.sql)

## Questions and Answers

**1. How many users are unique for each dataset?**  
  There were 33 users in both "daily_activity_merged" and "hourly_steps_merged", 24 in "sleep_day_merged" and 8 in "weight_log_info_merged"

**2. How many users overlap between the four tables?**  
  6 users overlapped between all the tables.

**3. Which users are missing from each table?**  
  This question didn't give us any new numeric information that we didn't get from the previous JOINS, but it did let me see which users were a part of which tables.

**4. Which of the users overlap tables?**  
  I previously knew from question 2 how many users overlapped the tables (6), but this query showed me their user ids.

**5. What's the average activity from the users?**  
This analysis looked at the "daily_activity_merged" table specifically. I found that out of the 33 users, 21 tracked their data throughout the timeframe.  Only 7 of those averaged the recommened amount of steps per day which is 10,000. 20 of the users achieved the 20ish minutes of activity a day (150 minutes a week).

**6. What trends can we find from the users based on the day?**  
  Sedentary time was on the extreme end, being rather high at 15.87 hours. We also can see that step activity was highest on Sunday, with a decline every day until Saturday where it begins to go back up once again.  We can see a similar trend with total very activite minutes and calories burned as well.

**7. How much sleep are users getting on average?**  
  12 out of 24 users were within the recommeneded 7 - 9 hours of sleep, with 1 being at 10.86 hours and 1 with only 1 hours on average, although this outlier has only one logged time.  Only 15 users logged at least half the month, but of those users only 4 did not reach the recommeneded hours.

**8. What's the total time users spend asleep?**  
  Average hours slept between all users was just under the recommeneded 7 - 9 hours at 6.9.

**9. What trends can we find over time in daily_activity_merged?**  
  Much like activity by the day, I found that activity over the month declined.  We can also see that for about 3 weeks, users got over 7000 steps per day, with only the last 4 days having less.

**10. What trends can we find over time in sleep_day_merged?**  
Users tended to be sporadic when using the sleep tracker.  Users utilizing the tracker were low, averaging 13 users for the month.

**11. What are the average weights of the users?**  
The weight tracker is also underutilized, with only 8 users. Of those 8 only 2 used it consistently, with the other 6 users being using the tracker 5 or less times. Average weight of the users were 171.5lbs with the highest being 294lbs and the lowest being 116lbs. THe users had an average of 27.98 BMI with a high of 47.5 and a low of 21.5. 
 
**12. Which users are overweight, underweight, or healthy?**  
5 users were overweight and 3 within the healthy range.

**13. What step trends do we see from users depending on the time of day?**  
Steps generally increase in the morning until 10am.  There are a few peaks and valleys throughout the day with a sharp peak in the evening before a rapid decline at night.
