// Juan Verrel Tanuwijaya
// File ini adalah bagian dari sistem perbankan sederhana yang berinteraksi dengan user menggunakan terminal melalui modul readline.
// Class diambil dengan mengimport modul dari file bank_account.js yang berisi class BankAccount, RegularAccount, dan PremiumAccount.
// Program ini memungkinkan user untuk membuat akun bank (Regular atau Premium), menambahkan saldo (deposit), dan menarik saldo (withdraw), serta menampilkan saldo yang tersisa.

const { RegularAccount, PremiumAccount } = require("./bank_account");

// modul readline untuk mengambil input dari user
const readline = require("readline");

// Fungsi untuk mengambil input dari user
function getUserInput(question) {
  const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout,
  });

  return new Promise((resolve) => {
    rl.question(question, (answer) => {
      rl.close();
      resolve(answer);
    });
  });
}

async function main() {
  // Meminta user untuk memasukkan nama dan memilih tipe akun
  const nama = await getUserInput("Masukkan nama Anda: ");
  const tipeAkun = await getUserInput(
    "Pilih tipe akun:\n1. Regular\n2. Premium\nMasukkan pilihan Anda: "
  );

  // Inisialisasi akun berdasarkan tipe yang dipilih user
  let akun;
  if (tipeAkun === "1") {
    akun = new RegularAccount(nama);
  } else if (tipeAkun === "2") {
    akun = new PremiumAccount(nama);
  } else {
    console.log("Pilihan tidak valid.");
    return main();
  }


  // Loop untuk menu interaksi user
  while (true) {
    
    console.log(`\nHalo ${akun.nama}, Saldo kamu saat ini: Rp${akun._checkBalance()}`);

    const pilihan = await getUserInput(
      "\nPilih menu:\n1. Tambah saldo\n2. Tarik saldo\n3. Keluar\nMasukkan pilihan Anda: "
    );

    switch (parseInt(pilihan)) {
      case 1: // Tambah saldo
        const depositAmount = await getUserInput("Masukkan jumlah yang ingin ditambahkan: ");
        try {
          const message = await akun.deposit(depositAmount);
          console.log(message);
        } catch (err) {
          console.log(`Error: ${err}`);
        }
        break;
      case 2: // Tarik saldo
        const withdrawAmount = await getUserInput("Masukkan jumlah yang ingin ditarik: ");
        try {
          const message = await akun.withdraw(withdrawAmount);
          console.log(message);
        } catch (err) {
          console.log(`Error: ${err}`);
        }
        break;
      case 3: // Keluar
        console.log("Terima kasih telah menggunakan layanan kami!");
        return;
      default:
        console.log("Pilihan tidak valid.");
    }
  }
}

main();
