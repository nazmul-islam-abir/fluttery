import 'package:flutter/material.dart';
import '../services/lesson_service.dart';
import '../theme.dart';
import '../widgets/animated_entrance.dart';
import '../widgets/lesson_card.dart';
import '../widgets/navbar.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      child: AnimatedEntrance(
        index: 0,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('Real-World Projects',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900)),
          const SizedBox(height: 8),
          const Text(
              'Complete, runnable Flutter applications built step-by-step from core lessons. Download full source code and build along.',
              style: TextStyle(color: FlutteryTheme.grey700, fontSize: 16, height: 1.5)),
          const SizedBox(height: 24),
          StreamBuilder(
            stream: LessonService.watchLessons(),
            builder: (context, snap) {
              final projects =
                  (snap.data ?? []).where((l) => l.category == 'Projects').toList();
              if (projects.isEmpty) {
                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(28),
                  decoration: FlutteryTheme.card,
                  child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.construction, color: FlutteryTheme.black),
                            SizedBox(width: 10),
                            Text('First Project Coming Soon',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                          ],
                        ),
                        SizedBox(height: 12),
                        Text(
                          'Complete the Basics + State lessons first! Next, we build real-world apps together: a To-Do App, Weather Dashboard, and News Reader.',
                          style: TextStyle(color: FlutteryTheme.grey700, fontSize: 15, height: 1.6),
                        ),
                      ]),
                );
              }
              return LayoutBuilder(builder: (context, c) {
                final cols = c.maxWidth > 900 ? 3 : c.maxWidth > 560 ? 2 : 1;
                final ratio = cols == 1
                    ? (c.maxWidth < 400 ? 0.65 : 0.70)
                    : (cols == 2 ? 0.68 : 0.76);
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: cols,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: ratio),
                  itemCount: projects.length,
                  itemBuilder: (_, i) => AnimatedEntrance(
                    index: i,
                    child: LessonCard(lesson: projects[i]),
                  ),
                );
              });
            },
          ),
        ]),
      ),
    );
  }
}
