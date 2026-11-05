import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/app_config.dart';
import '../widgets/navbar.dart';

// ABOUT — simple, honest, no fluff.

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});
  @override
  Widget build(BuildContext context) {
    return PageShell(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('About Fluttery',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
        const SizedBox(height: 16),
        const Text(
          'Fluttery is a free place to learn Flutter by doing.\n\n'
          'Every topic is a short YouTube video, a short written lesson, and a real .dart file you can download and run yourself. No login. No paywall. No 40-minute theory videos.\n\n'
          'New lessons are added after every YouTube video — Loops, setState, Widgets, and more are coming. If a lesson helped you, subscribe on YouTube so you do not miss the next one.',
          style: TextStyle(fontSize: 16, height: 1.7),
        ),
        const SizedBox(height: 24),
        ElevatedButton.icon(
          onPressed: () => launchUrl(Uri.parse(AppConfig.youtubeChannelUrl),
              mode: LaunchMode.externalApplication),
          icon: const Icon(Icons.subscriptions_outlined),
          label: const Text('Subscribe on YouTube'),
        ),
        const SizedBox(height: 32),
        const Text('How to use this site',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        const Text(
          '1. Go to Topics, pick a lesson.\n'
          '2. Watch the video on the lesson page.\n'
          '3. Download the .dart file.\n'
          '4. Open it in VS Code / Android Studio, run it, change it.\n'
          '5. Come back for the next lesson.',
          style: TextStyle(fontSize: 16, height: 1.8),
        ),
      ]),
    );
  }
}
