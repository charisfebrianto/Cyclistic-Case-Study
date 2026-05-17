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


### ❓ 1. Ask
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

## 📊 Key Insights

### 1. Time Trend: Commuter vs Leisure
* **Annual Members:** Shows a very sharp spike in usage during the commute to work (**8:00**) and commute to work (**5:00**) on weekdays. This confirms that they use bicycles as a functional means of transportation.
* **Casual Riders:** Activity tends to increase gradually during the day and peaks on weekends (Saturday & Sunday).

### 2. Trip duration and efficiency
* Casual Riders cycled on average **2x longer** (±24 minutes) than Members (±12 minutes).
* There were unique findings in **Summer**:
* Annual Members became **faster/more efficient** (negative correlation -0.67) despite increased trip volume.
* Casual Riders tended to cycle **longer** as the weather improved (positive correlation 0.62).

### 3. Geographic Hotspots
* Casual Riders are concentrated at stations around tourist areas and parks such as **Streeter Dr & Grand Ave (Navy Pier)** and **Millennium Park**.
* Members are more spread out in transportation hubs and office areas such as **Clinton St & Washington**.

## 💡 Strategic Recommendations
1. Location-Based Campaign (Geofencing): Place dedicated digital and physical ads (QR codes) at Casual hotspots (tourist areas) during the summer.
2. Value-for-Time Proposition: Use a marketing narrative that emphasizes cost savings for those who regularly cycle for more than 20 minutes (the average duration of Casual).
3. Summer Targeting: Launch a large-scale conversion campaign in May-June to capture the surge in Casual usage before the peak summer season.

---

## 🔗 Tautan Penting
* [Lihat Dashboard Tableau Interaktif](LINK_TABLEAU_PUBLIC_ANDA)
* [Script SQL Pembersihan Data](./scripts-sql/data_cleaning.sql)
* [Script SQL Analisis Korelasi](./scripts-sql/data_analysis.sql)

---
**Kontak:** Charis Hadi Febrianto - https://www.linkedin.com/in/charishadifebrianto
