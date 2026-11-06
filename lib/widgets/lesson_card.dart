import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/lesson.dart';
import '../theme.dart';

// Blog card — YouTube thumbnail, category badge, reading time,
// animated hover translation & scale, code download indicator.

class LessonCard extends StatefulWidget {
  final Lesson lesson;
  const LessonCard({super.key, required this.lesson});

  @override
  State<LessonCard> createState() => _LessonCardState();
}

class _LessonCardState extends State<LessonCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () => context.go('/lesson/${widget.lesson.slug}'),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOutCubic,
          transform: _isHovered ? (Matrix4.identity()..translate(0, -6, 0)) : Matrix4.identity(),
          decoration: _isHovered ? FlutteryTheme.cardHover : FlutteryTheme.card,
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Stack(
                  children: [
                    AnimatedScale(
                      scale: _isHovered ? 1.04 : 1.0,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeOutCubic,
                      child: Image.network(
                        widget.lesson.thumbnailUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (_, __, ___) => Container(
                          color: FlutteryTheme.grey100,
                          child: const Center(
                            child: Icon(Icons.play_circle_outline, size: 48, color: FlutteryTheme.grey500),
                          ),
                        ),
                      ),
                    ),
                    Positioned.fill(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        color: _isHovered
                            ? Colors.black.withOpacity(0.12)
                            : Colors.transparent,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: FlutteryTheme.black.withOpacity(0.85),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.lesson.category.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      right: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.play_arrow, color: Colors.white, size: 14),
                            SizedBox(width: 4),
                            Text(
                              'Watch Lesson',
                              style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Icon(Icons.schedule, size: 13, color: FlutteryTheme.grey500),
                              SizedBox(width: 4),
                              Text(
                                '4 min read  •  Video Included',
                                style: TextStyle(
                                  color: FlutteryTheme.grey500,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.lesson.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              height: 1.3,
                              color: _isHovered ? FlutteryTheme.black : FlutteryTheme.grey900,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Text(
                            widget.lesson.summary,
                            style: const TextStyle(
                              color: FlutteryTheme.grey700,
                              fontSize: 12.5,
                              height: 1.4,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        decoration: BoxDecoration(
                          color: _isHovered ? FlutteryTheme.black : FlutteryTheme.grey100,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.code,
                              size: 15,
                              color: _isHovered ? Colors.white : FlutteryTheme.black,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                widget.lesson.dartFileName,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12,
                                  color: _isHovered ? Colors.white : FlutteryTheme.black,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Icons.arrow_forward_rounded,
                              size: 14,
                              color: _isHovered ? Colors.white : FlutteryTheme.black,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
