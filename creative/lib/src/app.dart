import 'package:creative/src/examples/fractals/fractral_tree/fractal_tree.dart';
import 'package:flutter/material.dart';

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Creative examples'),
      ),
      body: Center(
        //child: ListView.builder(
        //  itemBuilder: (_, index) {
        //    print(index);
        //    return ListTile(
        //      title: Text('muaja $index'),
        //    );
        //  },
        //),
        child: FractalTree(),
      ),
    );
  }
}
