import 'package:flutter/material.dart';
import '../../models/card.dart';

class CardDetailsPage extends StatelessWidget {
  final Map<String, dynamic> cardData;

  const CardDetailsPage({super.key, required this.cardData});

  @override
  Widget build(BuildContext context) {
    final card = CardModel.fromJson(cardData);

    return Scaffold(
      appBar: AppBar(title: Text(card.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (card.imageUrl != null)
              Center(
                child: Image.network(card.imageUrl!),
              ),
            const SizedBox(height: 12),
            Text("Type: ${card.typeLine}"),
            Text("Mana Cost: ${card.manaCost ?? 'N/A'}"),
            Text("Text: ${card.oracleText}"),
            if (card.power != null && card.toughness != null)
              Text("P/T: ${card.power}/${card.toughness}"),
          ],
        ),
      ),
    );
  }
}
