import 'package:flutter_test/flutter_test.dart';
import 'package:share_and_open_url_example/main.dart';

void main() {
  testWidgets('Share Text Button Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    final shareTextButton = find.text('Share Text');
    expect(shareTextButton, findsOneWidget);

    await tester.tap(shareTextButton);
    await tester.pump();
  });

  testWidgets('Open URL Button Test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    final openUrlButton = find.text('Open URL');
    expect(openUrlButton, findsOneWidget);

    await tester.tap(openUrlButton);
    await tester.pump();
  });
}
