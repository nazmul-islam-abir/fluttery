// Fluttery — Widgets Explained Simply
// Everything is a widget. This screen is: Scaffold > Column > [Text, Button]
// Paste into lib/main.dart and run.

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('Widgets Example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Hello, Fluttery!', style: TextStyle(fontSize: 24)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {},
                child: const Text('I am a Button widget'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
