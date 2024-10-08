-- Menambah data nasabah baru
INSERT INTO nasabah (nama, alamat) VALUES ($1, $2);

-- Menampilkan semua data nasabah
SELECT * FROM nasabah;

-- Menampilkan data nasabah berdasarkan ID
SELECT * FROM nasabah WHERE nasabah_id = $1;

-- Mengubah data nasabah berdasarkan ID
UPDATE nasabah SET nama = $1, alamat = $2 WHERE nasabah_id = $3;

-- Menghapus data nasabah berdasarkan ID
DELETE FROM nasabah WHERE nasabah_id = $1;

-- Populate data nasabah
INSERT INTO
    nasabah (nama, alamat)
SELECT 'Person ' || id AS nama, 'Address ' || id AS alamat
FROM GENERATE_SERIES(1, 100) AS id;