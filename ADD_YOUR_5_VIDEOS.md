# Add your 5 videos + 5 files — step by step

You already have 3 lessons in the site: Loop, setState, Widgets.
Your 5 videos will become lessons 1 to 5. If 2 of them are Loop and setState,
just replace those. If they are 5 NEW topics, add them as 4, 5, 6, 7, 8.

You do only 3 things for each video. Same 3 things, 5 times.

---

## STEP 1 — Get the YouTube ID (30 seconds per video)

Your YouTube link looks like this:
```
https://www.youtube.com/watch?v=dQw4w9WgXcQ
                                       ^^^^^^^^^^^
                                       THIS is the ID
```

Copy ONLY the part after `v=`.
- Full link: `https://www.youtube.com/watch?v=ABC123xyz`
- ID to use: `ABC123xyz`

Do NOT paste the full link in the file. Only the ID.
The site makes the thumbnail + player from the ID automatically.

Write your 5 IDs here first:

| # | Your video title | YouTube ID |
|---|---|---|
| 1 | | |
| 2 | | |
| 3 | | |
| 4 | | |
| 5 | | |

---

## STEP 2 — Put your .dart file in the right folder (30 seconds)

Copy your `.dart` file into this folder in VS Code:
```
fluttery / assets / dart_files /
```

Example: if your file is `variables.dart`, it must be here:
```
assets/dart_files/variables.dart
```

Rules:
- File name must end with `.dart`
- Use small letters, no spaces: `my_file.dart` — NOT `My File.dart`
- The name in Step 3 must match this name exactly.

Do this for all 5 files.

---

## STEP 3 — Add one block in lessons.json (2 minutes per video)

Open this file in VS Code:
```
fluttery / assets / lessons.json
```

Find the last lesson (it ends with `}`), put a comma `,` after it,
then paste this block. Change ONLY the parts in CAPS.

```json
    {
      "id": "your-slug-here",
      "slug": "your-slug-here",
      "title": "YOUR VIDEO TITLE HERE",
      "category": "Basics",
      "level": "Beginner",
      "summary": "Write 1 line about this video.",
      "body": "Write 3-4 lines explaining the topic in simple words.\n\nUse \\n\\n for a new paragraph.",
      "youtubeId": "PASTE-YOUTUBE-ID-HERE",
      "dartFileName": "your_file.dart",
      "dartFileUrl": "",
      "codePreview": "print('Hello');",
      "order": 4,
      "featured": false,
      "tags": ["flutter", "beginner"]
    }
```

### What each field means — simple

| Field | What to write | Example |
|---|---|---|
| `id` + `slug` | Small letters, dashes only, no spaces. This becomes the URL: `/lesson/your-slug-here` | `what-is-a-loop` |
| `title` | Your YouTube video title | `What is a Loop in Flutter?` |
| `category` | `Basics` / `State` / `Widgets` / `Projects` | `Basics` |
| `level` | `Beginner` | `Beginner` |
| `summary` | 1 line, shown on the card | `Loops repeat work for you.` |
| `body` | The blog text, 3-5 lines is enough | See example above |
| `youtubeId` | Only the ID, not the full link | `dQw4w9WgXcQ` |
| `dartFileName` | Exact file name from Step 2 | `loop_example.dart` |
| `dartFileUrl` | Leave empty `""` — always | `""` |
| `codePreview` | 2-3 lines of the most important code | `for (var i = 0; i < 5; i++) {` |
| `order` | 1, 2, 3, 4, 5... — the learning order | `4` |
| `featured` | `true` only for your first 2 lessons, else `false` | `false` |
| `tags` | 2-3 small words for search | `["loop", "for"]` |

### Common mistakes — check these

1. **Missing comma:** every lesson except the LAST one must end with `},` — comma after `}`. The last one ends with `}` only, no comma.
2. **Wrong quotes:** use straight quotes `"`, not curly quotes.
3. **Full YouTube link in youtubeId:** wrong. Only the ID.
4. **File name does not match:** `dartFileName` in JSON must be exactly the same as the file in `assets/dart_files/`, same spelling, same `.dart`.
5. **Slug with spaces or capital letters:** wrong. Use `my-topic-name`, all small.

### After you add all 5

```bash
flutter pub get
flutter run -d chrome
```

Go to Topics. You should see 5 lessons (or 8, if you kept the first 3).
Click one → video plays → Download button gives your `.dart` file.

If the site shows a blank page, your JSON has a mistake.
Paste the file into https://jsonlint.com — it will show you the exact line with the error.

---

## EASIEST WAY — send them to me

You do NOT have to do this yourself. Send me here in chat:

1. Your 5 YouTube links (just paste them)
2. Your 5 `.dart` files (attach them here)
3. For each video, 1 line: what is the title?

I will add all 5 into `lessons.json` for you, put the files in the right folder,
and give you back the updated zip — ready to run.
