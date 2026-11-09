import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// INTERFACE: a contract. It says what a class must be able to do,
// without saying how. In Dart there is no separate interface word:
// any class can be used as an interface, usually an abstract class
// with only method names, no bodies.
abstract class Flyable {
  String fly();
}

abstract class Swimmable {
  String swim();
}

// BIRD: implements Flyable. It gets NO code from Flyable,
// only the promise. It must give fly() a body, its own way.
class Bird implements Flyable {
  const Bird();

  @override
  String fly() => 'I fly with wings';
}

// PLANE: also implements Flyable, a different body for the same method.
class Plane implements Flyable {
  const Plane();

  @override
  String fly() => 'I fly with engines';
}

// DUCK: implements TWO interfaces at once, Flyable and Swimmable.
// extends allows only one parent. implements allows many.
class Duck implements Flyable, Swimmable {
  const Duck();

  @override
  String fly() => 'I fly with wings';

  @override
  String swim() => 'I swim in the pond';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Interface',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const InterfacePage(),
    );
  }
}

class InterfacePage extends StatelessWidget {
  const InterfacePage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. THREE FLYERS: a Bird, a Plane, and a Duck, all Flyable.
    const Bird bird = Bird();
    const Plane plane = Plane();
    const Duck duck = Duck();

    // 2. ONE LIST, DIFFERENT FLYING: a List<Flyable> can hold
    //    a Bird, a Plane, and a Duck, because all three are Flyable.
    final List<Flyable> flyers = [bird, plane, duck];
    final String flights =
        flyers.map((f) => f.fly()).join(', ');

    // COMPARISON, all in one place, no need for old videos.
    // extends:    class Dog extends Animal { ... }
    //             // ONE parent only. Gets the parent's code.
    //             // Can override, can keep the parent's method as is.
    // implements: class Bird implements Flyable { ... }
    //             // MANY interfaces at once. Gets NO code at all.
    //             // Must give a body to EVERY method of the interface.
    // abstract:   abstract class Animal { ... }
    //             // Cannot make it directly. Child must fill the
    //             // abstract methods, but gets the normal methods free.
    // Use implements when different kinds of things must all
    // promise the same ability, each in its own way.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Interface'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Tap: Bird, Plane, Duck',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Bird: ${bird.fly()}'),
            Text('Plane: ${plane.fly()}'),
            Text('Duck: ${duck.fly()}'),
            Text('Duck: ${duck.swim()}'),
            const SizedBox(height: 16),
            const Text(
              'One list of flyers',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(flights),
            const SizedBox(height: 16),
            const Text(
              'Source code: fluttery.pages.dev',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text('Full code available at fluttery.pages.dev.'),
          ],
        ),
      ),
    );
  }
}
