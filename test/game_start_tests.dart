// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:guessGame/main.dart';

void main() {
  testWidgets('Start Game without level shows error',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(GameApp());

    // Verify labels.
    expect(find.text('Level:'), findsOneWidget);
    expect(find.text('Allow same digits:'), findsOneWidget);
    expect(find.text('Allow zero start:'), findsOneWidget);
    expect(find.widgetWithText(RaisedButton, 'Start Game'), findsOneWidget);

    // Tap the Start Game button and trigger the error text.
    await tester.tap(find.byType(RaisedButton));
    await tester.pump();

    // Verify that our error text is displayed.
    expect(find.text('You must select level before start.'), findsOneWidget);
  });
}
