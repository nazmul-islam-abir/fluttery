# Fluttery — Learn Flutter, one video at a time

## NO FIREBASE VERSION — totally free, no card, no account

**What does "no Firebase, totally free" mean?**

- **No Firebase at all.** No Firebase project, no Firestore, no Storage, no Hosting, no `flutterfire configure`, no billing page.
- **No database online.** Your lessons are NOT in a database. They are in a **file inside your website**: `assets/lessons.json`
- **No card, no account for the data.** Nobody can charge you, because there is no service to charge you for.
- **Your .dart files are also inside your website**: `assets/dart_files/`

That is the whole idea. A normal website is just files. Your website is just files too.

### How it works — in simple words

```
You edit 1 file:  assets/lessons.json   (title, YouTube video ID, summary...)
You add 1 file:   assets/dart_files/new_lesson.dart
You build:        flutter build web --release
You upload the build/web folder to a free host (below)
Visitor opens your link → sees the lesson → clicks Download → gets the .dart file
```

No login. No database. No Firebase Console. No monthly limit to worry about.

### How to add a new lesson (after every YouTube video)

1. Open `assets/lessons.json` in VS Code
2. Copy one lesson block, paste it, change:
   - `title`, `slug` (example: `what-is-a-loop` — this becomes the URL)
   - `youtubeId` — only the ID after `v=` in your YouTube link
   - `summary`, `body`, `dartFileName`
   - `order` — 4, 5, 6...
3. Save your `.dart` file in `assets/dart_files/` with that same `dartFileName`
4. Rebuild + upload again (see Hosting below). Done.

### Free hosting — no card (pick ONE, easiest first)

**Easiest: Netlify Drop**
1. Run: `flutter build web --release`
2. Go to https://app.netlify.com/drop — drag the `build/web` folder onto the page
3. You get a free link like `https://fluttery-123.netlify.app`
4. Every update: rebuild, drag the folder again. Free account, no card.

**Also free: GitHub Pages**
1. Create a free GitHub account, create a repo named `fluttery`
2. Run: `flutter build web --release --base-href /fluttery/`
3. Upload the contents of `build/web` to the repo, turn on Pages in Settings → Pages
4. Your link: `https://YOURNAME.github.io/fluttery/`
5. Every update: rebuild, upload the new files. Free, no card.

Do NOT use Firebase Hosting for this version — that would bring Firebase back.

### What you lose without Firebase (be honest)

- You cannot add a lesson from a website form. You must edit the JSON file and re-upload. That takes 2 minutes.
- No live update. The site only changes after you rebuild + upload.
- For a small blog like Fluttery, that is fine. You already rebuild after every video anyway.

### What you keep

- Same design: black & white, minimal, responsive
- Same pages: Home, Topics, Lesson detail, Projects, About
- Same YouTube embed, same Download button, same search + filter
- Same AdSense slots (AdSense is separate from Firebase — apply after 8–10 lessons are live, still no card needed to apply)

### Run it on your computer

```bash
cd fluttery
flutter pub get
flutter run -d chrome
```

No `flutterfire configure`. No Firebase login. No keys.

---

## Old Firebase version

The Firebase version was removed from this project on 2026-11-06 at the user's request (no card, totally free). If you ever get a card later and want Firestore again, ask me and I will bring it back — the lessons are already in the same shape in `assets/lessons.json`.
