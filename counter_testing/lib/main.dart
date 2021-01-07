import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Algún título'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key key,
    @required this.title,
  })  : assert(title != null, 'MyHomePage: title must be non-null'),
        super(key: key);

  final String title;

  @override
  MyHomePageState<MyHomePage> createState() => MyHomePageState<MyHomePage>();
}

class MyHomePageState<W extends MyHomePage> extends State<W> {
  int _counter = 0;

  void incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void decrementCounter() {
    if (_counter == 0) return;
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              key: Key("CounterText"),
              style: Theme.of(context).textTheme.headline4,
            ),
            if (_counter == 0)
              Text(
                '1',
                style: Theme.of(context).textTheme.headline4,
              ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: decrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: incrementCounter,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          )
        ],
      ),
    );
  }
}
