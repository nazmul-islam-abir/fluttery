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
      title: 'My List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const FruitListPage(),
    );
  }
}

class FruitListPage extends StatefulWidget {
  const FruitListPage({super.key});

  @override
  State<FruitListPage> createState() => _FruitListPageState();
}

class _FruitListPageState extends State<FruitListPage> {
  // 1. CREATE a list
  final List<String> fruits = ['Apple', 'Banana', 'Mango'];

  // 2. ADD an item to the list
  void _addOrange() {
    setState(() {
      if (!fruits.contains('Orange')) {
        fruits.add('Orange');
      }
    });
  }

  // 3. REMOVE an item from the list
  void _removeBanana() {
    setState(() {
      fruits.remove('Banana');
    });
  }

  void _resetList() {
    setState(() {
      fruits
        ..clear()
        ..addAll(['Apple', 'Banana', 'Mango']);
    });
  }

  @override
  Widget build(BuildContext context) {
    // 4. LOOP through the list and make one tile per fruit
    final List<Widget> fruitTiles = [];
    for (final fruit in fruits) {
      fruitTiles.add(
        ListTile(
          leading: CircleAvatar(
            child: Text(fruit[0]),
          ),
          title: Text(fruit),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My List App'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: _addOrange,
                  child: const Text('Add Orange'),
                ),
                ElevatedButton(
                  onPressed: _removeBanana,
                  child: const Text('Remove Banana'),
                ),
                TextButton(
                  onPressed: _resetList,
                  child: const Text('Reset'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: fruitTiles,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text('Total fruits: ${fruits.length}'),
          ),
        ],
      ),
    );
  }
}
