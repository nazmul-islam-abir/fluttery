import 'package:flutter/material.dart';
import '../services/lesson_service.dart';
import '../widgets/lesson_card.dart';
import '../widgets/navbar.dart';

// PROJECTS — bigger builds made from the lessons.
// For now it filters lessons in the "Projects" category.
// When you add a project lesson in assets/lessons.json with category = Projects,
// it appears here automatically. No code change needed.

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return PageShell(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('Projects',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
        const SizedBox(height: 8),
        const Text(
            'Small complete apps built from the lessons. Download the full .dart file and build along.',
            style: TextStyle(color: Color(0xFF555555), fontSize: 16)),
        const SizedBox(height: 24),
        StreamBuilder(
          stream: LessonService.watchLessons(),
          builder: (context, snap) {
            final projects =
                (snap.data ?? []).where((l) => l.category == 'Projects').toList();
            if (projects.isEmpty) {
              return Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFE8E8E8)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('First project coming soon',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
                      SizedBox(height: 8),
                      Text('Finish the Basics + State lessons first — then we build a real app together: a simple To-Do app, then a Weather app.\n\nTo add a project: in assets/lessons.json add a lesson with category = "Projects". It shows up here automatically.'),
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
                itemBuilder: (_, i) => LessonCard(lesson: projects[i]),
              );
            });
          },
        ),
      ]),
    );
  }
}
