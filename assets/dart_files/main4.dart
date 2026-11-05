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
      title: 'Set in Dart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const SetPage(),
    );
  }
}

class SetPage extends StatelessWidget {
  const SetPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Create a Set: no duplicates allowed.
    // Note: 'Apple' is written twice on purpose below.
    final Set<String> fruits = {'Apple', 'Banana', 'Mango', 'Apple'};

    // 2. Add: adding 'Apple' again does nothing, adding 'Orange' works.
    fruits.add('Apple');
    fruits.add('Orange');

    // 3. Remove: take 'Banana' out.
    fruits.remove('Banana');

    // 4. Check: does the set contain 'Mango'?
    final bool hasMango = fruits.contains('Mango');

    // 5. Loop: visit every item once, in order.
    // (Kept as a list only for display; the Set itself has no duplicates.)
    final List<String> fruitList = fruits.toList();

    // 6. Set operations: union, intersection, difference.
    final Set<String> citrus = {'Orange', 'Lemon'};
    final Set<String> allFruits = fruits.union(citrus);
    final Set<String> common = fruits.intersection(citrus);
    final Set<String> onlyFruits = fruits.difference(citrus);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Set in Dart'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Set (duplicates removed)',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(fruits.join(', ')),
            const SizedBox(height: 16),
            const Text(
              'contains Mango?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(hasMango ? 'Yes' : 'No'),
            const SizedBox(height: 16),
            const Text(
              'Loop result',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(fruitList.join(', ')),
            const SizedBox(height: 16),
            const Text(
              'union',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(allFruits.join(', ')),
            const SizedBox(height: 16),
            const Text(
              'intersection',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(common.join(', ')),
            const SizedBox(height: 16),
            const Text(
              'difference',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(onlyFruits.join(', ')),
          ],
        ),
      ),
    );
  }
}
