// ── Fluttery — ONE place to change site settings ──────────────────────────
// Change these, redeploy, done. No code hunting.

class AppConfig {
  static const String siteName = 'Fluttery';
  static const String tagline = 'Learn Flutter, one video at a time.';
  static const String description =
      'Simple Flutter lessons in plain language. Watch the YouTube video, '
      'read the short blog, download the .dart file and run it yourself.';

  // Your YouTube channel — used for Subscribe / Watch on YouTube buttons.
  // Paste your channel URL here after you create it.
  static const String youtubeChannelUrl =
      'https://www.youtube.com/@infrarayy';
  static const String youtubeChannelHandle = '@infrarayy';

  // ── Ads: Google AdSense (web) ───────────────────────────────────────────
  // 1. Create an AdSense account, get your Publisher ID: ca-pub-XXXXXXXXXXXXXXXX
  // 2. Paste it in web/index.html (search for ca-pub-) AND here.
  // 3. Create ad units in AdSense and paste the slot IDs below.
  // Until you paste real IDs, AdBanner shows a neat black placeholder
  // labelled "Ad space" so your layout never breaks.
  static const bool adsEnabled = true;
  static const String adsensePublisherId = 'ca-pub-XXXXXXXXXXXXXXXX';
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
