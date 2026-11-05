// Fluttery — What is a Loop?
// Run this file: paste it into main.dart in DartPad or a new Flutter project.
// Try it: change the list, change the number, run again.

void main() {
  List<String> fruits = ['Mango', 'Banana', 'Orange', 'Apple'];

  print('--- for loop ---');
  for (var i = 0; i < fruits.length; i++) {
    print('$i: ${fruits[i]}');
  }

  print('--- for-in loop ---');
  for (var fruit in fruits) {
    print('I like $fruit');
  }

  print('--- while loop ---');
  int count = 0;
  while (count < 3) {
    print('Count is $count');
    count++;
  }

  print('--- Build a list with a loop ---');
  List<int> numbers = [];
  for (var i = 1; i <= 5; i++) {
    numbers.add(i * 10);
  }
  print(numbers); // [10, 20, 30, 40, 50]
}
