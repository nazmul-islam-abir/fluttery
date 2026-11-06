import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/app_config.dart';
import '../theme.dart';
import '../widgets/animated_entrance.dart';
import '../widgets/navbar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PageShell(
      child: AnimatedEntrance(
        index: 0,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Image.asset(
              AppConfig.bannerPath,
              width: double.infinity,
              height: 240,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Image.asset(
                AppConfig.logoPath,
                width: double.infinity,
                height: 240,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 28),
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  AppConfig.logoPath,
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 14),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('About Fluttery',
                      style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900)),
                  Text('Free, video-driven Flutter tutorials',
                      style: TextStyle(color: FlutteryTheme.grey500, fontSize: 14)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Fluttery is a free publication dedicated to making Flutter accessible to everyone through concise, practical tutorials.\n\n'
            'Every module consists of a bite-sized video, a clean code breakdown, and a complete runnable .dart file you can download and run instantly. No paywalls, no clutter, no fluff.\n\n'
            'New lessons are published regularly covering core Dart features, state management, UI design, and production architecture. Subscribe on YouTube to stay notified.',
            style: TextStyle(fontSize: 16, height: 1.7, color: FlutteryTheme.grey900),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () => launchUrl(Uri.parse(AppConfig.youtubeChannelUrl),
                mode: LaunchMode.externalApplication),
            icon: const Icon(Icons.subscriptions_outlined),
            label: const Text('Subscribe on YouTube'),
          ),
          const SizedBox(height: 36),
          const Text('How to get the most out of Fluttery',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800)),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: FlutteryTheme.card,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _GuideStep(num: '1', title: 'Browse Topics', text: 'Select any category or search for specific concepts.'),
                Divider(height: 24),
                _GuideStep(num: '2', title: 'Watch Video & Read', text: 'Follow along with the short video and article code snippets.'),
                Divider(height: 24),
                _GuideStep(num: '3', title: 'Download & Experiment', text: 'Get the exact .dart file, open in VS Code/Android Studio, edit and run.'),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class _GuideStep extends StatelessWidget {
  final String num, title, text;
  const _GuideStep({required this.num, required this.title, required this.text});
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: const BoxDecoration(
            color: FlutteryTheme.black,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(num, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 14)),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
              const SizedBox(height: 4),
              Text(text, style: const TextStyle(color: FlutteryTheme.grey700, fontSize: 14, height: 1.5)),
            ],
          ),
        ),
      ],
    );
  }
}
