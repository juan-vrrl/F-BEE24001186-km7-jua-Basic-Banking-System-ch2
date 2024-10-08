-- Menampilkan semua data akun yang dimiliki nasabah berdasarkan ID nasabah
SELECT n.nama, n.alamat, a.akun_id, a.saldo, a.tipe
FROM nasabah n
    JOIN akun a ON n.nasabah_id = a.nasabah_id
WHERE
    n.nasabah_id = $1;

-- Menampilkan semua data transaksi yang dilakukan oleh nasabah berdasarkan ID akun
SELECT n.nama, n.alamat, a.akun_id, a.saldo, a.tipe, t.transaksi_id, t.jumlah, t.tanggal, t.jenis
FROM
    nasabah n
    JOIN akun a ON n.nasabah_id = a.nasabah_id
    JOIN transaksi t ON a.akun_id = t.akun_id
WHERE
    a.akun_id = $1;

-- Menampilkan semua data transaksi yang dilakukan oleh nasabah berdasarkan ID nasabah
SELECT n.nama, n.alamat, a.akun_id, a.saldo, a.tipe, t.transaksi_id, t.jumlah, t.tanggal, t.jenis
FROM
    nasabah n
    JOIN akun a ON n.nasabah_id = a.nasabah_id
    JOIN transaksi t ON a.akun_id = t.akun_id
WHERE
    n.nasabah_id = $1;

-- Menampilkan total saldo semua akun yang dimiliki nasabah berdasarkan ID nasabah
SELECT 
    n.nasabah_id,
    n.nama,
    n.alamat,
    SUM(a.saldo) AS total_saldo
FROM 
    nasabah n
JOIN 
    akun a ON n.nasabah_id = a.nasabah_id
WHERE 
    n.nasabah_id = $1 
GROUP BY 
    n.nasabah_id

-- Menampilkan 5 data nasabah yang memiliki saldo tertinggi
SELECT 
    n.nama, 
    n.alamat, 
    SUM(a.saldo) AS total_saldo
FROM 
    nasabah n
JOIN 
    akun a ON n.nasabah_id = a.nasabah_id
GROUP BY 
    n.nasabah_id
ORDER BY 
    total_saldo DESC
LIMIT 5;

-- Menampilkan jumlah akun yang bertipe regular dan premium
SELECT 
    tipe, 
    COUNT(*) AS jumlah_akun
FROM
    akun
GROUP BY
    tipe;
