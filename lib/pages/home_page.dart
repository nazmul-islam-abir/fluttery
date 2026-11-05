import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/sample_lessons.dart';
import '../services/lesson_service.dart';
import '../widgets/ad_banner.dart';
import '../widgets/lesson_card.dart';
import '../widgets/navbar.dart';
import '../theme.dart';

// HOME — Hero + How it works + Latest lessons + Topics strip.
// Black & white, minimal. One clear action: Start learning.

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isMobile = width < 760;
    return PageShell(
      child: StreamBuilder(
        stream: LessonService.watchLessons(),
        builder: (context, snap) {
          final lessons = snap.data ?? sampleLessons;
          final featured = lessons.where((l) => l.featured).toList();
          return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            // ── Hero ──
            Padding(
              padding: EdgeInsets.symmetric(vertical: isMobile ? 24 : 48),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                          border: Border.all(color: FlutteryTheme.black),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Text('FREE  •  NO LOGIN  •  JUST LEARN',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1)),
                    ),
                    const SizedBox(height: 20),
                    Text('Learn Flutter,\none video at a time.',
                        style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontSize: isMobile ? 36 : 52)),
                    const SizedBox(height: 16),
                    const Text(
                      'Short YouTube lessons in plain language. '
                      'Watch the video, read the blog, download the .dart file '
                      'and run it yourself. New topics every week.',
                      style: TextStyle(fontSize: 17, color: FlutteryTheme.grey700, height: 1.6),
                    ),
                    const SizedBox(height: 24),
                    Wrap(spacing: 12, runSpacing: 12, children: [
                      ElevatedButton(
                          onPressed: () => context.go('/topics'),
                          child: const Text('Start learning →')),
                      OutlinedButton(
                          onPressed: () => context.go('/projects'),
                          child: const Text('See projects')),
                    ]),
                    const SizedBox(height: 16),
                    Text('${lessons.length} lessons  •  New videos weekly',
                        style: const TextStyle(color: FlutteryTheme.grey500)),
                  ]),
            ),
            const AdBanner(slot: 'top'),
            // ── How it works ──
            const Text('How it works',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
            const SizedBox(height: 16),
            LayoutBuilder(builder: (context, c) {
              final isDesktop = c.maxWidth > 800;
              if (!isDesktop) {
                return const Column(
                  children: [
                    _Step(number: '1', title: 'Watch', text: 'Play the YouTube video right on the lesson page.'),
                    SizedBox(height: 16),
                    _Step(number: '2', title: 'Read', text: 'Same idea in short written form, with the key code.'),
                    SizedBox(height: 16),
                    _Step(number: '3', title: 'Download & run', text: 'Get the .dart file, open it in VS Code, change it, learn.'),
                  ],
                );
              }
              return const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _Step(number: '1', title: 'Watch', text: 'Play the YouTube video right on the lesson page.')),
                  SizedBox(width: 16),
                  Expanded(child: _Step(number: '2', title: 'Read', text: 'Same idea in short written form, with the key code.')),
                  SizedBox(width: 16),
                  Expanded(child: _Step(number: '3', title: 'Download & run', text: 'Get the .dart file, open it in VS Code, change it, learn.')),
                ],
              );
            }),
            const SizedBox(height: 32),
            // ── Latest lessons ──
            Row(children: [
              const Text('Latest lessons',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
              const Spacer(),
              TextButton(
                  onPressed: () => context.go('/topics'),
                  child: const Text('View all →')),
            ]),
            const SizedBox(height: 16),
            _lessonGrid(lessons),
            const AdBanner(slot: 'feed'),
            // ── Featured / Start here ──
            if (featured.isNotEmpty) ...[
              const Text('Start here',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              const Text('If you are brand new, do these in order.',
                  style: TextStyle(color: FlutteryTheme.grey700)),
              const SizedBox(height: 16),
              _lessonGrid(featured),
            ],
          ]);
        },
      ),
    );
  }

  Widget _lessonGrid(List lessons) {
    return LayoutBuilder(builder: (context, c) {
      final cols = c.maxWidth > 900 ? 3 : c.maxWidth > 560 ? 2 : 1;
      final ratio = cols == 1
          ? (c.maxWidth < 400 ? 0.92 : 1.05)
          : (cols == 2 ? 0.75 : 0.82);
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: cols,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: ratio,
        ),
        itemCount: lessons.length,
        itemBuilder: (_, i) => LessonCard(lesson: lessons[i]),
      );
    });
  }
}

class _Step extends StatelessWidget {
  final String number, title, text;
  const _Step({required this.number, required this.title, required this.text});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: FlutteryTheme.card,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(number,
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 4),
          Text(text, style: const TextStyle(color: FlutteryTheme.grey700)),
        ]),
      );
}
