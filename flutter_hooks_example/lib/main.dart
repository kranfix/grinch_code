import 'use_password_editing_controller.dart';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HookPage(title: 'Hook Demo Page'),
    );
  }
}

class HookPage extends HookWidget {
  const HookPage({
    Key key,
    @required this.title,
  })  : assert(title != null),
        super(key: key);

  final String title;

  static void increment(ValueNotifier<int> counterState) {
    counterState.value++;
  }

  @override
  Widget build(BuildContext context) {
    final counter1State = useState<int>(0);
    final controller1 = usePasswordEditingController(text: 'hola 1');
    final controller2 = usePasswordEditingController(
      text: 'hola 2',
      showText: true,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${counter1State.value}',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextField(
              controller: controller1,
              obscureText: controller1.obscureText,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    controller1.showText
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: controller1.toggleShowText,
                ),
              ),
            ),
            TextField(
              controller: controller2,
              obscureText: controller2.obscureText,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                    controller2.showText
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: controller2.toggleShowText,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => increment(counter1State),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
