// One lesson = one YouTube video + one blog + one .dart file.
// This is the exact shape of one item in assets/lessons.json.
// Field names below MUST match the field names in that JSON file.

class Lesson {
  final String id; // e.g. "what-is-a-loop"
  final String title; // "What is a Loop in Flutter?"
  final String slug; // URL part: "what-is-a-loop"
  final String category; // "Basics" | "State" | "Widgets" | "Projects"
  final String level; // "Beginner" | "Intermediate"
  final String summary; // 1-2 lines shown on cards
  final String body; // Full blog text. Use \n\n for paragraphs.
  final String youtubeId; // Only the ID, e.g. "dQw4w9WgXcQ"
  final String dartFileName; // "loop_example.dart"
  final String dartFileUrl; // normally "" = use the file bundled with the website
  final String codePreview; // Short code snippet shown on the detail page
  final int order; // 1, 2, 3... controls the learning order
  final bool featured;
  final List<String> tags;

  const Lesson({
    required this.id,
    required this.title,
    required this.slug,
    required this.category,
    required this.level,
    required this.summary,
    required this.body,
    required this.youtubeId,
    required this.dartFileName,
    required this.dartFileUrl,
    required this.codePreview,
    required this.order,
    this.featured = false,
    this.tags = const [],
  });

  String get youtubeUrl => 'https://www.youtube.com/watch?v=$youtubeId';
  String get thumbnailUrl =>
      'https://i.ytimg.com/vi/$youtubeId/hqdefault.jpg';

  factory Lesson.fromMap(String id, Map<String, dynamic> d) {
    return Lesson(
      id: id,
      title: d['title'] ?? '',
      slug: d['slug'] ?? id,
      category: d['category'] ?? 'Basics',
      level: d['level'] ?? 'Beginner',
      summary: d['summary'] ?? '',
      body: d['body'] ?? '',
      youtubeId: d['youtubeId'] ?? '',
      dartFileName: d['dartFileName'] ?? '',
      dartFileUrl: d['dartFileUrl'] ?? '',
      codePreview: d['codePreview'] ?? '',
      order: (d['order'] as num?)?.toInt() ?? 99,
      featured: d['featured'] ?? false,
      tags: List<String>.from(d['tags'] ?? []),
    );
  }

  Map<String, dynamic> toMap() => {
        'title': title,
        'slug': slug,
        'category': category,
        'level': level,
        'summary': summary,
        'body': body,
        'youtubeId': youtubeId,
        'dartFileName': dartFileName,
        'dartFileUrl': dartFileUrl,
        'codePreview': codePreview,
        'order': order,
        'featured': featured,
        'tags': tags,
        'publishedAt': DateTime.now().toIso8601String(),
      };
}
