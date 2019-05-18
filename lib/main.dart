import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeValueNotifier = ThemeValueNotifier();
    return ValueListenableProvider<ThemeData>(
      builder: (_) => themeValueNotifier,
      // 错误：当返回true时，MaterialApp不会重建，因并未成为InheritedWidget的依赖
      updateShouldNotify: (pre, cur) => (pre != cur),
      child: MaterialApp(
        title: 'Flutter Demo',
        // 错误：MaterialApp不会重建，因并未成为InheritedWidget的依赖
        theme: themeValueNotifier.value,
        home: ChangeNotifierProvider<Counter>(
          builder: (_) => Counter(0),
          child: HomePage(themeValueNotifier),
        ),
      ),
    );
  }
}

class Counter with ChangeNotifier {
  int _counter;

  Counter(this._counter);

  getCounter() => _counter;

  setCounter(int counter) => _counter = counter;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    _counter--;
    notifyListeners();
  }
}

class ThemeValueNotifier extends ValueNotifier<ThemeData> {
  ThemeValueNotifier({ThemeData data})
      : super(data == null ? ThemeData.light() : ThemeData.dark());

  void toggle() {
    this.value =
        this.value == ThemeData.dark() ? ThemeData.light() : ThemeData.dark();
  }
}

class HomePage extends StatelessWidget {
  final ThemeValueNotifier _themeValueNotifier;

  HomePage(this._themeValueNotifier);

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<Counter>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Provider Demo"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${counter.getCounter()}',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: counter.increment,
            tooltip: 'Increment',
            child: Icon(Icons.add),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            onPressed: counter.decrement,
            tooltip: 'Increment',
            child: Icon(Icons.remove),
          ),
          SizedBox(height: 10),
          FloatingActionButton(
            child: Icon(Icons.update),
            onPressed: _themeValueNotifier.toggle,
          ),
        ],
      ),
    );
  }
}
