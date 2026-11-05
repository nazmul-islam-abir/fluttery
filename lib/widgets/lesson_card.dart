import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/lesson.dart';
import '../theme.dart';

// Blog card — YouTube thumbnail on top (auto from video ID),
// title, summary, category + level chips, Download .dart button.
// Click anywhere (except Download) → lesson detail page.

class LessonCard extends StatelessWidget {
  final Lesson lesson;
  const LessonCard({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/lesson/${lesson.slug}'),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: FlutteryTheme.card,
        clipBehavior: Clip.antiAlias,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Thumbnail — real YouTube thumbnail, no extra image needed.
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(children: [
              Image.network(
                lesson.thumbnailUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (_, __, ___) => Container(
                  color: FlutteryTheme.grey100,
                  child: const Center(
                      child: Icon(Icons.play_circle_outline, size: 48)),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(6)),
                  child: const Row(mainAxisSize: MainAxisSize.min, children: [
                    Icon(Icons.play_arrow, color: Colors.white, size: 14),
                    SizedBox(width: 4),
                    Text('Watch',
                        style: TextStyle(color: Colors.white, fontSize: 12)),
                  ]),
                ),
              ),
            ]),
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
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          _chip(lesson.category),
                          _chip(lesson.level, outlined: true),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(lesson.title,
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w700),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 4),
                      Text(lesson.summary,
                          style: const TextStyle(
                              color: FlutteryTheme.grey700, fontSize: 12.5),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 8),
                    decoration: BoxDecoration(
                      color: FlutteryTheme.grey100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(children: [
                      const Icon(Icons.file_download_outlined, size: 16),
                      const SizedBox(width: 6),
                      Expanded(
                          child: Text(lesson.dartFileName,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 12),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1)),
                      const SizedBox(width: 6),
                      const Text('Read →',
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                              color: FlutteryTheme.black)),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
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
