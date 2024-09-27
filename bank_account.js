// Juan Verrel Tanuwijaya

const readline = require("readline");

class BankAccount {
  constructor(nama) {
    this.saldo = 0;
    this.nama = nama;
  }

  // Fungsi untuk mengambil input dari user
  getUserInput(question) {
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

  // Method untuk menambahkan jumlah saldo 
  tambahSaldo() {
    return new Promise((resolve, reject) => {
      this.getUserInput("Masukkan jumlah saldo yang ingin ditambahkan: ")
        .then((input) => {
          const tambah = parseFloat(input);

          if (!isNaN(tambah) && tambah > 0) {
            this.saldo += tambah;
            resolve(`Saldo berhasil ditambahkan. Saldo saat ini: Rp${this.saldo}`);
          } else {
            reject("Masukkan jumlah yang valid."); 
          }
        })
    });
  }

  // Method untuk mengurangi jumlah saldo 
  kurangiSaldo() {
    return new Promise((resolve, reject) => {
      this.getUserInput("Masukkan jumlah saldo yang ingin dikurangi: ")
        .then((input) => {
          const kurang = parseFloat(input);

          if (!isNaN(kurang) && kurang > 0) {
            if (kurang <= this.saldo) {
              this.saldo -= kurang;
              resolve(`Saldo berhasil dikurangi. Saldo saat ini: Rp${this.saldo}`);
            } else {
              reject("Saldo tidak mencukupi."); 
            }
          } else {
            reject("Masukkan jumlah yang valid."); 
          }
        })
    });
  }
}

const akun = new BankAccount("Juan");

function main() {
  akun
    .getUserInput(
      `\nHalo ${akun.nama}, Saldo kamu saat ini : Rp${akun.saldo}\nPilih menu:\n1. Tambah saldo\n2. Kurangi saldo\n3. Keluar\nMasukkan pilihan Anda: `
    )
    .then((input) => {
      const pilihan = parseInt(input);

      switch (pilihan) {
        case 1:
          return akun
            .tambahSaldo()
            .then((message) => {
              console.log(message);
              return main();
            })
            .catch((err) => {
              console.log(`Error: ${err}`);
              return main(); 
            });
        case 2:
          return akun
            .kurangiSaldo()
            .then((message) => {
              console.log(message); 
              return main();
            })
            .catch((err) => {
              console.log(`Error: ${err}`); 
              return main(); 
            });
        case 3:
          console.log("Terima kasih!");
          break;
        default:
          console.log("Pilihan tidak valid.");
          return main(); 
      }
    })
    .catch((err) => {
      console.log("Terjadi kesalahan.", err);
    });
}

// Menjalankan aplikasi
main();
