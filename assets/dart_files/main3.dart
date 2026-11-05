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
      title: 'List Methods',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const ListMethodsPage(),
    );
  }
}

class ListMethodsPage extends StatelessWidget {
  const ListMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Original list - note: 'Apple' appears twice on purpose.
    final List<String> fruits = [
      'Banana',
      'Apple',
      'Mango',
      'Orange',
      'Apple',
    ];

    // 1. map: change EVERY item, make a new list.
    final List<String> upperFruits =
        fruits.map((fruit) => fruit.toUpperCase()).toList();

    // 2. where: keep ONLY items that pass the test.
    final List<String> aFruits =
        fruits.where((fruit) => fruit.startsWith('A')).toList();

    // 3. firstWhere: find the FIRST item that passes the test.
    // orElse is important: without it, this throws if nothing matches.
    final String firstLongFruit = fruits.firstWhere(
      (fruit) => fruit.length > 5,
      orElse: () => 'None found',
    );

    // 4. sort: put items in order.
    // sort() changes the original list, so sort a COPY.
    final List<String> sortedFruits = [...fruits]..sort();

    // 5. sort by length, shortest first.
    final List<String> sortedByLength = [...fruits]
      ..sort((a, b) => a.length.compareTo(b.length));

    return Scaffold(
      appBar: AppBar(
        title: const Text('List Methods'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Original',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(fruits.join(', ')),
            const SizedBox(height: 16),
            const Text(
              'map: toUpperCase',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(upperFruits.join(', ')),
            const SizedBox(height: 16),
            const Text(
              'where: starts with A',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(aFruits.join(', ')),
            const SizedBox(height: 16),
            const Text(
              'firstWhere: length > 5',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(firstLongFruit),
            const SizedBox(height: 16),
            const Text(
              'sort: A to Z',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(sortedFruits.join(', ')),
            const SizedBox(height: 16),
            const Text(
              'sort: shortest first',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(sortedByLength.join(', ')),
          ],
        ),
      ),
    );
  }
}
