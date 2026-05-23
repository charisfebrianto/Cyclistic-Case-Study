# 🚲 Cyclistic Bike-Share Case Study (2017)

## 📝 Introduction 
As part of the **Google Data Analytics Professional Certificate**, I completed a **Cyclistic case study** by running a comprehensive data analysis cycle. This process includes the stages of <ins>Ask, Prepare, Process, Analyze, Share, and Act</ins>, ensuring that every finding is supported by accurate data cleaning and processing.

## 📌 Project Summary
This project is an intensive case study of Cyclistic, a fictional bike-share company in Chicago that operates over 5,800 bikes and 600 stations. So far, Cyclistic's marketing strategy has focused on building broad brand awareness through various pricing schemes, including single-ride tickets, full-day passes, and annual memberships.

Financial analysis shows that while price flexibility attracts many customers, annual memberships are significantly more profitable than casual riders. Therefore, the primary goal of this project is to develop an effective marketing strategy **to convert casual riders into annual members**.

## 🛠️ Tools
* **SQL (Google BigQuery):** For large-scale data extraction, cleaning, and analysis (3.8 Million+ rows).
* **Tableau:** For creating interactive dashboards and trend visualizations.
* **Markdown:** For documentation and storytelling of analysis results.


### 1. Ask
> Questions for guiding future marketing program: 
> 1. How do annual members and casual riders use Cyclistic bikes differently?
> 2. Why would casual riders buy Cyclistic annual memberships?
> 3. How can Cyclistic use digital media to influence casual riders to become members?

### 2. Prepare
Dataset: [divvy-tripdata](https://divvy-tripdata.s3.amazonaws.com/index.html) <br>
 (Note: The datasets have a different name because Cyclistic is a fictional company. For the purposes of this case study, the datasets are appropriate and will enable you to answer the business questions. The data has been made available by Motivate International Inc. under this license.)

### 3. Process
I use Cyclistic data on 2017 (Q1 - Q4) for this analysis and the following steps for processing :
1) Data Combining
2) Data Exploration
3) Data Cleaning

#### Data Combining
There are 4 tables from Q1 2017 to Q4 2017 then combined into one table. The table consists of 3.829.014 rows.

#### Data Exploration
I make the queries for each column from the left to the right in order to looking for some **missing values, outliers, and inconsistencies** within the dataset.

Cyclistic dataset has **12 variables**, as shown in the following figure along its datatypes: <br>

<img width="415" height="418" alt="variabel cyclistic" src="https://github.com/user-attachments/assets/5db8c15c-eab3-4557-96c9-9520fac3c35e" />


#### 🧹 Data Cleaning
In this step, I made several important technical decisions to maintain the integrity of the analysis:
* **Handling Missing Values:** Found **836,827** empty gender data. I identified that 99% of these empty data came from the *Customer* (Casual) user type. I used `CASE WHEN` logic to convert `NULL` and `Empty String` values ​​to **'Unknown'** to maintain the integrity of the total volume in the visualization.
* **Removing Duplicates:** Using `ROW_NUMBER()` window function to eliminate the duplicates of trip_id.
* **Precise tripduration:** Convert duration from seconds to minutes using manual division (`tripduration / 60`) to preserve decimal values, rather than using a rounding function which potentially loses valuable minute data.
* **Filtering Outlier:** Removing tripduration data which is less than 1 minute and almost 24 hours. This was likely caused by a technical error at the station.
* **Adding 3 columns:** ride_month, ride_hour, day_of_week.

The 338.008 rows were removed. So, the total of 3.491.006 rows (91.17%) have been cleaned.

### 4. Analyze
#### Data Analysis

The key question is:
> How do annual members and casual riders use Cyclistic bikes differently?

### - Total Users in 2017
<img width="650" height="400" alt="image" src="https://github.com/user-attachments/assets/55846c7f-4a2d-46f1-86fc-063cafee2fdb" /><br>
- Cyclistic Subscribers is greater than the Casual ones. The Subscriber has a 83.54% (2.916.444 users), while The Casual has a 16.46% (57.456 users)

### - Trends by Peak Hours
<img width="48%" alt="image" src="https://github.com/user-attachments/assets/f53ead93-efd7-483b-b461-87ece03d6b5f" />   
<img width="51%" alt="image" src="https://github.com/user-attachments/assets/d4bc707a-1d01-4d62-ab25-811706a1b68b" /><br>
- The trends showed that Customer used cyclistic at leisure time (14 - 16) with a longer duration. While Subscriber used cyclistic during peak hours (6 - 8 and 16 - 18)<br>

### - Trends by Day of Week
<img width="48%" alt="image" src="https://github.com/user-attachments/assets/7fa47580-e53c-4d58-857c-22532433855f" />
<img width="49%" alt="image" src="https://github.com/user-attachments/assets/dbc1bdc9-f720-4602-83c7-9b82f85aa9c9" />
<br>
- Subscriber are the most users on week day with the short time of trip duration.<br>
- While Customer are daily users who are a few in number but have a longer tripduration, escpecially on Sunday and Saturday.

### - Trends by Months
<img width="650" height="400" alt="image" src="https://github.com/user-attachments/assets/5e9a60da-f086-4106-a0b6-368d4ec610af" /><br>
- Both Customers and Subscribers has highest activity in summer on June to August.
- Also, they has the lowest activity on December to February.


### - Age Segmentation
<img width="48%" alt="image" src="https://github.com/user-attachments/assets/50843000-d689-477c-91a4-2c90a36f011c"/><br>
- It shows that Cyclistic users are **dominated by millennials (25 - 40 y.o)**, both customers and subscribers.

### - Top 3 Departure and Destination Station
<img width="1240" height="485" alt="image" src="https://github.com/user-attachments/assets/1eea64ff-191e-402e-b9e7-441a8d582999" />
<br>
- Surprisingly, the departure station is the same station as the destination station for each usertype.

## 📊 Key Insights (Share)
Dashboard
<br>

### 1. Time Trend & General Behavior (Commuters vs. Lifestyle Riders)
* **Subscribers (The Multi-Generational Commuters)**: This segment is driven by a diverse workforce, heavily led by Millennials (1.9M) and Gen X (552K), alongside Gen Z and Boomers. This working-age demographic explains the sharp usage spikes during peak commuting hours (8:00 AM and 5:00 PM) on weekdays. For Subscribers, Cyclistic bikes serve as a vital, functional utility for daily transit.
* **Customers (The Millennial Leisure Segment)**: In stark contrast, the casual Customer segment is exclusively driven by Millennials (574K). Their activity builds gradually throughout the day and peaks heavily on weekends. This indicates that casual riding is purely a lifestyle choice—used for recreation, fitness, and winding down.

### 2. Trip duration and efficiency (Experience vs. Utility)
* **Customers (Experience-Driven)**: Casual Millennial riders cycle nearly twice as long (~18 minutes) compared to Subscribers (~10 minutes). As a generation that deeply values "experiences," Millennials are willing to spend more time enjoying the ride, showing a strong positive correlation (0.62) with improved weather during summer (June–August).
* **Subscribers (Efficiency-Driven)**: Subscribers ride with high efficiency. During the summer, they actually get faster and complete rides in less time (strong negative correlation of -0.67), despite an overall increase in trip volume. This reflects the behavior of busy professionals who value speed and predictability over leisure.

### 3. Geographic Hotspots
* **Customers (The Lifestyle Hubs)**: Customers Millennials are heavily concentrated at **stations surrounding major tourist attractions and parks**, such as Streeter Dr & Grand Ave (Navy Pier) and Millennium Park. These locations align perfectly with millennial weekend hangout culture.
* **Subscribers (The Commercial Hubs)**: Subscribers are distributed across **major transit junctions and commercial districts**, notably Clinton St & Washington. This marks the typical "last-mile" commute route from train stations to office buildings.

## 💡 Strategic Recommendations (Act)
1. Location-Based Campaign (Geofencing): Place dedicated digital and physical ads (QR codes) at Casual hotspots (tourist areas) during the summer.
2. Value-for-Time Proposition: Use a marketing narrative that emphasizes cost savings for those who regularly cycle for more than 15 minutes (the average duration of Customer).
3. Summer Targeting: Launch a large-scale conversion campaign in May-June to capture the surge in Customer usage before the peak summer season.

---

## 🔗 Tautan Penting
* [Lihat Dashboard Tableau Interaktif](LINK_TABLEAU_PUBLIC_ANDA)
* [Script SQL Pembersihan Data](./scripts-sql/data_cleaning.sql)
* [Script SQL Analisis Korelasi](./scripts-sql/data_analysis.sql)

---
**Kontak:** Charis Hadi Febrianto - https://www.linkedin.com/in/charishadifebrianto
