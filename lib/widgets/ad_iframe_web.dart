// ignore_for_file: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'dart:ui_web' as ui_web;
import 'package:flutter/material.dart';

final Set<String> _registeredViews = {};

Widget getAdIframeWidget({
  required String viewId,
  required String adKey,
  required int width,
  required int height,
  bool isNative = false,
}) {
  if (!_registeredViews.contains(viewId)) {
    _registeredViews.add(viewId);
    ui_web.platformViewRegistry.registerViewFactory(viewId, (int id) {
      final iframe = html.IFrameElement()
        ..style.width = '100%'
        ..style.height = '100%'
        ..style.border = 'none'
        ..style.overflow = 'hidden';

      final String htmlContent;
      if (isNative) {
        htmlContent = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <style>
    body { margin: 0; padding: 0; background: transparent; text-align: center; }
  </style>
</head>
<body>
  <script async="async" data-cfasync="false" src="https://bauval.org/21/$adKey"></script>
  <div id="container-$adKey"></div>
</body>
</html>
''';
      } else {
        htmlContent = '''
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <style>
    body { margin: 0; padding: 0; overflow: hidden; display: flex; justify-content: center; align-items: center; background: transparent; }
  </style>
</head>
<body>
  <script type="text/javascript">
    atOptions = {
      'key' : '$adKey',
      'format' : 'iframe',
      'height' : $height,
      'width' : $width,
      'params' : {}
    };
  </script>
  <script type="text/javascript" src="https://bauval.org/22/$adKey"></script>
</body>
</html>
''';
      }

      iframe.srcdoc = htmlContent;
      return iframe;
    });
  }

  return HtmlElementView(viewType: viewId);
}
