import 'package:flutter/material.dart';
import 'package:flutter_hello_world/reorderable_list_demo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'List Demo',
        home: ReorderableListDemo(),
    );
  }
}

