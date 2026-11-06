import 'package:flutter/material.dart';
import '../data/sample_lessons.dart';
import '../services/lesson_service.dart';
import '../theme.dart';
import '../widgets/ad_banner.dart';
import '../widgets/animated_entrance.dart';
import '../widgets/lesson_card.dart';
import '../widgets/navbar.dart';

// TOPICS — filter by category + search. This is your blog index page.

class TopicsPage extends StatefulWidget {
  const TopicsPage({super.key});
  @override
  State<TopicsPage> createState() => _TopicsPageState();
}

class _TopicsPageState extends State<TopicsPage> {
  String selected = 'All';
  String query = '';

  @override
  Widget build(BuildContext context) {
    return PageShell(
      child: AnimatedEntrance(
        index: 0,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Topic Directory',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          const Text(
              'Explore our complete archive of short Flutter tutorials, video lessons, and downloadable Dart examples.',
              style: TextStyle(color: FlutteryTheme.grey700, fontSize: 16, height: 1.5)),
          const SizedBox(height: 24),
          TextField(
            decoration: const InputDecoration(
              hintText: 'Search topics: loop, setState, list, map...',
              prefixIcon: Icon(Icons.search, color: FlutteryTheme.black),
            ),
            onChanged: (v) => setState(() => query = v.toLowerCase()),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: categories.map((c) {
              final active = selected == c;
              return ChoiceChip(
                label: Text(c),
                selected: active,
                selectedColor: FlutteryTheme.black,
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(color: active ? FlutteryTheme.black : FlutteryTheme.grey300),
                ),
                labelStyle: TextStyle(
                    color: active ? Colors.white : FlutteryTheme.black,
                    fontWeight: FontWeight.w700),
                onSelected: (_) => setState(() => selected = c),
              );
            }).toList(),
          ),
          const SizedBox(height: 28),
          StreamBuilder(
            stream: LessonService.watchLessons(),
            builder: (context, snap) {
              var lessons = snap.data ?? sampleLessons;
              if (selected != 'All') {
                lessons = lessons.where((l) => l.category == selected).toList();
              }
              if (query.isNotEmpty) {
                lessons = lessons
                    .where((l) =>
                        ('${l.title} ${l.summary} ${l.tags.join(' ')}')
                            .toLowerCase()
                            .contains(query))
                    .toList();
              }
              if (lessons.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 48),
                  child: Center(
                      child: Text('No lessons found. Try another search query.',
                          style: TextStyle(color: FlutteryTheme.grey700, fontSize: 16))),
                );
              }
              return LayoutBuilder(builder: (context, c) {
                final cols = c.maxWidth > 900 ? 3 : c.maxWidth > 560 ? 2 : 1;
                final ratio = cols == 1
                    ? (c.maxWidth < 400 ? 0.65 : 0.70)
                    : (cols == 2 ? 0.68 : 0.76);
                return Column(
                  children: [
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: cols,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: ratio),
                      itemCount: lessons.length,
                      itemBuilder: (_, i) => AnimatedEntrance(
                        index: i,
                        child: LessonCard(lesson: lessons[i]),
                      ),
                    ),
                    if (lessons.length > 3) const AdBanner(slot: 'feed'),
                  ],
                );
              });
            },
          ),
        ]),
      ),
    );
  }
}
