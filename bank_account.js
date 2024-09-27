// Juan Verrel Tanuwijaya

// File ini berguna dalam menyediakan class BankAccount, RegularAccount, dan PremiumAccount yang akan digunakan di file banking_system.js
// Class BankAccount adalah abstract class yang memiliki method deposit dan withdraw, method withdraw akan di override di subclass RegularAccount dan PremiumAccount
// Class RegularAccount dan PremiumAccount adalah subclass dari BankAccount, RegularAccount memiliki batasan penarikan saldo maksimal Rp100.000, sedangkan PremiumAccount tidak memiliki batasan

// Abstract class BankAccount, penerapan konsep Abstraction dalam oop
class BankAccount {
  constructor(nama) {
    if (new.target === BankAccount) {
      throw new Error("Abstract Class tidak boleh diinisiasi!");
    }
    this._saldo = 0; // atribut protected, penerapan konsep Encapsulation dalam oop
    this.nama = nama;
  }

  // Method protected, penerapan konsep Encapsulation dalam oop 
  _checkBalance() {
    return this._saldo;
  }

  // Method untuk menambahkan jumlah saldo 
  deposit(amount) {
    return new Promise((resolve, reject) => { // penggunaan Promise untuk menghandle proses async dan error handling
      const tambah = parseFloat(amount);
      if (!isNaN(tambah) && tambah > 0) {
        // Proses penambahan saldo akan dijalankan setelah 3 detik, penerapan konsep asynchronous menggunakan setTimeout
        setTimeout(() => {
          this._saldo += tambah; 
          resolve(`Saldo berhasil ditambahkan. Saldo saat ini: Rp${this._checkBalance()}`);
        }, 3000); 
      } else {
        reject("Masukkan jumlah yang valid.");
      }
    });
  }

  // Method untuk mengurangi jumlah saldo, akan di override di subclass, penerapan dari konsep Polymorphism dalam oop (method yang sama dengan fungsi yang berbeda)
  withdraw(amount) {
    throw new Error("withdraw harus diimplementasikan di subclass.");
  }
}

// Class untuk Regular Account (inherit dari BankAccount), penerapan konsep Inheritance dalam oop
class RegularAccount extends BankAccount {

  // Method override dari parent class BankAccount, penerapan konsep Polymorphism dalam oop
  withdraw(amount) {
    return new Promise((resolve, reject) => {
      const kurang = parseFloat(amount);
      if (!isNaN(kurang) && kurang > 0) {
        // Delay 3 detik sebelum melakukan pengecekan saldo
        setTimeout(() => {
          if (kurang > 100000) {
            reject("Tidak dapat menarik saldo lebih dari Rp100.000 pada akun Regular.");
          } else if (kurang <= this._saldo) {
            this._saldo -= kurang;
            resolve(`Saldo berhasil ditarik. Saldo saat ini: Rp${this._checkBalance()}`);
          } else {
            reject("Saldo tidak mencukupi.");
          }
        }, 3000); // Delay 3 detik
      } else {
        reject("Masukkan jumlah yang valid.");
      }
    });
  }
}

// Class untuk Premium Account (inherit dari BankAccount)
class PremiumAccount extends BankAccount {

  // Method override dari parent class BankAccount, penerapan konsep Polymorphism dalam oop
  withdraw(amount) {
    return new Promise((resolve, reject) => {
      const kurang = parseFloat(amount);
      if (!isNaN(kurang) && kurang > 0) {
        // Delay 3 detik sebelum melakukan pengecekan saldo
        setTimeout(() => {
          if (kurang <= this._saldo) {
            this._saldo -= kurang;
            resolve(`Saldo berhasil ditarik. Saldo saat ini: Rp${this._checkBalance()}`);
          } else {
            reject("Saldo tidak mencukupi.");
          }
        }, 3000); // Delay 3 detik
      } else {
        reject("Masukkan jumlah yang valid.");
      }
    });
  }
}

module.exports = { RegularAccount, PremiumAccount };
