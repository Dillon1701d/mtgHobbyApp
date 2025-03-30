import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:mtgHobbyApp/ui/cards/cardSearchPage.dart';
import 'package:mtgHobbyApp/services/card_api.dart';

void main() {
  setUp(() {
    // Create a simple mock card response with minimal data
    final mockCards = [
      {
        "name": "Sol Ring",
        "type": "Artifact",
        "text": "Add mana"
      },
      {
        "name": "Counterspell",
        "type": "Instant",
        "text": "Counter target spell."
      }
    ];

    // Setup mock client with simplified string handling
    CardApi.client = MockClient((request) async {
      if (request.url.toString().contains('name=empty')) {
        return http.Response('[]', 200);
      } else if (request.url.toString().contains('name=error')) {
        // Use a simple string for error response
        return http.Response('Server error', 500);
      } else {
        // Encode the mock data
        return http.Response(jsonEncode(mockCards), 200);
      }
    });
  });

  tearDown(() {
    // Reset client after each test
    CardApi.client = http.Client();
  });

  group('CardSearchPage Tests', () {
    testWidgets('renders search field with correct label', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: CardSearchPage()));

      // Verify search field exists with correct label
      expect(find.byType(TextField), findsOneWidget);
      expect(find.text('Search card'), findsOneWidget);
    });

    testWidgets('can enter text in search field', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: CardSearchPage()));

      // Enter text
      await tester.enterText(find.byType(TextField), 'sol');

      // Verify text was entered
      expect(find.text('sol'), findsOneWidget);
    });

    testWidgets('displays search results', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: CardSearchPage()));

      // Enter search text and submit
      await tester.enterText(find.byType(TextField), 'sol');
      await tester.testTextInput.receiveAction(TextInputAction.done);

      // Wait for async operations to complete
      await tester.pumpAndSettle();

      // Verify results are displayed - matches your implementation
      expect(find.text('Sol Ring'), findsOneWidget);
      expect(find.text('Artifact'), findsOneWidget);
      expect(find.text('Counterspell'), findsOneWidget);
      expect(find.text('Instant'), findsOneWidget);
    });

    testWidgets('handles empty results gracefully', (WidgetTester tester) async {
      await tester.pumpWidget(MaterialApp(home: CardSearchPage()));

      // Search for something that returns empty results
      await tester.enterText(find.byType(TextField), 'empty');
      await tester.testTextInput.receiveAction(TextInputAction.done);

      // Wait for search to complete
      await tester.pumpAndSettle();

      // Verify no ListTiles are shown when there are no results
      expect(find.byType(ListTile), findsNothing);
    });

    testWidgets('ListView is created but empty when no search is performed',
            (WidgetTester tester) async {
          await tester.pumpWidget(MaterialApp(home: CardSearchPage()));

          // Should have ListView but no items
          expect(find.byType(ListView), findsOneWidget);
          expect(find.byType(ListTile), findsNothing);
        });
  });
}