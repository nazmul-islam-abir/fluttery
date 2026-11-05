import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// NULLABLE: ? means this value is allowed to be missing (null).
// Non-nullable String name must always have a value.
// Nullable String? nickname may be null, for now.

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Null Safety',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: const NullSafetyPage(),
    );
  }
}

class NullSafetyPage extends StatelessWidget {
  const NullSafetyPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. NULLABLE ?
    String name = 'Abir';
    String? nickname = null;
    String? city = 'Dhaka';

    // 2. ?? BACKUP: if null, use the backup, otherwise keep the value.
    String shownName = nickname ?? 'Guest'; // Guest, because nickname is null.
    String shownCity = city ?? 'Unknown'; // Dhaka, because city is not null.

    // 3. ??= FILL ONCE: fill only if it is still null, otherwise leave it.
    int? discount;
    discount ??= 100; // Now 100.
    discount ??= 200; // Still 100, because it is no longer null.
    int? marks;
    marks ??= 85; // Now 85.

    // 4. ! PROMISE: I promise this is not null right now.
    // Only use ! after you are sure. Never use it to silence an error.
    String? maybeName = 'Abir';
    int nameLength = maybeName!.length; // 4
    // String? danger = null;
    // danger!.length; // CRASH: never run ! on a value that can still be null.

    // 5. LATE: I will fill this later, before I use it.
    late String welcome;
    welcome = 'Welcome, Abir';
    late String skill;
    skill = 'Flutter';
    // Using a late value before assigning it also crashes, so assign first.

    // 6. ?. SAFE ACCESS: if it is null, stop here and give null, no crash.
    String? phone = null;
    int? phoneLength = phone?.length; // null, not a crash.
    int safePhoneLength = phone?.length ?? 0; // 0, with a backup.

    // COMPARISON, all in one place, no need for old videos.
    // Risky:  name!.length;          // crashes if name is null.
    // Safe:   name ?? 'Guest';       // Guest if name is null.
    // Safe:   name?.length ?? 0;     // 0 if name is null.
    // Fill:   score ??= 50;          // fill once, only if null.
    // Later:  late String city; city = 'Dhaka'; // assign before use.

    return Scaffold(
      appBar: AppBar(
        title: const Text('Null Safety'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Nullable ?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Name: $name'),
            Text('Nickname: ${nickname ?? 'null'}'),
            Text('City: $city'),
            const SizedBox(height: 16),
            const Text(
              'Backup ?? and fill ??=',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Shown name: $shownName'),
            Text('Shown city: $shownCity'),
            Text('Discount: $discount'),
            Text('Marks: $marks'),
            const SizedBox(height: 16),
            const Text(
              'Promise ! and late',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Name length: $nameLength'),
            Text(welcome),
            Text('Skill: $skill'),
            const SizedBox(height: 16),
            const Text(
              'Safe access ?.',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Phone length: ${phoneLength ?? 'null'}'),
            Text('Safe phone length: $safePhoneLength'),
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
