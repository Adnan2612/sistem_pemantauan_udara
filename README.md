🌤️ **Sistem Pemantauan Kualitas Udara Luar Ruangan**

Sistem ini merupakan aplikasi berbasis web yang digunakan untuk memantau kondisi kualitas udara luar ruangan di **halaman Laboratorium B - Program Studi Rekayasa Sistem Komputer**. Pengukuran dilakukan menggunakan sensor mikro-kontroler (ESP32) dan ditampilkan melalui antarmuka website Laravel.

Parameter yang diamati:

* 🌡️ **Suhu Udara (°C)**
* 💧 **Kelembaban Udara (%)**
* 🌫️ **Konsentrasi PM10 (µg/m³)**
* 🏷️ **AQI (Air Quality Index)** beserta kategorinya

Website menampilkan dashboard ringkasan, grafik perubahan setiap parameter, tabel data pengukuran, serta halaman admin untuk manajemen pengguna.

---

📌 **Fitur Utama**
🔹 **1. Dashboard Real-Time**
* Menampilkan data sensor terbaru (suhu, kelembaban, PM10, AQI, kategori).
* Tampilan ringkas dan interaktif.
  
🔹 **2. Grafik Data Sensor**
* Menggunakan Chart.js.
* Semua data historis dimuat dari database.
* Update otomatis dengan API internal.

🔹 **3. Tabel Data Pengukuran**
* Menampilkan riwayat data sensor.
* Urut berdasarkan waktu terbaru.

🔹 **4. Sistem Login Multi-Level**
Terdapat dua akun:
* **Admin** → bisa melihat menu Admin.
* **User** → tidak dapat mengakses menu Admin.

🔹 **5. Halaman Admin**
* Manajemen pengguna sederhana.
* Akses terbatas khusus Admin.

🔹 **6. API Input Data (Untuk ESP32)**

Endpoint:

```
POST /api/sensor
```

Format JSON:

```json
{
  "suhu": 30.5,
  "kelembaban": 60,
  "pm10": 80,
  "aqi": 100,
  "kategori": "Sedang"
}
```

---

📁 **Struktur Database**

Sistem ini hanya menggunakan **2 tabel utama**:
**1. Tabel `sensors`**

| Field       | Tipe                | Keterangan        |
| ----------- | ------------------- | ----------------- |
| id          | INT                 | Primary key       |
| kode_sensor | VARCHAR             | Kode unik sensor  |
| lokasi      | VARCHAR             | Lokasi pemasangan |
| status      | ENUM(Aktif/Offline) |                   |

**2. Tabel `sensor_data`**

| Field      | Tipe     | Keterangan            |
| ---------- | -------- | --------------------- |
| id         | INT      | Primary key           |
| sensor_id  | INT      | Foreign key → sensors |
| suhu       | FLOAT    | Suhu                  |
| kelembaban | FLOAT    | Kelembaban            |
| pm10       | INT      | Konsentrasi debu      |
| aqi        | INT      | Air Quality Index     |
| kategori   | VARCHAR  | Kategori AQI          |
| waktu      | DATETIME | Waktu pengukuran      |

---

🛠️ **Cara Menjalankan Proyek Laravel Ini**

Ikuti langkah-langkah berikut agar website dapat berjalan dengan sempurna.
 **1. Clone Repository**

```bash
git clone https://github.com/Adnan2612/sistem_pemantauan_udara.git
cd sistem_pemantauan_udara
```

---

✔️ **2. Install Dependencies**

Pastikan Composer sudah terinstall.

```bash
composer install
```

---

✔️ **3. Buat File `.env`**

Jika tidak ada `.env`, duplikasi:

```bash
cp .env.example .env
```

Sesuaikan isi `.env`:

```
APP_NAME=Laravel
APP_ENV=local
APP_KEY=
APP_DEBUG=true
APP_URL=http://localhost

DB_CONNECTION=mysql
DB_HOST=127.0.0.1
DB_PORT=3306
DB_DATABASE=sistem_pemantauan
DB_USERNAME=root
DB_PASSWORD=
```

---

✔️ **4. Generate APP_KEY**

```bash
php artisan key:generate
```

---

✔️ **5. Buat Database di phpMyAdmin**

Nama bebas, contoh:

```
sistem_pemantauan
```

---

## ✔️ **6. Jalankan Migrasi (Jika tabel disiapkan otomatis)**

```bash
php artisan migrate
```

Atau jika tabel sudah dibuat manual, lewati langkah ini.

---

## ✔️ **7. Jalankan Server Laravel**

```bash
php artisan serve
```

Akses website di:

👉 **[http://localhost:8000](http://localhost:8000)**

---

# 🔐 **Akun Login Default**

### **Admin**

```
Email: adminnanda@gmail.com
Password: admin123
```

### **User**

```
Email: user@gmail.com
Password: user123
```

> Admin dapat melihat menu “Admin”, sedangkan user biasa tidak bisa.

---

# 🌐 **API Endpoint untuk ESP32**

### 🔹 Input data sensor

`POST /api/sensor`

### 🔹 Ambil seluruh data untuk grafik

`GET /api/chart-data`

Respon:

```json
{
  "labels": ["10:00", "10:02", ...],
  "suhu": [30.1, 29.9, ...],
  "kelembaban": [70, 71, ...],
  "pm10": [40, 45, ...]
}
```

---

# 🖥️ **Teknologi yang Digunakan**

* **Laravel 10**
* **PHP 8.2**
* **MySQL (Laragon)**
* **TailwindCSS**
* **Chart.js**
* **JavaScript**
* **Blade Template Engine**

---

# 🤝 **Kontribusi**

Pull Request sangat diterima.
Silakan buat issue untuk bug atau perbaikan kode.

---

# 📄 **Lisensi**

Proyek ini menggunakan lisensi **MIT**.
