import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

void main() => runApp(MyApp());

/// This Widget is the main application widget.
class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Scaffold(
        appBar: AppBar(title: Text(_title)),
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _enterCounter = 0;
  int _exitCounter = 0;
  double x = 0.0;
  double y = 0.0;

  void _incrementCounter(TapUpDetails details) {
    setState(() {
      _enterCounter++;
    });
  }
  void _decrementCounter(TapDownDetails details) {
    setState(() {
      _exitCounter++;
    });
  }
  void _updateLocation(DragUpdateDetails details) {
    setState(() {
      x = details.delta.dx;
      y = details.delta.dy;
    });
  }
  void _longPressEventHandler() {
    Navigator.push(context, PageRouteBuilder(
        opaque: false,
        pageBuilder: (BuildContext context, _, __) {
          return Center(child: Text('My PageRoute'));
        },
        transitionsBuilder: (_, Animation<double> animation, __, Widget child) {
          return FadeTransition(
            opacity: animation,
            child: RotationTransition(
              turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
              child: child,
            ),
          );
        }
    ));
    setState(() {
      _exitCounter += 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints.tight(Size(300.0, 200.0)),
        child: GestureDetector(
          onTapUp: _incrementCounter,
          onTapDown: _decrementCounter,
          onPanUpdate: _updateLocation,
          onLongPress: _longPressEventHandler,
          child: Container(
            color: Colors.lightBlueAccent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('You have pointed at this box this many times:'),
                Text('$_enterCounter Entries\n$_exitCounter Exits',
                  style: Theme.of(context).textTheme.display1,
                ),
                Text('The cursor offset is here: (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})',),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


