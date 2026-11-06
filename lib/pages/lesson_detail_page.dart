import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../config/app_config.dart';
import '../models/lesson.dart';
import '../services/lesson_service.dart';
import '../theme.dart';
import '../widgets/ad_banner.dart';
import '../widgets/animated_entrance.dart';
import '../widgets/download_button.dart';
import '../widgets/navbar.dart';

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
              child: Center(
                  child: Padding(
            padding: EdgeInsets.all(48.0),
            child: CircularProgressIndicator(color: Colors.black),
          )));
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
          child: AnimatedEntrance(
            index: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton.icon(
                  onPressed: () => context.go('/topics'),
                  icon: const Icon(Icons.arrow_back, size: 16),
                  label: const Text('All Topics'),
                ),
                const SizedBox(height: 10),
                Text(
                  lesson.title,
                  style: TextStyle(
                      fontSize: isMobile ? 26 : 38,
                      fontWeight: FontWeight.w900,
                      height: 1.15),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(Icons.schedule, size: 14, color: FlutteryTheme.grey500),
                    const SizedBox(width: 4),
                    Text(
                      '${lesson.level}  •  4 min read  •  Video Included',
                      style: const TextStyle(
                          color: FlutteryTheme.grey500,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Wrap(spacing: 8, runSpacing: 8, children: [
                  _chip(lesson.category),
                  _chip(lesson.level, outlined: true),
                  ...lesson.tags.map((t) => _chip('#$t', outlined: true)),
                ]),
                const SizedBox(height: 24),
                // Video + sidebar layout
                if (isMobile) ...[
                  _buildMainContent(lesson),
                  const SizedBox(height: 24),
                  const AdBanner(slot: 'sidebar', height: 160),
                ] else ...[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 3,
                        child: _buildMainContent(lesson),
                      ),
                      const SizedBox(width: 28),
                      Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            const AdBanner(slot: 'sidebar', height: 300),
                            const SizedBox(height: 16),
                            Container(
                              padding: const EdgeInsets.all(20),
                              decoration: FlutteryTheme.card,
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.lightbulb_outline, color: FlutteryTheme.black),
                                      SizedBox(width: 8),
                                      Text('Learning Tip',
                                          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15)),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    'Download the .dart file below, open it in your IDE, change one line, and see the screen update live!',
                                    style: TextStyle(color: FlutteryTheme.grey700, height: 1.5, fontSize: 13),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMainContent(Lesson lesson) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // YouTube Video Player Container
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: YoutubePlayer(controller: _controller!),
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            OutlinedButton.icon(
              onPressed: () => launchUrl(Uri.parse(lesson.youtubeUrl),
                  mode: LaunchMode.externalApplication),
              icon: const Icon(Icons.play_arrow_rounded, size: 20),
              label: const Text('Watch on YouTube'),
            ),
            OutlinedButton.icon(
              onPressed: () => launchUrl(Uri.parse(AppConfig.youtubeChannelUrl),
                  mode: LaunchMode.externalApplication),
              icon: const Icon(Icons.subscriptions_outlined, size: 18),
              label: const Text('Subscribe Channel'),
            ),
          ],
        ),
        const SizedBox(height: 28),

        // Download Code Box
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: FlutteryTheme.white,
            border: Border.all(color: FlutteryTheme.black, width: 1.5),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: FlutteryTheme.grey100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.code, color: FlutteryTheme.black),
                  ),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Download Source Code',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      Text('Run and test in your local IDE',
                          style: TextStyle(color: FlutteryTheme.grey500, fontSize: 12)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Download ${lesson.dartFileName}, open it in VS Code or Android Studio, run it, then experiment with modifications.',
                style: const TextStyle(color: FlutteryTheme.grey700, height: 1.5),
              ),
              const SizedBox(height: 16),
              DownloadDartButton(lesson: lesson, large: true),
            ],
          ),
        ),

        const SizedBox(height: 32),
        const Text('Lesson Overview',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
        const SizedBox(height: 12),
        Text(
          lesson.body,
          style: const TextStyle(fontSize: 16, height: 1.7, color: FlutteryTheme.grey900),
        ),

        if (lesson.codePreview.isNotEmpty) ...[
          const SizedBox(height: 28),
          const Text('Code Preview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: FlutteryTheme.darkHeader,
              borderRadius: BorderRadius.circular(14),
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SelectableText(
                lesson.codePreview,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'monospace',
                  fontSize: 14,
                  height: 1.6,
                ),
              ),
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
        child: Text(
          text,
          style: TextStyle(
            color: outlined ? FlutteryTheme.black : Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
}
