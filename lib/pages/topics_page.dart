import 'package:flutter/material.dart';
import '../data/sample_lessons.dart';
import '../services/lesson_service.dart';
import '../widgets/ad_banner.dart';
import '../widgets/lesson_card.dart';
import '../widgets/navbar.dart';
import '../theme.dart';

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
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('All topics',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        const Text('Pick a topic. Every lesson has a video, a short blog and a downloadable .dart file.',
            style: TextStyle(color: FlutteryTheme.grey700, fontSize: 16)),
        const SizedBox(height: 20),
        TextField(
          decoration: const InputDecoration(
            hintText: 'Search: loop, setState, widget...',
            prefixIcon: Icon(Icons.search),
          ),
          onChanged: (v) => setState(() => query = v.toLowerCase()),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 8,
          children: categories.map((c) {
            final active = selected == c;
            return ChoiceChip(
              label: Text(c),
              selected: active,
              selectedColor: FlutteryTheme.black,
              labelStyle: TextStyle(
                  color: active ? Colors.white : FlutteryTheme.black,
                  fontWeight: FontWeight.w600),
              onSelected: (_) => setState(() => selected = c),
            );
          }).toList(),
        ),
        const SizedBox(height: 24),
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
                child: Center(child: Text('No lessons found. Try another search.')),
              );
            }
            return LayoutBuilder(builder: (context, c) {
              final cols = c.maxWidth > 900 ? 3 : c.maxWidth > 560 ? 2 : 1;
              final ratio = cols == 1
                  ? (c.maxWidth < 400 ? 0.72 : 0.78)
                  : (cols == 2 ? 0.72 : 0.78);
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
                    itemBuilder: (_, i) => LessonCard(lesson: lessons[i]),
                  ),
                  if (lessons.length > 3) const AdBanner(slot: 'feed'),
                ],
              );
            });
          },
        ),
      ]),
    );
  }
}
