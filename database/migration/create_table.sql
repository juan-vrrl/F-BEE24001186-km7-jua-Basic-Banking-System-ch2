-- Tipe akun & transaksi
CREATE TYPE akun_jenis AS ENUM('regular', 'premium');

CREATE TYPE transaksi_jenis AS ENUM('deposit', 'withdraw');

-- Nasabah
CREATE TABLE IF NOT EXISTS nasabah (
    nasabah_id SERIAL PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    alamat VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS nasabah;

-- Akun
CREATE TABLE IF NOT EXISTS akun (
    akun_id SERIAL PRIMARY KEY,
    nasabah_id INT NOT NULL,
    saldo DECIMAL(20, 2) NOT NULL DEFAULT 0 CHECK (saldo >= 0),
    tipe akun_jenis NOT NULL,
    FOREIGN KEY (nasabah_id) REFERENCES nasabah (nasabah_id)
);

DROP TABLE IF EXISTS akun;

-- Transaksi
CREATE TABLE IF NOT EXISTS transaksi (
    transaksi_id SERIAL PRIMARY KEY,
    akun_id INT NOT NULL,
    jumlah DECIMAL(20, 2) NOT NULL,
    tanggal DATE DEFAULT CURRENT_DATE,
    jenis transaksi_jenis NOT NULL,
    FOREIGN KEY (akun_id) REFERENCES akun (akun_id)
);

DROP TABLE IF EXISTS transaksi;