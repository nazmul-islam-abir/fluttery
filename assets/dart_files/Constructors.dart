import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// CONSTRUCTOR = the first setup, when an object is created.
// It decides how a Student starts: which values it gets, and how.
// Class video covered the default and the named constructor.
// This video adds the initializer list, factory, and const.
class Student {
  final String name;
  final int age;
  final String city;

  // DEFAULT CONSTRUCTOR (recap): values come in, in order.
  // Make it const, so identical constant students can be shared.
  const Student(this.name, this.age, this.city);

  // NAMED CONSTRUCTOR (recap): a shortcut for a common case.
  const Student.guest()
      : name = 'Guest',
        age = 0,
        city = 'Unknown';

  // INITIALIZER LIST: set a field before the object is ready.
  // Student.adult only asks for name and city.
  // The list after the colon fixes age to 18, every time.
  const Student.adult(this.name, this.city) : age = 18;

  // FACTORY CONSTRUCTOR: build an object from other data.
  // Here, from a map, like data that comes from an API or a file.
  // A factory can read the map first, then call the normal constructor.
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      map['name'] as String,
      map['age'] as int,
      map['city'] as String,
    );
  }

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
      title: 'Constructors',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const ConstructorsPage(),
    );
  }
}

class ConstructorsPage extends StatelessWidget {
  const ConstructorsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. DEFAULT: Abir, 22, Dhaka, adult true.
    const Student abir = Student('Abir', 22, 'Dhaka');

    // 2. NAMED (recap): Guest, 0, Unknown, adult false.
    const Student guest = Student.guest();

    // 3. INITIALIZER LIST: Rafi only gives name and city.
    //    Age is fixed to 18 by the list, so adult is true.
    const Student rafi = Student.adult('Rafi', 'Sylhet');

    // 4. FACTORY: Sara comes from a map, like API data.
    final Student sara = Student.fromMap({
      'name': 'Sara',
      'age': 17,
      'city': 'Chattogram',
    });

    // 5. CONST: two identical constant students are one shared object.
    const Student abirAgain = Student('Abir', 22, 'Dhaka');
    final bool sameAbir = identical(abir, abirAgain); // true

    // A LIST OF OBJECTS: keep many students together, in order.
    final List<Student> students = [abir, guest, rafi, sara];
    final String names = students.map((s) => s.name).join(', ');

    // COMPARISON, all in one place, no need for old videos.
    // Default:  Student('Abir', 22, 'Dhaka')  // values in order.
    // Named:    Student.guest()                // shortcut, fixed values.
    // Adult:    Student.adult('Rafi', 'Sylhet') // list fixes age to 18.
    // Factory:  Student.fromMap(map)           // build from a map.
    // Const:    const Student('Abir', 22, 'Dhaka') // shared when identical.
    // Use default for the normal case, named for a common shortcut,
    // factory when the data needs reading first, const when the
    // values are known and never change.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Constructors'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Default: Abir',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(abir.details()),
            Text('Adult: ${abir.isAdult}'),
            const SizedBox(height: 16),
            const Text(
              'Named + adult: Guest and Rafi',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(guest.details()),
            Text('Adult: ${guest.isAdult}'),
            Text(rafi.details()),
            Text('Adult: ${rafi.isAdult}'),
            const SizedBox(height: 16),
            const Text(
              'Factory from a map: Sara',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(sara.details()),
            Text('Adult: ${sara.isAdult}'),
            const SizedBox(height: 16),
            const Text(
              'Const: same Abir twice',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Identical: $sameAbir'),
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
