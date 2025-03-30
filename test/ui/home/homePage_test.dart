import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mtgHobbyApp/ui/mainScreenController.dart';

void main() {
  testWidgets('Navigation opens and switches pages', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MyHomePage()));

    // Starts on WelcomePage
    expect(find.text('Welcome to MTG Hobby Assistant'), findsOneWidget);

    // Open nav menu
    final menuBtn = find.byIcon(Icons.menu);
    expect(menuBtn, findsOneWidget);
    await tester.tap(menuBtn);
    await tester.pumpAndSettle();

    // Tap second nav destination (LifeTracker)
    final lifeIcon = find.byIcon(Icons.casino);
    expect(lifeIcon, findsOneWidget);
    await tester.tap(lifeIcon);
    await tester.pumpAndSettle();

    // Check LifeTrackerPage loaded (look for player indicators)
    expect(find.textContaining('Player'), findsNWidgets(4));
  });
}
