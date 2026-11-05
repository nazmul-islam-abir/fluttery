import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/lesson.dart';

// Download button — the core of Fluttery.
// NO FIREBASE VERSION:
// Priority: 1) dartFileUrl, if you pasted one
//           2) The .dart file bundled with the website itself, at:
//              https://YOUR-SITE/assets/assets/dart_files/<file>.dart
//              No database, no Storage, no card needed.
// Tapping opens the file URL in a new tab; the browser downloads it.
// No login, no form, no paywall.

class DownloadDartButton extends StatelessWidget {
  final Lesson lesson;
  final bool large;
  const DownloadDartButton({super.key, required this.lesson, this.large = false});

  Future<void> _download(BuildContext context) async {
    // In a Flutter web build, bundled assets live at
    // /assets/assets/dart_files/<file> on your Hosting site.
    final hostedUrl =
        '${Uri.base.origin}/assets/assets/dart_files/${lesson.dartFileName}';
    final url = lesson.dartFileUrl.isNotEmpty ? lesson.dartFileUrl : hostedUrl;
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open ${lesson.dartFileName}')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (large) {
      return ElevatedButton.icon(
        onPressed: () => _download(context),
        icon: const Icon(Icons.download, size: 20),
        label: Flexible(
          child: Text(
            'Download ${lesson.dartFileName}',
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
      );
    }
    return OutlinedButton.icon(
      onPressed: () => _download(context),
      icon: const Icon(Icons.download, size: 18),
      label: Flexible(
        child: Text(
          lesson.dartFileName,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    );
  }
}
