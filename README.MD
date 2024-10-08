# Basic Banking System 
## Challenge Chapter 2

### Juan Verrel Tanuwijaya  
### Kelas: BEJS-1  

---

## Deskripsi Singkat
Program ini adalah sistem bank sederhana yang memungkinkan pengguna untuk mengelola akun bank mereka melalui terminal. Pengguna dapat membuat akun, melakukan setoran, dan menarik uang. Terdapat dua jenis akun yang tersedia:
- **Akun Regular**: Akun dengan batas penarikan maksimum Rp100.000.
- **Akun Premium**: Akun dengan keistimewaan tanpa batasan penarikan.

- **Cara Menjalankan Program**: node banking_system.js

---

## Flowchart
Berikut adalah flowchart yang menggambarkan alur dari program:

![Flowchart](./flowchart.png)

---

## Penjelasan Flowchart

### 1. **Mulai Program**  
   - Program dimulai dan pengguna diminta untuk menginputkan nama akun.

### 2. **Pilih Jenis Akun**
   - Pengguna dapat memilih antara dua opsi jenis akun:
     - **1. Akun Regular**: Memiliki batas penarikan maksimum (Rp100.000).
     - **2. Akun Premium**: Tidak memiliki batas penarikan.
     - Jika pengguna menginputkan selain dari pilihan diatas maka dianggap tidak valid dan akan kembali ke awal program. 

### 3. **Pembuatan Akun**
   - Berdasarkan pilihan pengguna, objek **RegularAccount** atau **PremiumAccount** dibuat.

### 4. **Menu Utama**
   - Sistem menampilkan saldo akun saat ini.
   - Pengguna diberikan pilihan menu utama dengan tiga opsi:
     1. Menambah saldo (deposit).
     2. Menarik saldo (withdraw).
     3. Keluar dari program.
     - Jika pengguna menginputkan selain dari pilihan diatas maka dianggap tidak valid dan akan kembali ke pilihan menu utama.

### 5. **Tambah Saldo (Deposit)**
   - Jika pengguna memilih opsi untuk menambah saldo, sistem akan meminta jumlah yang ingin ditambah ke saldo. Sistem akan memeriksa apakan inputan merupakan angka dan lebih dari 0, jika tidak valid maka akan dikembalikan ke menu utama. Jika valid, sistem akan delay selama 3 detik sebelum menampilkan pesan saldo berhasil ditambah sebanyak jumlah yang diinputkan pengguna.

### 6. **Tarik Saldo (Withdraw)**
   - Jika pengguna memilih opsi untuk menarik saldo, sistem akan memeriksa apakah inputan merupakan angka, inputan lebih dari 0, dan saldo mencukupi. Untuk akun regular, terdapat batasan penarikan Rp100.000, sedangkan akun premium dapat menarik saldo tanpa batasan, asalkan inputan merupakan angka, inputan lebih dari 0, dan saldo mencukupi. Jika tidak valid maka akan dikembalikan ke menu utama, sedangkan jika valid, sistem akan delay selama 3 detik sebelum menampilkan pesan saldo telah berkurang sebanyak jumlah yang diinputkan pengguna.

### 7. **Keluar Program**
   - Jika pengguna memilih untuk keluar, program akan mengakhiri sesi dan menampilkan pesan terima kasih.

---

## Penjelasan Database

### Struktur Database

1. **Tabel `nasabah`**
   - **`nasabah_id`**: ID unik untuk setiap nasabah (tipe: SERIAL, PRIMARY KEY).
   - **`nama`**: Nama lengkap nasabah (tipe: VARCHAR(100), NOT NULL).
   - **`alamat`**: Alamat tempat tinggal nasabah (tipe: VARCHAR(100), NOT NULL).

2. **Tabel `akun`**
   - **`akun_id`**: ID unik untuk setiap akun (tipe: SERIAL, PRIMARY KEY).
   - **`nasabah_id`**: ID nasabah yang memiliki akun (tipe: INT, NOT NULL). Ini adalah foreign key yang mengacu ke `nasabah.nasabah_id`.
   - **`saldo`**: Saldo akun saat ini (tipe: DECIMAL(20, 2), NOT NULL, DEFAULT 0, CHECK (saldo >= 0)).
   - **`tipe`**: Jenis akun (tipe: `akun_jenis`, ENUM('regular', 'premium'), NOT NULL).

3. **Tabel `transaksi`**
   - **`transaksi_id`**: ID unik untuk setiap transaksi (tipe: SERIAL, PRIMARY KEY).
   - **`akun_id`**: ID akun yang terkait dengan transaksi (tipe: INT, NOT NULL). Ini adalah foreign key yang mengacu ke `akun.akun_id`.
   - **`jumlah`**: Jumlah uang yang ditransaksikan (tipe: DECIMAL(20, 2), NOT NULL).
   - **`tanggal`**: Tanggal transaksi dilakukan (tipe: DATE, DEFAULT CURRENT_DATE).
   - **`jenis`**: Jenis transaksi (tipe: `transaksi_jenis`, ENUM('deposit', 'withdraw'), NOT NULL).

### Relasi Antar Tabel
- Tabel `nasabah` berhubungan dengan tabel `akun` melalui `nasabah_id`. Setiap nasabah dapat memiliki satu atau lebih akun.
- Tabel `akun` berhubungan dengan tabel `transaksi` melalui `akun_id`. Setiap akun dapat memiliki satu atau lebih transaksi yang terkait.

### Stored Procedures
Sistem ini juga dilengkapi dengan prosedur tersimpan (stored procedures) yang membantu dalam pengelolaan akun dan transaksi:
- **`upgrade_to_premium`**: Untuk meng-upgrade akun dari jenis regular menjadi premium.
- contoh penggunaan : CALL upgrade_to_premium(1); -> upgrade akun dengan id 1 menjadi premium

- **`proses_transaksi`**: Untuk melakukan transaksi setoran (deposit) dan penarikan (withdraw) dengan memeriksa validitas transaksi sesuai dengan tipe akun.
- contoh penggunaan : CALL proses_transaksi(1, 100000, 'deposit'); -> deposit sejumlah 100000 ke akun dengan id 1

---