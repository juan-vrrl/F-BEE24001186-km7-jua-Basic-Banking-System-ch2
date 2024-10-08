-- Menambah data akun baru
INSERT INTO akun (nasabah_id, tipe) VALUES ($1, $2);

-- Menampilkan semua data akun
SELECT * FROM akun;

-- Menampilkan data akun berdasarkan ID
SELECT * FROM akun WHERE akun_id = $1;

-- Menampilkan jumlah saldo akun berdasarkan ID
SELECT akun.id, saldo FROM akun WHERE akun_id = $1;

-- Mengubah data akun berdasarkan ID
UPDATE akun
SET
    nasabah_id = $1,
    saldo = $2,
    tipe = $3
WHERE
    akun_id = $4;

-- Menghapus data akun berdasarkan ID
DELETE FROM akun WHERE akun_id = $1;

-- Mengupgrade akun regular menjadi premium menggunakan stored procedure upgrade_to_premium yang sudah dibuat
-- $1 = id akun
CALL upgrade_to_premium ($1);

-- Populate data akun
INSERT INTO
    akun (nasabah_id, saldo, tipe)
SELECT
    n.nasabah_id,
    ROUND(
        (RANDOM() * 200000)::numeric,
        2
    ) AS saldo,
    CASE
        WHEN RANDOM() < 0.5 THEN 'regular'::akun_jenis
        ELSE 'premium'::akun_jenis
    END AS tipe -- Cast to akun_jenis
FROM nasabah n
    JOIN GENERATE_SERIES(1, 3) AS account_count ON true;