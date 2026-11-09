import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// CLASS = blueprint. It says what a Student knows and can do.
// OBJECT = a real Student made from that blueprint.
// Each object has its own values, independent of other objects.
class Student {
  final String name;
  final int age;
  final String city;

  // CONSTRUCTOR: first setup, when an object is created.
  // this.name means: this object's name field.
  Student(this.name, this.age, this.city);

  // NAMED CONSTRUCTOR: a shortcut for a common case.
  Student.guest()
      : name = 'Guest',
        age = 0,
        city = 'Unknown';

  // METHODS: what a Student can do.
  String greet() => 'Hello, I am $name';

  String details() => '$name, $age, from $city';

  bool get isAdult => age >= 18;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Class and Object',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const ClassObjectPage(),
    );
  }
}

class ClassObjectPage extends StatelessWidget {
  const ClassObjectPage({super.key});

  @override
  Widget build(BuildContext context) {
    // OBJECTS: three real Students, from the same blueprint.
    final Student abir = Student('Abir', 22, 'Dhaka');
    final Student sara = Student('Sara', 17, 'Chattogram');
    final Student guest = Student.guest();

    // A LIST OF OBJECTS: keep many students together, in order.
    final List<Student> students = [abir, sara, guest];
    final String names = students.map((s) => s.name).join(', ');

    // COMPARISON, all in one place, no need for old videos.
    // Without a class: name1, age1, city1, name2, age2, city2...
    //   scattered variables, easy to mix up, hard to grow.
    // With a class: Student abir = Student('Abir', 22, 'Dhaka');
    //   one object holds name, age, city, and its methods together.
    //   Add a new student? Just make one more object, same blueprint.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Class and Object'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Object: Abir',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(abir.greet()),
            Text(abir.details()),
            Text('Adult: ${abir.isAdult}'),
            const SizedBox(height: 16),
            const Text(
              'Object: Sara and Guest',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(sara.details()),
            Text('Adult: ${sara.isAdult}'),
            Text(guest.details()),
            const SizedBox(height: 16),
            const Text(
              'List of objects',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Total students: ${students.length}'),
            Text('Names: $names'),
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
