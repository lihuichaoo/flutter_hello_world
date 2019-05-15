import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';

void main() => runApp(MyApp());

class CounterStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/counter.txt');
  }

  Future<int> readCounter() async {
    try {
      final file = await _localFile;
      // Read the file
      String contents = await file.readAsString();
      return int.parse(contents);
    } catch (e) {
      // If encountering an error, return 0
      return 0;
    }
  }

  Future<File> writeCounter(int counter) async {
    final file = await _localFile;
    // Write the file
    return file.writeAsString('$counter');
  }
}

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
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Alert"),
            content: Text("Flutter Alert Dialog"),
            actions: <Widget>[
              FlatButton(
                  child: Text("关闭"),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ],
          );
        });
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
                Text(
                  '$_enterCounter Entries\n$_exitCounter Exits',
                  style: Theme.of(context).textTheme.display1,
                ),
                Text(
                  'The cursor offset is here: (${x.toStringAsFixed(2)}, ${y.toStringAsFixed(2)})',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
