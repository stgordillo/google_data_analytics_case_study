# Case Study 2 - How Can a Wellness Technology Company Play It Smart?
## Introduction

Hello and welcome to my first case study, the capstone project for the Google Data Analytics Certificate! This project is meant to showcase my skills developed in the course, specifically in Excel, SQL and Tableau. In this case study, we are being asked to analyze Fitbit data from Kaggle, in order to determine new growth opportunities for the fictional company, Bellabeat. I will note the step-by-step process moving forward.

## Scenario
I'm a junior analyst on the marketing analyst team for Bellabeat, a small tech company of health-focused products for women. I am being tasked by the stakeholders, Urška Sršen the Chief Creative Officer, Sando Mur the Mathematician and the rest of the analytics team to analyze usage data of smart devices using a dataset from Kaggle for Fitbit and find trends that could help influence Bellabeat's marketing strategy.

## Business Task
Analyze smart device usage trends and propose ways to apply these trends to Bellabeat in order to find new growth opportunities.

## Data Sources

"Fitbit Fitness Tracker Data" suggested by the Google Data Analytics Certificate is found on Kaggle and created by data scientist, Möbius. The datasets were sourced from a survey performed by Amazon Mechanical Turk a study with tracked data from 30 Fitbit users who consented to the study.  

The data provided is from 03/12/2016 to 05/12/2016. Noted limitations include lack of demographic data, which can lead to problems for a tech company focused on women, and a lack of unspecified device models, which could cause variance in data.  

The dataset includes 18 sheets, but I have focused my analysis on 4 specific sheets. Their summary is below:

* "daily_activity_merged" includes the daily activity logs for 33 out of 30 users strangely. This dataset contains 3 activity types, their distance, as well as minutes spent performing those activities. The 3 types are light, fairly and very active. Sedentary time are most likely minutes spent with no activity. Calories burned and steps taken are included in this dataset. The distance columns do not have a defined distance measurement.

* "weight_log_info_merged" includes 8 users, their weight in both pounds and kilograms, BMI, and if the data collected was logged either manually or automatically as a boolean.

* "hourly_steps_merged" includes 33 users, and documents the daily steps found in daily_activity_merged into hourly increments in a 24 hour format. It appears that the data variance due to device models appears here when compared to daily_activity_merged.

* "sleep_day_merged" includes 24 users, minutes the user spends asleep, and minutes in bed but not asleep which includes time spent asleep but restless, according to their website.

## Changelog & Cleaning

I utilized Microsoft Excel and SQL for data cleaning in this project. I checked all of the datasets for basic issues: blank spaces, duplicates, and inconsistencies. The following is the Excel specific cleaning done:

* **All Sheets**  
Checked for blanks on all sheets  
Checked the ID value lengths with len. All ID’s were uniform at 10 digits.   
Used trim to clean up data.  
Changed all the PascalCase to  snake_case due to personal preference including the names of the sheet.

* **Weight Log**  
Deleted the “Fat” column in the weightLogInfo_merged  sheet as it was almost all blank and not informative enough.  
Deleted the “log_id” column as it will not be used in the analysis and does not share properties with the other three sheets.

* **Sleep Day**  
Created a new column “time_before_sleep” due to wanting a more useful metric for sleep by subtracting “total_time_in_bed” from “total_minutes_asleep” to understand how long it took the user to fall asleep while in bed.
Deleted total_sleep_records column as it will not be used in analysis.

* **Daily Activity**  
Deleted "tracker_distance", logged_activities_distance", "very_active_distance", "moderately_active_distance", "light_active_distance", and "sedentary_active_distance" columns because we would not be using them in the analysis.

* **Hourly Steps**  
No changes were made to this sheet.


## Data Analysis

This section will be filled in as I complete the next stage.
