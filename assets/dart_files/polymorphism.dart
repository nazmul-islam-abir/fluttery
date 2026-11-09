import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// POLYMORPHISM: one call, many behaviours.
// A real shop checkout. The screen only knows one thing:
// every payment method can pay(). How it pays is its own business.
// CheckoutPage -> PaymentMethod -> Cash / Card / bKash
// (UI)           (abstract)        (real ways to pay)
abstract class PaymentMethod {
  String get name;
  double fee(double amount);
  String pay(double amount);
}

// CASH: no fee. Pay 500, total 500.
class CashPayment implements PaymentMethod {
  @override
  String get name => 'Cash';

  @override
  double fee(double amount) => 0;

  @override
  String pay(double amount) =>
      'Paid ${amount + fee(amount)} in cash';
}

// CARD: 2% fee. Pay 500, fee 10, total 510.
class CardPayment implements PaymentMethod {
  @override
  String get name => 'Card';

  @override
  double fee(double amount) => amount * 0.02;

  @override
  String pay(double amount) =>
      'Paid ${amount + fee(amount)} by card (fee ${fee(amount)})';
}

// BKASH: 1% fee. Pay 500, fee 5, total 505.
class BkashPayment implements PaymentMethod {
  @override
  String get name => 'bKash';

  @override
  double fee(double amount) => amount * 0.01;

  @override
  String pay(double amount) =>
      'Paid ${amount + fee(amount)} with bKash (fee ${fee(amount)})';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shop Checkout',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const CheckoutPage(),
    );
  }
}

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // 1. THE ORDER: one burger, total 500.
  static const double total = 500;

  // 2. ONE LIST, THREE WAYS TO PAY: the screen holds PaymentMethods,
  //    not Cash, Card, or bKash. It never asks which one it is.
  final List<PaymentMethod> methods = [
    CashPayment(),
    CardPayment(),
    BkashPayment(),
  ];

  PaymentMethod _selected = CashPayment();
  String _result = 'Pick a payment method, then tap Pay.';

  void _pay() {
    // 3. ONE CALL, ANY METHOD: the same line pays in cash,
    //    by card, or with bKash — the method decides how.
    setState(() => _result = _selected.pay(total));
  }

  // COMPARISON, all in one place, no need for old videos.
  // WITHOUT polymorphism, the screen must know every type:
  //   if (method is CashPayment) { payCash(500); }
  //   else if (method is CardPayment) { payCard(500); }
  //   else if (method is BkashPayment) { payBkash(500); }
  //   // New method? Add another if. The screen keeps growing.
  // WITH polymorphism, one call does it all:
  //   method.pay(500); // Cash 500, Card 510, bKash 505.
  //   // New method? Just add the class. The screen never changes.
  // Polymorphism = same call, different behaviour, chosen by the
  // real object behind the screen, not by if-else in the screen.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order: Burger - 500',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const Text(
              'Tap: Cash, Card, bKash',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...methods.map(
              (m) => ListTile(
                title: Text(m.name),
                subtitle: Text('Fee ${m.fee(total)}'),
                selected: m == _selected,
                onTap: () => setState(() => _selected = m),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _pay, child: const Text('Pay')),
            const SizedBox(height: 16),
            Text(_result),
            const SizedBox(height: 16),
            const Text(
              'Source code: fluttery.pages.dev',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text('Full code available at fluttery.pages.dev.'),
          ],
        ),
      ),
    );
  }
}
