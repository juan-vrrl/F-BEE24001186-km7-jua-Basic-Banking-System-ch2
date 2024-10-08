-- Procedure untuk melakukan upgrade akun dari regular ke premiumCREATE OR REPLACE PROCEDURE upgrade_to_premium(p_akun_id INT)
-- contoh penggunaan : CALL upgrade_to_premium(1); -> upgrade akun dengan id 1 menjadi premium
CREATE OR REPLACE PROCEDURE upgrade_to_premium(p_akun_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE akun
    SET tipe = 'premium'
    WHERE akun_id = p_akun_id AND tipe = 'regular';

    IF NOT FOUND THEN
        RAISE NOTICE 'Akun sudah tipe premium atau tidak ditemukan akun dengan id: %', p_akun_id;
    ELSE
        RAISE NOTICE 'Akun dengan id % sudah diupgrade menjadi tipe premium.', p_akun_id;
    END IF;
END;
$$;

-- Procedure untuk melakukan proses transaksi deposit (menambah saldo) dan withdraw (mengurangi saldo)
-- contoh penggunaan : CALL proses_transaksi(1, 100000, 'deposit'); -> deposit sejumlah 100000 ke akun dengan id 1
CREATE OR REPLACE PROCEDURE proses_transaksi(
    p_akun_id INT,
    p_jumlah DECIMAL(20, 2),
    p_jenis transaksi_jenis
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_tipe akun_jenis;  -- Variabel untuk menyimpan tipe akun
BEGIN
    -- Ambil tipe akun untuk dimasukkan kedalam variabel v_tipe
    SELECT tipe INTO v_tipe FROM akun WHERE akun_id = p_akun_id;

    -- Cek jenis transaksi
    IF p_jenis = 'deposit' THEN
        -- Insert transaksi
        INSERT INTO transaksi (akun_id, jumlah, jenis)
        VALUES (p_akun_id, p_jumlah, p_jenis);

        -- Update saldo akun
        UPDATE akun
        SET saldo = saldo + p_jumlah
        WHERE akun_id = p_akun_id;

    -- Cek tipe akun dan batasan penarikan, jika akun tipe regular penarikan di limit 100000
    ELSIF p_jenis = 'withdraw' THEN
        IF v_tipe = 'regular' AND p_jumlah > 100000 THEN
            RAISE EXCEPTION 'Penarikan tidak boleh melebih Rp. 100000 untuk akun id: %', p_akun_id;
        END IF;

        -- Cek apakah saldo akun mencukupi
        IF (SELECT saldo FROM akun WHERE akun_id = p_akun_id) >= p_jumlah THEN
            -- Insert transaksi
            INSERT INTO transaksi (akun_id, jumlah, jenis)
            VALUES (p_akun_id, p_jumlah, p_jenis);

            -- Update saldo akun
            UPDATE akun
            SET saldo = saldo - p_jumlah
            WHERE akun_id = p_akun_id;
        ELSE
            -- Jika saldo tidak mencukupi diberi peringatan
            RAISE EXCEPTION 'Akun dengan id % tidak memiliki saldo yang cukup untuk penarikan.', p_akun_id;
        END IF;

    ELSE
        -- Jika jenis transaksi tidak valid diberi peringatan
        RAISE EXCEPTION 'Jenis transaksi % tidak valid', p_jenis;
    END IF;

    RAISE NOTICE 'Proses transaksi % berhasil', p_jenis;

END;
$$;