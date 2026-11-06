import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/about_page.dart';
import 'pages/home_page.dart';
import 'pages/lesson_detail_page.dart';
import 'pages/projects_page.dart';
import 'pages/topics_page.dart';
import 'theme.dart';

// Fluttery — NO FIREBASE version.
// No login, no database, no account, no card.
// Lessons are in assets/lessons.json, .dart files in assets/dart_files/.

void main() {
  runApp(const FlutteryApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (_, __) => const HomePage()),
    GoRoute(path: '/topics', builder: (_, __) => const TopicsPage()),
    GoRoute(path: '/projects', builder: (_, __) => const ProjectsPage()),
    GoRoute(path: '/about', builder: (_, __) => const AboutPage()),
    GoRoute(
      path: '/lesson/:slug',
      builder: (_, state) =>
          LessonDetailPage(slug: state.pathParameters['slug'] ?? ''),
    ),
  ],
  errorBuilder: (_, __) => const HomePage(),
);

class FlutteryScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
        PointerDeviceKind.stylus,
      };

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics(
      parent: AlwaysScrollableScrollPhysics(),
    );
  }
}

class FlutteryApp extends StatelessWidget {
  const FlutteryApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Fluttery — Learn Flutter, one video at a time',
      debugShowCheckedModeBanner: false,
      theme: FlutteryTheme.light(),
      scrollBehavior: FlutteryScrollBehavior(),
      routerConfig: _router,
    );
  }
}
