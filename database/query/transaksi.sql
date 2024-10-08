-- Menambah data transaksi baru, dan melakukan update pada saldo akun berdasarkan jenis transaksi menggunakan stored procedure proses_transaksi yang sudah dibuat
-- $1 = id akun, $2 = jumlah, $3 = jenis (deposit/withdraw)
CALL proses_transaksi ($1, $2, $3);

-- Menampilkan semua data transaksi
SELECT * FROM transaksi;

-- Menampilkan data transaksi berdasarkan ID
SELECT * FROM transaksi WHERE transaksi_id = $1;

-- Mengubah data transaksi berdasarkan ID
UPDATE transaksi
SET
    jumlah = $1,
    tanggal = $2,
    jenis = $3
WHERE
    transaksi_id = $4;

-- Menghapus data transaksi berdasarkan ID
DELETE FROM transaksi WHERE transaksi_id = $1;

-- Populate data transaksi
INSERT INTO
    transaksi (
        akun_id,
        jumlah,
        tanggal,
        jenis
    )
SELECT
    akun_id,
    ROUND(RANDOM() * 100000, 2) AS jumlah,
    CURRENT_DATE - (RANDOM() * 30)::INT AS tanggal,
    CASE
        WHEN RANDOM() < 0.5 THEN 'deposit'
        ELSE 'withdraw'
    END AS jenis
FROM akun
ORDER BY RANDOM()
LIMIT 20;

-- Populate data transaksi
INSERT INTO
    transaksi (
        akun_id,
        jumlah,
        tanggal,
        jenis
    )
SELECT
    akun_id,
    ROUND(
        (RANDOM() * 100000)::NUMERIC,
        2
    ) AS jumlah, -- Random transaction amount between 0 and 100000
    CURRENT_DATE - (RANDOM() * 30)::INT AS tanggal, -- Random date within the last 30 days
    CASE
        WHEN RANDOM() < 0.5 THEN 'deposit'::transaksi_jenis
        ELSE 'withdraw'::transaksi_jenis
    END AS jenis
FROM akun
    JOIN GENERATE_SERIES(1, 5) AS transaction_count ON true -- Generate 5 transactions per account
ORDER BY RANDOM();