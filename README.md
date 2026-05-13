# 🚲 Cyclistic Case Study: Strategi Konversi Member Berbasis Data (2017)

## 📌 Ringkasan Proyek
Proyek ini merupakan studi kasus untuk menganalisis perilaku pengguna layanan berbagi sepeda **Cyclistic** di Chicago selama tahun 2017. Tujuan utamanya adalah untuk mengidentifikasi perbedaan perilaku antara **Annual Members** (pelanggan tahunan) dan **Casual Riders** (pelanggan harian/short-term) guna merancang strategi pemasaran yang efektif untuk meningkatkan konversi menjadi Member.

## ❓ Pertanyaan Kunci
1. Bagaimana perbedaan pola penggunaan sepeda antara Annual Members dan Casual Riders?
2. Mengapa Casual Riders akan tertarik untuk beralih ke Membership Tahunan?
3. Bagaimana Cyclistic dapat menggunakan media digital untuk mempengaruhi Casual Riders menjadi Member?

## 🛠️ Alat yang Digunakan
* **SQL (Google BigQuery):** Untuk ekstraksi, pembersihan, dan analisis data berskala besar (3,8 Juta+ baris).
* **Tableau:** Untuk pembuatan dashboard interaktif dan visualisasi tren.
* **Markdown:** Untuk dokumentasi dan storytelling hasil analisis.

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
