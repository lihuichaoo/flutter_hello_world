import 'package:flutter_hello_world/main.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Counter value should be incremented', () {
    final counter = CounterModel();

    counter.increment();

    expect(counter.counter, 1);
  });

  testWidgets('CounterHome has a title', (WidgetTester tester) async {
    await tester.pumpWidget(CounterHome('test_title'));

    final titleFinder = find.text('test_title');

    expect(titleFinder, findsOneWidget);
  });
}