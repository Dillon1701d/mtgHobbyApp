import 'package:flutter/material.dart';
import '../../services/card_api.dart';
import 'package:mtgHobbyApp/ui/cards/cardDetailsPage.dart';

class CardSearchPage extends StatefulWidget {
  @override
  _CardSearchPageState createState() => _CardSearchPageState();
}

class _CardSearchPageState extends State<CardSearchPage> {
  List<dynamic> results = [];
  TextEditingController controller = TextEditingController();

  void _search() async {
    final cards = await CardApi.searchCards(controller.text);
    setState(() {
      results = cards;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Card Lookup')),
      body: Column(
        children: [
          TextField(
            controller: controller,
            onSubmitted: (_) => _search(),
            decoration: InputDecoration(labelText: 'Search card'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: results.length,
              itemBuilder: (_, index) {

                final card = results[index];

                return ListTile(
                  title: Text(card['name'] ?? 'Unknown'),
                  subtitle: Text(card['type'] ?? ''),
                    onTap: () {
                      print("Tapped card: ${card['name']}");
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CardDetailsPage(cardData: card),
                        ),
                      );
                    },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
