import 'dart:convert';
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
      title: 'Map in Dart',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const MapPage(),
    );
  }
}

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. CREATE a Map: key -> value, like JSON.
    final Map<String, dynamic> user = {
      'name': 'Abir',
      'age': 22,
      'city': 'Dhaka',
    };

    // 2. ACCESS by key. A missing key gives null.
    final String name = user['name'] as String;
    final String job = user['job'] ?? 'Not found';

    // 3. ADD / UPDATE / REMOVE.
    final Map<String, dynamic> updatedUser = {...user};
    updatedUser['city'] = 'Chattogram'; // update Dhaka -> Chattogram
    updatedUser['skill'] = 'Flutter'; // add a new key
    updatedUser.remove('age'); // remove age

    // 4. CHECK, KEYS, VALUES, LENGTH.
    final bool hasName = updatedUser.containsKey('name');
    final List<String> keys = updatedUser.keys.toList();
    final List<dynamic> values = updatedUser.values.toList();
    final int total = updatedUser.length;

    // 5. LOOP a Map.
    final String loopResult = updatedUser.entries
        .map((entry) => '${entry.key}: ${entry.value}')
        .join(', ');

    // 6. JSON-LIKE nested data.
    final Map<String, dynamic> jsonUser = {
      'name': 'Abir',
      'age': 22,
      'skills': ['Flutter', 'Dart'],
      'address': {'city': 'Dhaka', 'country': 'Bangladesh'},
    };
    final String jsonString = jsonEncode(jsonUser);
    final Map<String, dynamic> decoded =
        jsonDecode(jsonString) as Map<String, dynamic>;
    final String decodedName = decoded['name'] as String;
    final String decodedSkills =
        (decoded['skills'] as List).join(', ');
    final Map<String, dynamic> decodedAddress =
        decoded['address'] as Map<String, dynamic>;

    // 7. COMPARISON, all in one place, no need for the old videos.
    // List: by index. Set: no duplicates. Map: by key.
    final List<String> fruitsList = ['Apple', 'Banana'];
    final Set<String> fruitsSet = {'Apple', 'Banana'};
    final Map<String, int> priceMap = {'Apple': 120, 'Banana': 60};

    return Scaffold(
      appBar: AppBar(
        title: const Text('Map in Dart'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Map: name -> Abir',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('name: $name, job: $job'),
            const SizedBox(height: 16),
            const Text(
              'After update / add / remove',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(loopResult),
            const SizedBox(height: 16),
            const Text(
              'Keys, values, length',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('has name: $hasName'),
            Text('keys: ${keys.join(', ')}'),
            Text('values: ${values.join(', ')}'),
            Text('length: $total'),
            const SizedBox(height: 16),
            const Text(
              'JSON decoded',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('$decodedName, skills: $decodedSkills'),
            Text(
                'address: ${decodedAddress['city']}, ${decodedAddress['country']}'),
            const SizedBox(height: 16),
            const Text(
              'Comparison',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('List [0]: ${fruitsList[0]}'),
            Text('Set: ${fruitsSet.join(', ')}'),
            Text("Map ['Apple']: ${priceMap['Apple']}"),
          ],
        ),
      ),
    );
  }
}
