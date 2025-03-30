import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:mtgHobbyApp/ui/cards/cardDetailsPage.dart';

void main() {
  group('CardDetailsPage Tests', () {
    testWidgets('displays basic card details correctly', (WidgetTester tester) async {
      // Need to use mockNetworkImagesFor if CardDetailsPage loads images
      await mockNetworkImagesFor(() async {
        // Create minimal test card data that matches your implementation
        final cardData = {
          "name": "Test Card",
          "type": "Artifact",
          "text": "Test card text.",
          "manaCost": "{1}{G}"
        };

        // Build the widget
        await tester.pumpWidget(MaterialApp(
          home: CardDetailsPage(cardData: cardData),
        ));

        // Check if the name is shown (assuming it's in the app bar)
        expect(find.text('Test Card'), findsOneWidget);

        // Check for the type and text fields - match how they're displayed in your implementation
        // These assertions need to match your actual UI structure
        expect(find.textContaining('Artifact'), findsOneWidget);
        expect(find.textContaining('Test card text'), findsOneWidget);
        expect(find.textContaining('{1}{G}'), findsOneWidget);
      });
    });

    testWidgets('handles creature cards with power/toughness', (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        final creatureCardData = {
          "name": "Test Creature",
          "type": "Creature — Human Warrior",
          "text": "Creature ability text.",
          "manaCost": "{2}{R}",
          "power": "2",
          "toughness": "2"
        };

        await tester.pumpWidget(MaterialApp(
          home: CardDetailsPage(cardData: creatureCardData),
        ));

        // Check if creature-specific details are shown
        expect(find.text('Test Creature'), findsOneWidget);
        expect(find.textContaining('Human Warrior'), findsOneWidget);

        // Check for power/toughness display according to your implementation
        expect(find.textContaining('2/2'), findsWidgets);
      });
    });

    testWidgets('handles missing fields gracefully', (WidgetTester tester) async {
      await mockNetworkImagesFor(() async {
        // Minimal card data with missing fields
        final minimalCardData = {
          "name": "Minimal Card"
          // Other fields missing
        };

        await tester.pumpWidget(MaterialApp(
          home: CardDetailsPage(cardData: minimalCardData),
        ));

        // Should still display the name without errors
        expect(find.text('Minimal Card'), findsOneWidget);

        // No exception should be thrown
      });
    });
  });
}