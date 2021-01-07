import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class MyCounter extends AnimatedWidget {
  const MyCounter({
    Key key,
    @required this.counter,
  })  : assert(counter != null),
        super(key: key, listenable: counter);

  final ValueNotifier<int> counter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Column(
        children: [
          Text('${counter.value}'),
          FloatingActionButton(
            onPressed: () => counter.value--,
            tooltip: 'Decrement',
            child: Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: () => counter.value++,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}

void main() {
  test('Counter controller must be non-null', () {
    try {
      MyCounter(counter: null);
      fail('The counter is null. The is not well writen');
    } catch (e) {
      expect(e, isAssertionError);
    }
  });

  testWidgets('Counter must increment', (WidgetTester tester) async {
    final counter = ValueNotifier<int>(0);
    await tester.pumpWidget(MyCounter(counter: counter));
    await tester.tap(find.byIcon(Icons.add));
    expect(counter.value, 1);

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.pump();
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);

    final now = DateTime.now();
    final completer = Completer();

    await tester.pumpWidget(Image.network(
      "",
      loadingBuilder: (context, img, chunk) {
        if (chunk.cumulativeBytesLoaded < chunk.expectedTotalBytes) {
          return CircularProgressIndicator();
        }
        completer.complete();
        return img;
      },
    ));
    //await tester.pump();
    await completer.future;
    final lapse = DateTime.now().difference(now);
    expect(
      lapse.inMicroseconds,
      lessThan(Duration(seconds: 3).inMicroseconds),
    );
  });
}
