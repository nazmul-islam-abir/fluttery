import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../config/app_config.dart';
import '../data/sample_lessons.dart';
import '../services/lesson_service.dart';
import '../theme.dart';
import '../widgets/ad_banner.dart';
import '../widgets/animated_entrance.dart';
import '../widgets/lesson_card.dart';
import '../widgets/navbar.dart';

// HOME — Editorial Hero + Step guide + Animated Lesson grid + Newsletter.

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

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Editorial Featured Hero ──
              AnimatedEntrance(
                index: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: isMobile ? 16 : 32),
                  child: LayoutBuilder(builder: (context, constraints) {
                    final isWide = constraints.maxWidth > 800;
                    final textContent = Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: FlutteryTheme.black,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Text('FEATURED ARTICLE',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w800,
                                      letterSpacing: 1.2)),
                            ),
                            const SizedBox(width: 10),
                            const Text('•  FREE TUTORIALS',
                                style: TextStyle(
                                    color: FlutteryTheme.grey500,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.8)),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Learn Flutter,\none video at a time.',
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                fontSize: isMobile ? 36 : 52,
                                fontWeight: FontWeight.w900,
                              ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Short YouTube lessons in plain language. '
                          'Watch the video, read the blog, download the .dart file '
                          'and run it yourself. New topics added weekly.',
                          style: TextStyle(
                              fontSize: 17,
                              color: FlutteryTheme.grey700,
                              height: 1.6),
                        ),
                        const SizedBox(height: 24),
                        Wrap(spacing: 12, runSpacing: 12, children: [
                          ElevatedButton.icon(
                            onPressed: () => context.go('/topics'),
                            icon: const Icon(Icons.play_circle_fill, size: 18),
                            label: const Text('Start learning →'),
                          ),
                          OutlinedButton.icon(
                            onPressed: () => context.go('/projects'),
                            icon: const Icon(Icons.folder_special, size: 18),
                            label: const Text('See projects'),
                          ),
                        ]),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            const Icon(Icons.check_circle_outline,
                                size: 16, color: FlutteryTheme.grey500),
                            const SizedBox(width: 6),
                            Text('${lessons.length} lessons available  •  Updated weekly',
                                style: const TextStyle(
                                    color: FlutteryTheme.grey500,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ],
                    );

                    final bannerCard = Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: FlutteryTheme.grey200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.06),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          Image.asset(
                            AppConfig.bannerPath,
                            fit: BoxFit.cover,
                            height: isWide ? 380 : 240,
                            width: double.infinity,
                            errorBuilder: (_, __, ___) => Image.asset(
                              AppConfig.logoPath,
                              fit: BoxFit.cover,
                              height: isWide ? 380 : 240,
                              width: double.infinity,
                            ),
                          ),
                          Positioned(
                            bottom: 16,
                            left: 16,
                            right: 16,
                            child: Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.92),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: FlutteryTheme.grey200),
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.workspace_premium, color: FlutteryTheme.black),
                                  SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      'Interactive Flutter Lessons with Downloadable Code',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );

                    if (isWide) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(flex: 5, child: textContent),
                          const SizedBox(width: 32),
                          Expanded(flex: 4, child: bannerCard),
                        ],
                      );
                    } else {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          textContent,
                          const SizedBox(height: 24),
                          bannerCard,
                        ],
                      );
                    }
                  }),
                ),
              ),

              const AdBanner(slot: 'top'),

              // ── How it works ──
              AnimatedEntrance(
                index: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    const Text('How it works',
                        style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
                    const SizedBox(height: 6),
                    const Text('Master Flutter step-by-step with three simple steps.',
                        style: TextStyle(color: FlutteryTheme.grey700, fontSize: 15)),
                    const SizedBox(height: 20),
                    LayoutBuilder(builder: (context, c) {
                      final isDesktop = c.maxWidth > 800;
                      if (!isDesktop) {
                        return const Column(
                          children: [
                            _Step(number: '01', title: 'Watch Video', text: 'Play the concise YouTube lesson directly on the article page.'),
                            SizedBox(height: 16),
                            _Step(number: '02', title: 'Read Guide', text: 'Review key concepts, visual diagrams, and code breakdowns.'),
                            SizedBox(height: 16),
                            _Step(number: '03', title: 'Download & Run', text: 'Get the exact .dart file, test it in VS Code/Android Studio.'),
                          ],
                        );
                      }
                      return const Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(child: _Step(number: '01', title: 'Watch Video', text: 'Play the concise YouTube lesson directly on the article page.')),
                          SizedBox(width: 16),
                          Expanded(child: _Step(number: '02', title: 'Read Guide', text: 'Review key concepts, visual diagrams, and code breakdowns.')),
                          SizedBox(width: 16),
                          Expanded(child: _Step(number: '03', title: 'Download & Run', text: 'Get the exact .dart file, test it in VS Code/Android Studio.')),
                        ],
                      );
                    }),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              // ── Latest Lessons Grid ──
              AnimatedEntrance(
                index: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('Latest Articles & Lessons',
                            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
                        const Spacer(),
                        TextButton.icon(
                          onPressed: () => context.go('/topics'),
                          icon: const Icon(Icons.grid_view_rounded, size: 16),
                          label: const Text('View All →', style: TextStyle(fontWeight: FontWeight.w700)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _lessonGrid(lessons),
                  ],
                ),
              ),

              const AdBanner(slot: 'feed'),

              // ── Featured / Start here ──
              if (featured.isNotEmpty) ...[
                AnimatedEntrance(
                  index: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 24),
                      const Text('Beginner Learning Path',
                          style: TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 6),
                      const Text('If you are brand new to Flutter, complete these core modules in order.',
                          style: TextStyle(color: FlutteryTheme.grey700, fontSize: 15)),
                      const SizedBox(height: 16),
                      _lessonGrid(featured),
                    ],
                  ),
                ),
              ],

              const SizedBox(height: 40),

              // ── Newsletter Section (Inspired by SportsReel Design) ──
              const AnimatedEntrance(
                index: 4,
                child: _NewsletterSection(),
              ),

              const SizedBox(height: 24),
            ],
          );
        },
      ),
    );
  }

  Widget _lessonGrid(List lessons) {
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
          childAspectRatio: ratio,
        ),
        itemCount: lessons.length,
        itemBuilder: (_, i) => AnimatedEntrance(
          index: i,
          child: LessonCard(lesson: lessons[i]),
        ),
      );
    });
  }
}

class _Step extends StatelessWidget {
  final String number, title, text;
  const _Step({required this.number, required this.title, required this.text});
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(22),
        decoration: FlutteryTheme.card,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(number,
              style: const TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: FlutteryTheme.black)),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 6),
          Text(text, style: const TextStyle(color: FlutteryTheme.grey700, height: 1.5)),
        ]),
      );
}

class _NewsletterSection extends StatefulWidget {
  const _NewsletterSection();
  @override
  State<_NewsletterSection> createState() => _NewsletterSectionState();
}

class _NewsletterSectionState extends State<_NewsletterSection> {
  final _controller = TextEditingController();
  bool _subscribed = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: FlutteryTheme.darkHeader,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: LayoutBuilder(builder: (context, c) {
        final isMobile = c.maxWidth < 700;
        final infoColumn = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: FlutteryTheme.tealBrand,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                'WEEKLY FLUTTER DIGEST',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1),
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Join 10,000+ Flutter Learners',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.w900,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Get short Dart tips, new video lessons, and downloadable code straight to your inbox.',
              style: TextStyle(color: FlutteryTheme.grey300, fontSize: 15, height: 1.5),
            ),
          ],
        );

        final form = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_subscribed) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white10,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white24),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.check_circle, color: Colors.greenAccent),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Thank you for subscribing! Check your inbox soon.',
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      style: const TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        hintText: 'Enter your email address',
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      if (_controller.text.contains('@')) {
                        setState(() => _subscribed = true);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: FlutteryTheme.black,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text('Subscribe →', style: TextStyle(fontWeight: FontWeight.w800)),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text('No spam. Unsubscribe anytime.',
                  style: TextStyle(color: FlutteryTheme.grey500, fontSize: 12)),
            ],
          ],
        );

        if (isMobile) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              infoColumn,
              const SizedBox(height: 20),
              form,
            ],
          );
        } else {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(flex: 5, child: infoColumn),
              const SizedBox(width: 32),
              Expanded(flex: 4, child: form),
            ],
          );
        }
      }),
    );
  }
}
