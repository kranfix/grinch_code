import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: CounterApp(),
    ),
  );
}

class CounterApp extends StatefulWidget {
  @override
  _CounterAppState createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  @override
  Widget build(BuildContext context) {
    final mq1 = MediaQuery.of(context);
    final height = 60.0;
    return Scaffold(
      appBar: AppBar(
        title: Text('MediaQuery'),
      ),
      body: Stack(
        children: [
          MediaQuery(
            data: mq1.copyWith(
              padding: mq1.padding +
                  EdgeInsets.only(
                    bottom: mq1.viewInsets.bottom == 0 ? height : 0,
                  ),
            ),
            child: MyBox(),
          ),
          if (mq1.viewInsets.bottom == 0)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: height,
                color: Colors.purple,
              ),
            )
        ],
      ),
    );
  }
}

class MyBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final bottom = mq.padding.bottom + mq.viewInsets.bottom;

    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: bottom),
      child: Container(
        color: Colors.red,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MqContainer(
              builder: (mq) => Text('mq: $mq'),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 40,
              color: Colors.amber,
              child: Text('padding: ${mq.padding}'),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 40,
              color: Colors.amber,
              child: Text('viewInsets: ${mq.viewInsets}'),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 40,
              color: Colors.amber,
              child: Text('viewInsets: ${mq.viewInsets}'),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 40,
              color: Colors.amber,
              child: Text('bottom: $bottom'),
            ),
            Container(
              margin: EdgeInsets.all(10),
              height: 40,
              color: Colors.amber,
              child: TextField(),
            ),
          ],
        ),
      ),
    );
  }
}

class MqContainer extends StatelessWidget {
  const MqContainer({
    Key key,
    this.builder,
  }) : super(key: key);

  final Widget Function(MediaQueryData mq) builder;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Container(
      color: Colors.green,
      child: Container(
        margin: EdgeInsets.all(10),
        height: 120,
        color: Colors.blue,
        child: builder(mq),
      ),
    );
  }
}

class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RedContainer(
      builder: (_) => Container(
        color: Colors.green,
      ),
    );
  }
}

class RedContainer extends StatelessWidget {
  const RedContainer({Key key, @required this.builder})
      : assert(builder != null),
        super(key: key);

  final WidgetBuilder builder;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final modalWidth = calculateModalWidth(mq.size);
    return Scaffold(
      body: Row(children: [
        Container(
          width: mq.size.width - modalWidth,
          child: Column(children: [
            Container(
              height: 100,
              color: Colors.red,
            ),
            Expanded(
              child: builder(context),
            ),
          ]),
        ),
        Container(
          height: double.infinity,
          width: modalWidth,
          color: Colors.blue,
        ),
      ]),
    );
  }

  double calculateModalWidth(Size screenSize) {
    const minWidth = 300.0;
    const maxWidth = 400.0;

    final proposedWidth = screenSize.width / 4;
    if (proposedWidth > maxWidth) {
      return maxWidth;
    } else if (proposedWidth < minWidth) {
      return minWidth;
    }
    return proposedWidth;
  }
}
