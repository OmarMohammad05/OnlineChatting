// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:weather_comfort_app/main.dart';

void main() {
  testWidgets('Weather Comfort App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const WeatherComfortApp());

    // Verify that the weather comfort app loads with expected title
    expect(find.text('Weather Comfort'), findsOneWidget);
    expect(find.text('Find the perfect time for your activities'), findsOneWidget);
  });
}
