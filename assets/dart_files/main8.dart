import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// BLOCK version: return value, with curly braces and return.
int addBlock(int a, int b) {
  return a + b;
}

String greetBlock(String name) {
  return 'Hello, $name!';
}

bool isAdultBlock(int age) {
  return age >= 18;
}

// ARROW version: same result, one expression, no return word needed.
// => means: this is the answer, give it back.
int addArrow(int a, int b) => a + b;

String greetArrow(String name) => 'Hello, $name!';

bool isAdultArrow(int age) => age >= 18;

double priceWithTax(double price) => price * 1.15;

String gradeArrow(int marks) =>
    marks >= 80 ? 'A+' : marks >= 50 ? 'A' : 'Try again';

// MULTI-STEP needs a block, not an arrow. Three steps, one answer.
int finalPrice(int price, int discount) {
  int afterDiscount = price - discount;
  int tax = afterDiscount ~/ 10;
  return afterDiscount + tax;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Return and Arrow Functions',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const ReturnArrowPage(),
    );
  }
}

class ReturnArrowPage extends StatelessWidget {
  const ReturnArrowPage({super.key});

  @override
  Widget build(BuildContext context) {
    // CALL block and arrow versions: same answers.
    final int sumBlock = addBlock(5, 3);
    final int sumArrow = addArrow(5, 3);
    final String greetB = greetBlock('Abir');
    final String greetA = greetArrow('Abir');
    final bool adultB = isAdultBlock(22);
    final bool adultA = isAdultArrow(22);
    final double taxed = priceWithTax(100);
    final String grade = gradeArrow(85);
    // ARROW in a callback: map every number, double it.
    final List<int> doubled = [1, 2, 3].map((n) => n * 2).toList();
    final int finalP = finalPrice(500, 100);

    // COMPARISON, all in one place, no need for old videos.
    // Block: int add(int a, int b) { return a + b; }
    // Arrow: int add(int a, int b) => a + b;
    // Void:  void log(String m) { print(m); } // no value back.
    // Return: int add(...) // value back, you can save and use it.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Return and Arrow'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Block vs Arrow: add',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Block: $sumBlock, Arrow: $sumArrow'),
            const SizedBox(height: 16),
            const Text(
              'Block vs Arrow: greet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Block: $greetB'),
            Text('Arrow: $greetA'),
            const SizedBox(height: 16),
            const Text(
              'isAdult, price, grade',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Adult block: $adultB, arrow: $adultA'),
            Text('Price with tax: $taxed'),
            Text('Grade 85: $grade'),
            const SizedBox(height: 16),
            const Text(
              'Arrow in map, multi-step block',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Doubled: ${doubled.join(', ')}'),
            Text('Final price 500 - 100 + tax: $finalP'),
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
