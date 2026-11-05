import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// DEFINE a function: return type, name, parameters, body, return.
// String = what it gives back, greet = its name,
// String name = what it needs to work.
String greet(String name) {
  return 'Hello, $name!';
}

int add(int a, int b) {
  return a + b;
}

int calculateTotal(int price, int quantity) {
  return price * quantity;
}

bool isAdult(int age) {
  return age >= 18;
}

// void = no value back, just does an action.
void logWelcome(String name) {
  print('Welcome, $name!');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Functions in Dart',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const FunctionsPage(),
    );
  }
}

class FunctionsPage extends StatelessWidget {
  const FunctionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // CALL the functions. Same function, different arguments.
    logWelcome('Abir'); // void function, check the console.
    final String greeting = greet('Abir');
    final String greetingMama = greet('Mama');
    final String greetingSara = greet('Sara');
    final int sum = add(5, 3);
    final int total = calculateTotal(120, 3);
    final bool adult = isAdult(22);

    // COMPARISON, all in one place, no need for old videos.
    // Without a function, you repeat the same lines:
    //   print('Hello, Abir!');
    //   print('Hello, Mama!');
    //   print('Hello, Sara!');
    // With a function, you define once, and call three times:
    //   greet('Abir'); greet('Mama'); greet('Sara');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Functions in Dart'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'greet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(greeting),
            Text(greetingMama),
            Text(greetingSara),
            const SizedBox(height: 16),
            const Text(
              'add',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('add(5, 3) = $sum'),
            const SizedBox(height: 16),
            const Text(
              'calculateTotal',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('120 x 3 = $total'),
            const SizedBox(height: 16),
            const Text(
              'isAdult',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(adult ? 'Yes, adult' : 'No, not adult'),
          ],
        ),
      ),
    );
  }
}
