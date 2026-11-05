import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/lesson.dart';

// ── NO FIREBASE VERSION ────────────────────────────────────────────────────
// Lessons come from a file inside the website itself:
//   assets/lessons.json
// No database, no account, no card, no bill, ever.
// To add a lesson: edit assets/lessons.json + add the .dart file to
// assets/dart_files/ + rebuild + upload again. That is it.

class LessonService {
  static List<Lesson>? _cache;

  static Future<List<Lesson>> getLessons() async {
    if (_cache != null) return _cache!;
    final raw = await rootBundle.loadString('assets/lessons.json');
    final data = jsonDecode(raw) as Map<String, dynamic>;
    final list = (data['lessons'] as List)
        .map((e) => Lesson.fromMap(
            e['id'] as String, Map<String, dynamic>.from(e)))
        .toList()
      ..sort((a, b) => a.order.compareTo(b.order));
    _cache = list;
    return list;
  }

  static Stream<List<Lesson>> watchLessons() async* {
    yield await getLessons();
  }

  static Future<Lesson?> getLessonBySlug(String slug) async {
    final all = await getLessons();
    try {
      return all.firstWhere((l) => l.slug == slug);
    } catch (_) {
      return null;
    }
  }
}
