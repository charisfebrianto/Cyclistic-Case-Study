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
I make the queries for each column from the left to the right in order to looking for some missing values, outliers, and inconsistencies within the dataset.

#### 🧹 Data Cleaning
In this step, I made several important technical decisions to maintain the integrity of the analysis:
* **Handling Missing Values:** Found **836,827** empty gender data. I identified that 99% of these empty data came from the *Customer* (Casual) user type. I used `CASE WHEN` logic to convert `NULL` and `Empty String` values ​​to **'Unknown'** to maintain the integrity of the total volume in the visualization.
* **Precise tripduration:** Convert duration from seconds to minutes using manual division (`tripduration / 60`) to preserve decimal values, rather than using a rounding function which potentially loses valuable minute data.
* **Filtering Outlier:** Deleting trip data that has a negative duration or is too short (< 1 minute) which is likely caused by a technical error at the station.

The 338.008 rows were removed. So, the total of 3.491.006 rows have been cleaned.

### 4. Analyze

## 📊 Temuan Utama (Key Insights)

### 1. Pola Waktu: Commuter vs Leisure
* **Annual Members:** Menunjukkan lonjakan penggunaan yang sangat tajam pada jam berangkat kerja (**08:00**) dan pulang kerja (**17:00**) di hari kerja. Ini mengonfirmasi bahwa mereka menggunakan sepeda sebagai transportasi fungsional.
* **Casual Riders:** Aktivitas cenderung meningkat secara bertahap sejak siang hari dan mencapai puncak pada akhir pekan (Sabtu & Minggu).

### 2. Durasi Perjalanan & Efisiensi
* Casual Riders bersepeda rata-rata **2x lebih lama** (±24 menit) dibandingkan Members (±12 menit).
* Terdapat temuan unik pada **Musim Panas (Summer)**: 
    * Annual Members menjadi **lebih cepat/efisien** (korelasi negatif -0.67) meski volume perjalanan naik.
    * Casual Riders cenderung bersepeda **lebih lama** seiring membaiknya cuaca (korelasi positif 0.62).

### 3. Hotspot Geografis
* Casual Riders terkonsentrasi di stasiun sekitar area wisata dan taman seperti **Streeter Dr & Grand Ave (Navy Pier)** dan **Millennium Park**.
* Members lebih tersebar di hub transportasi dan area perkantoran seperti **Clinton St & Washington**.

## 💡 Rekomendasi Strategis
1.  **Kampanye Berbasis Lokasi (Geofencing):** Menempatkan iklan digital dan fisik (kode QR) khusus di stasiun hotspot Casual (area wisata) selama musim panas.
2.  **Proposisi Nilai "Value-for-Time":** Menggunakan narasi pemasaran yang menekankan penghematan biaya bagi mereka yang rutin bersepeda lebih dari 20 menit (rata-rata durasi Casual).
3.  **Targeting Musim Panas:** Meluncurkan kampanye konversi besar-besaran pada bulan Mei-Juni untuk menangkap tren lonjakan penggunaan Casual sebelum puncak musim panas.

---

## 🔗 Tautan Penting
* [Lihat Dashboard Tableau Interaktif](LINK_TABLEAU_PUBLIC_ANDA)
* [Script SQL Pembersihan Data](./scripts-sql/data_cleaning.sql)
* [Script SQL Analisis Korelasi](./scripts-sql/data_analysis.sql)

---
**Kontak:** Charis Hadi Febrianto - https://www.linkedin.com/in/charishadifebrianto
