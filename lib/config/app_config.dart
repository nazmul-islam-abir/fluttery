// ── Fluttery — ONE place to change site settings ──────────────────────────
// Change these, redeploy, done. No code hunting.

class AppConfig {
  static const String siteName = 'Fluttery';
  static const String tagline = 'Learn Flutter, one video at a time.';
  static const String description =
      'Simple Flutter lessons in plain language. Watch the YouTube video, '
      'read the short blog, download the .dart file and run it yourself.';

  static const String logoPath = 'assets/logo.jpg';
  static const String bannerPath = 'assets/banner.jpg';

  // Your YouTube channel — used for Subscribe / Watch on YouTube buttons.
  // Paste your channel URL here after you create it.
  static const String youtubeChannelUrl =
      'https://www.youtube.com/@infrarayy';
  static const String youtubeChannelHandle = '@infrarayy';

  // ── Ads: Adsterra Monetization ───────────────────────────────────────────
  static const bool adsEnabled = true;
  static const String smartLinkUrl =
      'https://araplhn.org/4/65f0e66190b22b6f3b6aec5f213121fc';

  // Adsterra Banner Keys
  static const String adKey728x90 = 'c1b092c51110094614f29406f68b197a'; // Leaderboard
  static const String adKey468x60 = '9da836dd0d75a1a5b15008934d8f5869'; // Standard Banner
  static const String adKey320x50 = '7195cd9643962ebe15a0eda53d2cc257'; // Mobile Banner
  static const String adKey160x300 = 'e76a293979988f56728f8a1fcd4f66d4'; // Sidebar Skyscraper
  static const String adKeyNative = '9e4783058b91342d7f1507c9969f8642'; // Native Banner

  static const String adSlotTopBanner = '1111111111'; // 728x90 / responsive
  static const String adSlotInFeed = '2222222222'; // between lesson cards
  static const String adSlotSidebar = '3333333333'; // lesson detail page

  // ── .dart downloads — FREE, no Firebase at all ──────────────────────────
  // The .dart files in assets/dart_files/ are bundled with the website.
  // Leave dartFileUrl empty in lessons.json and the Download button
  // uses that bundled file.
  // Your site URL after deploy, e.g. https://yourname.github.io/fluttery
  static const String siteUrl = 'https://YOUR-SITE.web.app';
  static const String dartFilesFolder = 'assets/dart_files';
}
