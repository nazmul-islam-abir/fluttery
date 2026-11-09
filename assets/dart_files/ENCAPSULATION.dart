import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ENCAPSULATION: lock the data inside the class.
// A _ in front of a name means private: only this class can touch it.
// Everyone else must use a getter to read, a setter to change,
// and methods like deposit and withdraw, which can check first.
class BankAccount {
  final String owner;
  double _balance;

  BankAccount(this.owner, this._balance);

  // GETTER: a safe way to read the private balance.
  double get balance => _balance;

  // SETTER: a safe way to change it, with a check first.
  set balance(double value) {
    if (value >= 0) {
      _balance = value;
    }
  }

  // METHODS: the only other doors in, both check before they act.
  void deposit(double amount) {
    if (amount > 0) {
      _balance += amount;
    }
  }

  bool withdraw(double amount) {
    if (amount > 0 && amount <= _balance) {
      _balance -= amount;
      return true;
    }
    return false;
  }
}

// A second example, same idea, with age.
class Student {
  final String name;
  int _age;

  Student(this.name, this._age);

  int get age => _age;

  set age(int value) {
    if (value >= 0 && value <= 120) {
      _age = value;
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Encapsulation',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const EncapsulationPage(),
    );
  }
}

class EncapsulationPage extends StatelessWidget {
  const EncapsulationPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. PRIVATE + GETTER: start 1000, read it safely.
    final BankAccount account = BankAccount('Abir', 1000);
    final double startBalance = account.balance; // 1000

    // 2. SETTER WITH A CHECK: -100 is rejected, balance stays 1000.
    account.balance = -100;
    final double afterBadSet = account.balance; // 1000

    // 3. TAP DEPOSIT: +500, then TAP WITHDRAW: -200.
    account.deposit(500);
    final double afterDeposit = account.balance; // 1500
    account.withdraw(200);
    final double afterWithdraw = account.balance; // 1300

    // 4. TAP WITHDRAW 2000: not enough, rejected, stays 1300.
    final bool bigWithdrawOk = account.withdraw(2000); // false

    // 5. AGE SETTER: -5 rejected, stays 22; 23 accepted.
    final Student student = Student('Sara', 22);
    student.age = -5;
    final int ageAfterBad = student.age; // 22
    student.age = 23;
    final int ageAfterGood = student.age; // 23

    // COMPARISON, all in one place, no need for old videos.
    // Open:     double balance = 1000; account.balance = -100;
    //           // No check, balance is now wrong, -100.
    // Locked:   double _balance = 1000; // private, no direct touch.
    // Getter:   account.balance;        // read only, 1000.
    // Setter:   account.balance = -100; // check first, rejected.
    // Method:   account.deposit(500);   // check first, then add.
    // Use private + getter + setter when a value must stay valid,
    // and public fields only when any value is fine.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Encapsulation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Balance, locked',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Start: $startBalance'),
            Text('After bad set: $afterBadSet'),
            const SizedBox(height: 16),
            const Text(
              'Tap: deposit and withdraw',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('After deposit +500: $afterDeposit'),
            Text('After withdraw -200: $afterWithdraw'),
            Text('Withdraw 2000 ok? $bigWithdrawOk'),
            const SizedBox(height: 16),
            const Text(
              'Age setter',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Age after -5: $ageAfterBad'),
            Text('Age after 23: $ageAfterGood'),
            const SizedBox(height: 16),
            const Text(
              'Code is available in the description',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text('Copy the full code from the description.'),
          ],
        ),
      ),
    );
  }
}
