import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Parameters in Dart',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const ParametersPage(),
    );
  }
}

// 1. POSITIONAL parameters: order matters.
int add(int a, int b) {
  return a + b;
}

// 2. NAMED parameters: order does not matter, names do.
// 'required' means the caller must give a value.
String createUser({required String name, required int age}) {
  return '$name, $age years old';
}

// 3. DEFAULT value: used when the caller gives nothing.
String greet({String name = 'Guest'}) {
  return 'Hello, $name';
}

// 4. OPTIONAL POSITIONAL parameter in [ ]: may be left out.
double totalPrice(double price, [double discount = 0]) {
  return price - discount;
}

class ParametersPage extends StatelessWidget {
  const ParametersPage({super.key});

  @override
  Widget build(BuildContext context) {
    final int sum = add(5, 3); // 8
    final String user = createUser(age: 22, name: 'Abir');
    final String helloGuest = greet();
    final String helloAbir = greet(name: 'Abir');
    final double fullPrice = totalPrice(500); // 500
    final double salePrice = totalPrice(500, 100); // 400

    return Scaffold(
      appBar: AppBar(
        title: const Text('Parameters in Dart'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Positional: add(5, 3)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Result: $sum'),
            const SizedBox(height: 16),
            const Text(
              'Named + required',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('createUser(age: 22, name: Abir) = $user'),
            const SizedBox(height: 16),
            const Text(
              'Default value',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('greet() = $helloGuest'),
            Text("greet(name: 'Abir') = $helloAbir"),
            const SizedBox(height: 16),
            const Text(
              'Optional positional',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('totalPrice(500) = $fullPrice'),
            Text('totalPrice(500, 100) = $salePrice'),
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
