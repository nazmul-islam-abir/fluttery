import 'package:flutter/material.dart';
import '../config/app_config.dart';
import '../theme.dart';

// ── Ad slot ────────────────────────────────────────────────────────────────
// Web ads = Google AdSense. Flutter web cannot render AdSense directly in
// a normal widget, so this widget reserves the exact space and shows a
// clean placeholder until you paste your real AdSense IDs.
//
// HOW IT WORKS AFTER SETUP:
// 1. Paste your ca-pub ID in web/index.html (see README Step 6).
// 2. In production the AdSense script in index.html fills these slots.
//    The placeholder below is only shown when adsEnabled is false or
//    the slot ID is still the placeholder value.
// 3. Place <AdBanner slot="top"/> at the top of Home, <AdBanner slot="feed"/>
//    between cards, <AdBanner slot="sidebar"/> on the lesson page.
//
// NOTE: Never click your own ads. Use AdSense test mode while developing.

class AdBanner extends StatelessWidget {
  final String slot; // 'top' | 'feed' | 'sidebar'
  final double height;
  const AdBanner({super.key, required this.slot, this.height = 90});

  String get _slotId {
    switch (slot) {
      case 'top':
        return AppConfig.adSlotTopBanner;
      case 'sidebar':
        return AppConfig.adSlotSidebar;
      default:
        return AppConfig.adSlotInFeed;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!AppConfig.adsEnabled) return const SizedBox.shrink();
    final isPlaceholder = _slotId.contains('1111') ||
        _slotId.contains('2222') ||
        _slotId.contains('3333');
    return Container(
      height: height,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: FlutteryTheme.grey100,
        border: Border.all(color: FlutteryTheme.grey200),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(
          isPlaceholder
              ? 'AD SPACE  •  $slot  •  Add your AdSense slot ID in AppConfig'
              : 'Advertisement',
          style: const TextStyle(
              color: FlutteryTheme.grey500,
              fontSize: 12,
              letterSpacing: 1.2),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
