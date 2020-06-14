import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //final counterBloc = CounterBloc();
  //
  //@override
  //void initState() {
  //  super.initState();
  //  counterBloc.addListener(() {
  //    setState(() {});
  //  });
  //}

  @override
  Widget build(BuildContext context) {
    return ListenableProvider<CounterBloc>(
      create: (_) => CounterBloc(),
      //value: counterBloc,
      child: Scaffold(
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
              CounterText(),
            ],
          ),
        ),
        floatingActionButton: MyFab(),
      ),
    );
  }
}

class MyFab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterBloc = Provider.of<CounterBloc>(context);
    return FloatingActionButton(
      onPressed: () => counterBloc.increment(),
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }
}

class CounterText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final counterBloc = Provider.of<CounterBloc>(context);
    return Text(
      '${counterBloc.counter}',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

class CounterBloc extends ChangeNotifier {
  int counter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }
}
