import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// INHERITANCE: a child class receives everything from a parent class,
// then adds its own parts and changes what it needs.
// Person is the parent. Student and Teacher are the children.
class Person {
  final String name;
  final int age;
  final String city;

  const Person(this.name, this.age, this.city);

  String greet() => 'Hello, I am $name, from $city';

  String details() => '$name, $age, from $city';
}

// STUDENT: extends Person, so it already has name, age, city,
// greet, and details. It only adds a grade.
class Student extends Person {
  final String grade;

  const Student(super.name, super.age, super.city, this.grade);

  // OVERRIDE: same method name as the parent, new words for a student.
  // super.greet() reuses the parent greeting, then adds the grade.
  @override
  String greet() => '${super.greet()}. I study in $grade.';
}

// TEACHER: also extends Person. It only adds a subject.
class Teacher extends Person {
  final String subject;

  const Teacher(super.name, super.age, super.city, this.subject);

  @override
  String greet() => '${super.greet()}. I teach $subject.';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Inheritance',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const InheritancePage(),
    );
  }
}

class InheritancePage extends StatelessWidget {
  const InheritancePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. PERSON: the parent, plain greeting.
    const Person abir = Person('Abir', 22, 'Dhaka');
    final String abirGreet = abir.greet();
    // Hello, I am Abir, from Dhaka.

    // 2. STUDENT: super sends name, age, city up to Person.
    //    Only the grade stays with the Student.
    const Student sara = Student('Sara', 17, 'Chattogram', 'Class 10');
    final String saraGreet = sara.greet();
    // Hello, I am Sara, from Chattogram. I study in Class 10.

    // 3. TEACHER: same parent, different extra part, the subject.
    const Teacher karim = Teacher('Mr. Karim', 35, 'Dhaka', 'Flutter');
    final String karimGreet = karim.greet();
    // Hello, I am Mr. Karim, from Dhaka. I teach Flutter.

    // 4. ONE LIST, DIFFERENT GREETINGS: a List<Person> can hold a
    //    Student and a Teacher, because both are Persons.
    //    Each greet() gives its own version.
    final List<Person> people = [abir, sara, karim];
    final String allNames =
        people.map((p) => p.details()).join(' | ');
    // Abir, 22, from Dhaka | Sara, 17, from Chattogram |
    // Mr. Karim, 35, from Dhaka

    // COMPARISON, all in one place, no need for old videos.
    // Without:  class Student { name, age, city, greet }  // repeated
    //           class Teacher { name, age, city, greet }  // repeated
    //           // Change the greeting once, change it in every class.
    // With:     class Person { name, age, city, greet }   // once
    //           class Student extends Person { grade }    // only grade
    //           class Teacher extends Person { subject }  // only subject
    //           // Change the greeting in Person, every child gets it.
    // Use a parent class when classes share the same parts,
    // and a child class when one needs something extra,
    // or a different version of a method.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inheritance'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tap: a person, a student, a teacher',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Abir: $abirGreet'),
            Text('Sara: $saraGreet'),
            Text('Mr. Karim: $karimGreet'),
            const SizedBox(height: 16),
            const Text(
              'One list of people',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(allNames),
            const SizedBox(height: 16),
            const Text(
              'Source code: fluttery.pages.dev',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text('Get the full code at fluttery.pages.dev'),
          ],
        ),
      ),
    );
  }
}
