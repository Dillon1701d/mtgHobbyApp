class CardModel {
  final String name;
  final String typeLine;
  final String oracleText;
  final String? manaCost;
  final String? power;
  final String? toughness;
  final String? imageUrl;

  CardModel({
    required this.name,
    required this.typeLine,
    required this.oracleText,
    this.manaCost,
    this.power,
    this.toughness,
    this.imageUrl,
  });

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      name: json['name'],
      typeLine: json['type'] ?? '',
      oracleText: json['text'] ?? '',
      manaCost: json['manaCost'],
      power: json['power'],
      toughness: json['toughness'],
      imageUrl: json['identifiers']?['scryfallId'] != null
          ? "https://api.scryfall.com/cards/${json['identifiers']['scryfallId']}?format=image"
          : null,
    );
  }
}
