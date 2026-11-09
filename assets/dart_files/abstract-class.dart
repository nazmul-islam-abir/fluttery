import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ABSTRACT CLASS: a blueprint you cannot make directly.
// It says what every child must do, and shares what is common.
// Animal cannot be made on its own. Dog, Cat, and Bird extend it.
abstract class Animal {
  final String name;

  const Animal(this.name);

  // ABSTRACT METHOD: no body here. Every child MUST give its own.
  String makeSound();

  // NORMAL METHOD: has a body, shared by every child, as it is.
  String introduce() => 'I am $name';
}

// DOG: extends Animal, fills in makeSound with Woof.
class Dog extends Animal {
  const Dog(super.name);

  @override
  String makeSound() => 'Woof';
}

// CAT: extends Animal, fills in makeSound with Meow.
class Cat extends Animal {
  const Cat(super.name);

  @override
  String makeSound() => 'Meow';
}

// BIRD: extends Animal, fills in makeSound with Chirp.
class Bird extends Animal {
  const Bird(super.name);

  @override
  String makeSound() => 'Chirp';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Abstract Class',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const AbstractPage(),
    );
  }
}

class AbstractPage extends StatelessWidget {
  const AbstractPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. CHILDREN: each one fills in the abstract method, its own way.
    const Dog buddy = Dog('Buddy');
    const Cat mimi = Cat('Mimi');
    const Bird tweety = Bird('Tweety');

    // 2. ONE LIST, DIFFERENT SOUNDS: a List<Animal> can hold a Dog,
    //    a Cat, and a Bird, because all three are Animals.
    final List<Animal> animals = [buddy, mimi, tweety];
    final String sounds =
        animals.map((a) => '${a.name}: ${a.makeSound()}').join(', ');

    // COMPARISON, all in one place, no need for old videos.
    // Normal:   class Person { ... }  // Person('Abir', 22, 'Dhaka')
    //           // You CAN make a Person directly.
    // Abstract: abstract class Animal { ... }
    //           // Animal('Generic');  // ERROR: cannot make it directly.
    //           // You MUST extend it, then make a Dog, a Cat, a Bird.
    // Abstract method: String makeSound(); // no body, child MUST fill it.
    // Normal method:   String introduce() => 'I am $name'; // shared as is.
    // Use an abstract class when children share a shape,
    // but each one must fill in a part in its own way.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Abstract Class'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tap: Buddy, Mimi, Tweety',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('${buddy.introduce()}, ${buddy.makeSound()}'),
            Text('${mimi.introduce()}, ${mimi.makeSound()}'),
            Text('${tweety.introduce()}, ${tweety.makeSound()}'),
            const SizedBox(height: 16),
            const Text(
              'One list of animals',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(sounds),
            const SizedBox(height: 16),
            const Text(
              'Source code available here',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text('Check the link in the description for the full code.'),
          ],
        ),
      ),
    );
  }
}
