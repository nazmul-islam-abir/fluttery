import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// NAMED function, for comparison: it has a name, doubleNamed.
int doubleNamed(int n) {
  return n * 2;
}

// CALLBACK WITH A VALUE: applyNumber takes a number and a function,
// then calls that function with the number, and gives back the result.
int applyNumber(int value, int Function(int) operation) {
  return operation(value);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anonymous and Callbacks',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const AnonymousPage(),
    );
  }
}

class AnonymousPage extends StatelessWidget {
  const AnonymousPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. ANONYMOUS FUNCTION: a function with no name, stored in a variable.
    // It is used once, or passed on, so it does not need a name of its own.
    final greet = (String name) => 'Hello, $name!';
    final String greetResult = greet('Abir'); // Hello, Abir!
    final doubleIt = (int n) => n * 2;
    final int doubled5 = doubleIt(5); // 10
    final int named5 = doubleNamed(5); // 10, same answer, named version.

    // 2. CALLBACK: a function passed to another place, to run later.
    // In Flutter, a button's onPressed is a callback: it runs only on tap,
    // not when the screen is built. Here we simulate that tap.
    String tapResult = 'Not pressed';
    void Function() onPressed = () {
      tapResult = 'Button pressed!';
    };
    onPressed(); // Now tapResult is 'Button pressed!'.

    // 3. CALLBACK WITH A VALUE: same applyNumber, different callbacks,
    // different answers, without changing applyNumber itself.
    final int applyDouble = applyNumber(10, (n) => n * 2); // 20
    final int applyAdd = applyNumber(10, (n) => n + 5); // 15

    // 4. ANONYMOUS IN LISTS: map makes a new list, forEach just runs.
    final List<int> doubledList = [1, 2, 3].map((n) => n * 2).toList(); // 2, 4, 6
    final List<int> squares = [2, 3, 4].map((n) => n * n).toList(); // 4, 9, 16

    // COMPARISON, all in one place, no need for old videos.
    // Named:    int doubleNamed(int n) { return n * 2; } // 10 for 5.
    // Anonymous: (int n) => n * 2;                        // 10 for 5.
    // Direct:   doubleIt(5);   // runs now, gives 10 at once.
    // Callback: onPressed;     // runs later, only when tapped.
    // Use a name when you reuse it a lot. Use anonymous for one-time,
    // short jobs, especially as callbacks and inside map and forEach.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Anonymous and Callbacks'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Anonymous function',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(greetResult),
            Text('Double 5: $doubled5, named: $named5'),
            const SizedBox(height: 16),
            const Text(
              'Callback, on tap',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(tapResult),
            const SizedBox(height: 16),
            const Text(
              'Callback with a value',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Apply double to 10: $applyDouble'),
            Text('Apply add 5 to 10: $applyAdd'),
            const SizedBox(height: 16),
            const Text(
              'Anonymous in lists',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Doubled: ${doubledList.join(', ')}'),
            Text('Squares: ${squares.join(', ')}'),
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
