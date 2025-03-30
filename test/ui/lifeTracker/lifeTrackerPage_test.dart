import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mtgHobbyApp/ui/lifeTracker/lifeTrackerPage.dart';

void main() {
  group('LifeTrackerPage', () {
    testWidgets('initial life totals are set to 40', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LifeTrackerPage()),
      );

      for (int i = 0; i < 4; i++) {
        final lifeFinder = find.byKey(Key('lifeTotal_$i'));
        expect(lifeFinder, findsOneWidget);

        final textWidget = tester.widget<Text>(lifeFinder);
        expect(textWidget.data, '40');
      }
    });

    testWidgets('increment life works for player 1', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LifeTrackerPage()),
      );

      await tester.tap(find.byKey(const Key('increment_0')));
      await tester.pump();

      final lifeText = tester.widget<Text>(find.byKey(const Key('lifeTotal_0')));
      expect(lifeText.data, '41');
    });

    testWidgets('decrement life works for player 2', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LifeTrackerPage()),
      );

      await tester.tap(find.byKey(const Key('decrement_1')));
      await tester.pump();

      final lifeText = tester.widget<Text>(find.byKey(const Key('lifeTotal_1')));
      expect(lifeText.data, '39');
    });

    testWidgets('reset life totals to 40', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: LifeTrackerPage()),
      );

      // simulate a few life changes
      await tester.tap(find.byKey(const Key('increment_0')));
      await tester.tap(find.byKey(const Key('decrement_2')));
      await tester.pump();

      // reset all
      await tester.tap(find.byKey(const Key('resetButton')));
      await tester.pump();

      for (int i = 0; i < 4; i++) {
        final lifeFinder = find.byKey(Key('lifeTotal_$i'));
        final textWidget = tester.widget<Text>(lifeFinder);
        expect(textWidget.data, '40');
      }
    });
  });
}
