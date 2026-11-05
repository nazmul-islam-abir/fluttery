import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/app_config.dart';
import '../theme.dart';
import 'ad_iframe_helper.dart';

// ── Adsterra Banner Widget ─────────────────────────────────────────────
// Supports 728x90, 468x60, 320x50, 160x300, Native Banner, and Smart Link.
// Embedded dynamically in Flutter Web via platform views.

class AdBanner extends StatelessWidget {
  final String slot; // 'top' | 'feed' | 'bottom' | 'sidebar' | 'native'
  final double? height;
  const AdBanner({super.key, required this.slot, this.height});

  @override
  Widget build(BuildContext context) {
    if (!AppConfig.adsEnabled) return const SizedBox.shrink();

    final screenWidth = MediaQuery.of(context).size.width;

    String adKey;
    int adWidth;
    int adHeight;
    bool isNative = false;

    if (slot == 'sidebar') {
      adKey = AppConfig.adKey160x300;
      adWidth = 160;
      adHeight = 300;
    } else if (slot == 'native') {
      adKey = AppConfig.adKeyNative;
      adWidth = (screenWidth - 64).clamp(300, 728).toInt();
      adHeight = 160;
      isNative = true;
    } else {
      if (screenWidth >= 768) {
        adKey = AppConfig.adKey728x90;
        adWidth = 728;
        adHeight = 90;
      } else if (screenWidth >= 480) {
        adKey = AppConfig.adKey468x60;
        adWidth = 468;
        adHeight = 60;
      } else {
        adKey = AppConfig.adKey320x50;
        adWidth = 320;
        adHeight = 50;
      }
    }

    final double containerHeight = height ?? (adHeight.toDouble() + 16);
    final String viewId = 'adsterra_${slot}_${adKey}_${adWidth}x$adHeight';

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: FlutteryTheme.grey50,
        border: Border.all(color: FlutteryTheme.grey200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'SPONSORED',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: FlutteryTheme.grey500,
                  letterSpacing: 1.2,
                ),
              ),
              InkWell(
                onTap: () {
                  launchUrl(
                    Uri.parse(AppConfig.smartLinkUrl),
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Promoted Link',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: FlutteryTheme.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    SizedBox(width: 2),
                    Icon(Icons.arrow_outward, size: 12, color: FlutteryTheme.black),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          SizedBox(
            height: containerHeight,
            width: double.infinity,
            child: kIsWeb
                ? getAdIframeWidget(
                    viewId: viewId,
                    adKey: adKey,
                    width: adWidth,
                    height: adHeight,
                    isNative: isNative,
                  )
                : InkWell(
                    onTap: () {
                      launchUrl(
                        Uri.parse(AppConfig.smartLinkUrl),
                        mode: LaunchMode.externalApplication,
                      );
                    },
                    child: Container(
                      color: FlutteryTheme.white,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Adsterra Advertisement',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: FlutteryTheme.black),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Click to view offer (${adWidth}x$adHeight)',
                              style: const TextStyle(
                                  fontSize: 12, color: FlutteryTheme.grey700),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
