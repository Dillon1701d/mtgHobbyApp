import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mtgHobbyApp/ui/home/welcomePage.dart';

void main() {
  testWidgets('WelcomePage displays welcome text', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: WelcomePage(),
      ),
    );

    expect(find.text('Welcome to MTG Hobby Assistant'), findsOneWidget);
    expect(find.byType(Text), findsNWidgets(2));
  });
}
