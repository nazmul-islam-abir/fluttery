import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                                    'Download or copy the .dart code below, test it in your IDE, change one line, and see the screen update live!',
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
                      Text('Get Source Code File',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                      Text('Download .dart file to run locally',
                          style: TextStyle(color: FlutteryTheme.grey500, fontSize: 12)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                'Download ${lesson.dartFileName} or copy the full code directly below without downloading.',
                style: const TextStyle(color: FlutteryTheme.grey700, height: 1.5),
              ),
              const SizedBox(height: 16),
              DownloadDartButton(lesson: lesson, large: true),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Full Source Code Viewer Box with Copy Button
        _FullCodeViewer(
          dartFileName: lesson.dartFileName,
          fallbackCode: lesson.codePreview,
        ),

        const SizedBox(height: 36),
        const Text('Lesson Overview',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
        const SizedBox(height: 12),
        Text(
          lesson.body,
          style: const TextStyle(fontSize: 16, height: 1.7, color: FlutteryTheme.grey900),
        ),
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

class _FullCodeViewer extends StatefulWidget {
  final String dartFileName;
  final String fallbackCode;

  const _FullCodeViewer({
    required this.dartFileName,
    required this.fallbackCode,
  });

  @override
  State<_FullCodeViewer> createState() => _FullCodeViewerState();
}

class _FullCodeViewerState extends State<_FullCodeViewer> {
  bool _isCopied = false;
  late Future<String> _codeFuture;

  @override
  void initState() {
    super.initState();
    _codeFuture = _loadCode();
  }

  @override
  void didUpdateWidget(_FullCodeViewer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.dartFileName != widget.dartFileName) {
      _codeFuture = _loadCode();
    }
  }

  Future<String> _loadCode() async {
    try {
      if (widget.dartFileName.isEmpty) return widget.fallbackCode;
      final code = await rootBundle.loadString('assets/dart_files/${widget.dartFileName}');
      return code.trim().isNotEmpty ? code : widget.fallbackCode;
    } catch (_) {
      return widget.fallbackCode;
    }
  }

  void _copyToClipboard(String code) {
    Clipboard.setData(ClipboardData(text: code));
    setState(() => _isCopied = true);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.greenAccent),
            SizedBox(width: 8),
            Text('Full source code copied to clipboard!'),
          ],
        ),
        duration: Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) setState(() => _isCopied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _codeFuture,
      builder: (context, snapshot) {
        final codeText = snapshot.data ?? widget.fallbackCode;
        final lines = codeText.split('\n');

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      const Icon(Icons.code_rounded, size: 22, color: FlutteryTheme.black),
                      const SizedBox(width: 8),
                      Flexible(
                        child: Text(
                          'Full Source Code (${widget.dartFileName})',
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: codeText.isEmpty ? null : () => _copyToClipboard(codeText),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isCopied ? Colors.green : FlutteryTheme.black,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  icon: Icon(_isCopied ? Icons.check_rounded : Icons.content_copy_rounded, size: 16),
                  label: Text(_isCopied ? 'Copied!' : 'Copy Code', style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              constraints: const BoxConstraints(maxHeight: 520),
              decoration: BoxDecoration(
                color: FlutteryTheme.darkHeader,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: FlutteryTheme.grey700),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.12),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Column(
                  children: [
                    // Top header bar of code viewer
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      color: const Color(0xFF1E293B),
                      child: Row(
                        children: [
                          const Icon(Icons.description_outlined, color: Colors.white70, size: 16),
                          const SizedBox(width: 8),
                          Text(
                            widget.dartFileName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Text(
                              'Dart',
                              style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Code content area with line numbers and scrolling
                    Expanded(
                      child: snapshot.connectionState == ConnectionState.waiting
                          ? const Center(child: CircularProgressIndicator(color: Colors.white))
                          : SingleChildScrollView(
                              padding: const EdgeInsets.all(16),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Line numbers column
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: List.generate(
                                        lines.length,
                                        (i) => Text(
                                          '${i + 1} ',
                                          style: const TextStyle(
                                            color: Color(0xFF64748B),
                                            fontFamily: 'monospace',
                                            fontSize: 13.5,
                                            height: 1.6,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 16),
                                    // Code content column
                                    SelectableText(
                                      codeText,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'monospace',
                                        fontSize: 13.5,
                                        height: 1.6,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
