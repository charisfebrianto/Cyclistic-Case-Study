# 🚲 Cyclistic Bike-Share Case Study (2017)

## 📝 Introduction 
As part of the **Google Data Analytics Professional Certificate**, I completed a **Cyclistic case study** by running a comprehensive data analysis cycle. This process includes the stages of Ask, Prepare, Process, Analyze, Share, and Act, ensuring that every finding is supported by accurate data cleaning and processing.

## 📌 Project Summary
This project is an intensive case study of Cyclistic, a fictional bike-share company in Chicago that operates over 5,800 bikes and 600 stations. So far, Cyclistic's marketing strategy has focused on building broad brand awareness through various pricing schemes, including single-ride tickets, full-day passes, and annual memberships.

Financial analysis shows that while price flexibility attracts many customers, annual memberships are significantly more profitable than casual riders. Therefore, the primary goal of this project is to develop an effective marketing strategy **to convert casual riders into annual members**.

## ❓ Key Question
1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders by Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members?

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
### 3. Process
## 🧹 Proses Pembersihan Data (Data Cleaning)
Dalam tahap ini, saya melakukan beberapa keputusan teknis penting untuk menjaga integritas analisis:
* **Penanganan Missing Values:** Menemukan **836.827** data gender yang kosong. Saya mengidentifikasi bahwa 99% data kosong ini berasal dari tipe pengguna *Customer* (Casual). Saya menggunakan logika `CASE WHEN` untuk mengubah nilai `NULL` dan `Empty String` menjadi **'Unknown'** agar integritas volume total tetap terjaga dalam visualisasi.
* **Presisi Durasi Perjalanan:** Mengonversi durasi dari detik ke menit menggunakan pembagian manual (`tripduration / 60`) untuk mempertahankan nilai desimal, dibandingkan menggunakan fungsi pembulatan yang berpotensi menghilangkan data menit yang berharga.
* **Filter Outlier:** Menghapus data perjalanan yang memiliki durasi negatif atau terlalu pendek (< 1 menit) yang kemungkinan disebabkan oleh kesalahan teknis stasiun.

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
