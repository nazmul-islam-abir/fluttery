import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../config/app_config.dart';
import '../models/lesson.dart';
import '../services/lesson_service.dart';
import '../widgets/ad_banner.dart';
import '../widgets/download_button.dart';
import '../widgets/navbar.dart';
import '../theme.dart';

// LESSON DETAIL — the most important page.
// Top: title + chips. Middle: YouTube player (click thumbnail → plays here).
// Below: Download .dart (big black button) + blog text + code preview.
// Right on desktop: sidebar with next lesson + ad.

class LessonDetailPage extends StatefulWidget {
  final String slug;
  const LessonDetailPage({super.key, required this.slug});
  @override
  State<LessonDetailPage> createState() => _LessonDetailPageState();
}

class _LessonDetailPageState extends State<LessonDetailPage> {
  YoutubePlayerController? _controller;

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Lesson?>(
      future: LessonService.getLessonBySlug(widget.slug),
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const PageShell(
              child: Center(child: CircularProgressIndicator(color: Colors.black)));
        }
        final lesson = snap.data;
        if (lesson == null) {
          return PageShell(
            child: Column(children: [
              const Text('Lesson not found',
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800)),
              const SizedBox(height: 12),
              ElevatedButton(
                  onPressed: () => context.go('/topics'),
                  child: const Text('Back to topics')),
            ]),
          );
        }
        _controller ??= YoutubePlayerController.fromVideoId(
          videoId: lesson.youtubeId,
          params: const YoutubePlayerParams(showControls: true),
        );
        final width = MediaQuery.of(context).size.width;
        final isMobile = width < 860;
        return PageShell(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextButton(
                onPressed: () => context.go('/topics'),
                child: const Text('← All topics')),
            const SizedBox(height: 8),
            Text(lesson.title,
                style: TextStyle(
                    fontSize: isMobile ? 28 : 36, fontWeight: FontWeight.w800)),
            const SizedBox(height: 12),
            Wrap(spacing: 8, children: [
              _chip(lesson.category),
              _chip(lesson.level, outlined: true),
              ...lesson.tags.map((t) => _chip('#$t', outlined: true)),
            ]),
            const SizedBox(height: 20),
            // Video + sidebar layout
            if (isMobile) ...[
              _buildMainContent(lesson),
              const SizedBox(height: 24),
              const AdBanner(slot: 'sidebar', height: 120),
            ] else ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: _buildMainContent(lesson),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 1,
                    child: Column(children: [
                      const AdBanner(slot: 'sidebar', height: 250),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: FlutteryTheme.card,
                        child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('New here?',
                                  style: TextStyle(fontWeight: FontWeight.w700)),
                              SizedBox(height: 6),
                              Text(
                                  'Start from the first lesson and go in order. Each one builds on the last.',
                                  style: TextStyle(color: FlutteryTheme.grey700)),
                            ]),
                      ),
                    ]),
                  ),
                ],
              ),
            ],
          ]),
        );
      },
    );
  }

  Widget _buildMainContent(Lesson lesson) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // YouTube embed — plays inline, no redirect needed.
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: YoutubePlayer(controller: _controller!),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            OutlinedButton.icon(
              onPressed: () => launchUrl(
                  Uri.parse(lesson.youtubeUrl),
                  mode: LaunchMode.externalApplication),
              icon: const Icon(Icons.play_arrow, size: 18),
              label: const Text('Watch on YouTube'),
            ),
            OutlinedButton.icon(
              onPressed: () => launchUrl(
                  Uri.parse(AppConfig.youtubeChannelUrl),
                  mode: LaunchMode.externalApplication),
              icon: const Icon(Icons.subscriptions_outlined, size: 18),
              label: const Text('Subscribe'),
            ),
          ],
        ),
        const SizedBox(height: 24),
        // Download — the action you want every visitor to take.
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: FlutteryTheme.grey50,
            border: Border.all(color: FlutteryTheme.black),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Get the code',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(
                    'Download ${lesson.dartFileName}, open it in VS Code, run it, then change one thing and run it again. That is how you learn.',
                    style: const TextStyle(
                        color: FlutteryTheme.grey700)),
                const SizedBox(height: 16),
                DownloadDartButton(lesson: lesson, large: true),
                const SizedBox(height: 8),
                const Text('Free  •  No login  •  .dart file',
                    style: TextStyle(
                        color: FlutteryTheme.grey500,
                        fontSize: 13)),
              ]),
        ),
        const SizedBox(height: 28),
        const Text('Read the lesson',
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.w800)),
        const SizedBox(height: 12),
        Text(lesson.body,
            style: const TextStyle(
                fontSize: 16,
                height: 1.7,
                color: FlutteryTheme.grey900)),
        if (lesson.codePreview.isNotEmpty) ...[
          const SizedBox(height: 24),
          const Text('Key code',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: FlutteryTheme.black,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SelectableText(lesson.codePreview,
                  style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'monospace',
                      fontSize: 14,
                      height: 1.6)),
            ),
          ),
        ],
      ],
    );
  }

  Widget _chip(String text, {bool outlined = false}) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: outlined ? Colors.white : FlutteryTheme.black,
          border: Border.all(color: FlutteryTheme.black),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text,
            style: TextStyle(
                color: outlined ? FlutteryTheme.black : Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600)),
      );
}
