import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:counter_testing/main.dart';

class MyHomePageTest extends MyHomePage {
  const MyHomePageTest({
    Key key,
    @required String title,
    @required this.onIncrement,
    @required this.onDecrement,
  })  : assert(title != null, 'MyHomePage: title must be non-null'),
        super(key: key, title: title);

  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  _MyHomePageTestState createState() => _MyHomePageTestState();
}

class _MyHomePageTestState extends MyHomePageState<MyHomePageTest> {
  @override
  void incrementCounter() {
    super.incrementCounter();
    widget.onIncrement();
  }

  void decrementCounter() {
    super.decrementCounter();
    widget.onDecrement();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: super.build(context),
    );
  }
}

void main() {
  testWidgets('Counter must not decrement on zero',
      (WidgetTester tester) async {
    int counter = 0;
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: MyHomePageTest(
          title: "Mi título",
          onIncrement: () {
            counter++;
          },
          onDecrement: () {
            if (counter > 0) {
              counter--;
            }
          },
        ),
      ),
    );

    expect(counter, 0);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(counter, 0);

    await tester.tap(find.byIcon(Icons.add));
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(counter, 2);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(counter, 1);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(counter, 0);

    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(counter, 0);
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    int counter = 0;
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: MyHomePageTest(
          title: "Mi título",
          onIncrement: () {
            counter++;
          },
          onDecrement: () {
            counter--;
          },
        ),
      ),
    );

    // Verify that our counter starts at 0.
    //expect(find.byKey(Key("CounterText")), findsNothing);
    expect(counter, 0);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(counter, 1);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(counter, 2);
  });
}
