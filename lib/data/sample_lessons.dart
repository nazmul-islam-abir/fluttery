import '../models/lesson.dart';

// Backup copy of the first 3 lessons — the live lessons are now in
// assets/lessons.json. Replace youtubeId with your real video IDs there.

const sampleLessons = <Lesson>[
  Lesson(
    id: 'what-is-a-loop',
    title: 'What is a Loop in Flutter?',
    slug: 'what-is-a-loop',
    category: 'Basics',
    level: 'Beginner',
    summary:
        'Loops repeat work for you. Learn for, while and for-in with a real Flutter list example — no theory overload.',
    body:
        'A loop runs the same code again and again until a condition says stop.\n\n'
        'In Flutter you use loops most often to build lists: 10 items, 100 items, it does not matter — one loop builds them all.\n\n'
        '1. for loop — when you know how many times to repeat.\n'
        '2. while loop — when you repeat until something changes.\n'
        '3. for-in loop — when you go through every item in a list.\n\n'
        'Watch the video above, then download loop_example.dart and run it. Change the list, change the number, and see the screen update. That is the whole lesson.',
    youtubeId: 'dQw4w9WgXcQ', // ← REPLACE with your real video ID
    dartFileName: 'loop_example.dart',
    dartFileUrl: '',
    codePreview: 'for (var i = 0; i < fruits.length; i++) {\n'
        '  print(fruits[i]);\n'
        '}',
    order: 1,
    featured: true,
    tags: ['loop', 'for', 'list'],
  ),
  Lesson(
    id: 'what-is-setstate',
    title: 'What is setState in Flutter?',
    slug: 'what-is-setstate',
    category: 'State',
    level: 'Beginner',
    summary:
        'setState tells Flutter: this value changed, rebuild the screen. One counter example explains the whole idea.',
    body:
        'Flutter only rebuilds the screen when you tell it to.\n\n'
        'setState() is that tell. You change a variable inside setState, Flutter rebuilds that widget, and the new value appears on screen.\n\n'
        'Without setState the variable changes in memory, but the screen stays old. With setState, variable + screen stay in sync.\n\n'
        'Rule to remember: change the data inside setState, never outside it. Download setstate_example.dart, press the + button, and watch the number change.',
    youtubeId: 'dQw4w9WgXcQ', // ← REPLACE with your real video ID
    dartFileName: 'setstate_example.dart',
    dartFileUrl: '',
    codePreview: 'setState(() {\n  counter++;\n});',
    order: 2,
    featured: true,
    tags: ['setState', 'state', 'counter'],
  ),
  Lesson(
    id: 'widgets-explained',
    title: 'Widgets Explained Simply',
    slug: 'widgets-explained',
    category: 'Widgets',
    level: 'Beginner',
    summary:
        'Everything in Flutter is a widget. Text, buttons, layouts — all widgets, stacked inside each other like boxes.',
    body:
        'If you understand widgets, you understand Flutter.\n\n'
        'A widget is one small piece of the screen. A Text widget shows text. A Container gives it padding and colour. A Column stacks widgets vertically.\n\n'
        'You build a screen by putting small widgets inside bigger widgets. That is all there is to it — no magic, just nesting.',
    youtubeId: 'dQw4w9WgXcQ', // ← REPLACE with your real video ID
    dartFileName: 'widgets_example.dart',
    dartFileUrl: '',
    codePreview: 'Column(\n  children: [\n    Text("Hello"),\n    ElevatedButton(\n      onPressed: () {},\n      child: Text("Tap me"),\n    ),\n  ],\n)',
    order: 3,
    tags: ['widget', 'layout'],
  ),
];

// Learning path order — used on the Home page "Start here" section.
const categories = ['All', 'Basics', 'State', 'Widgets', 'Projects'];
