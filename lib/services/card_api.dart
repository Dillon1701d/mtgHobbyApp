import 'dart:convert';
import 'package:http/http.dart' as http;

class CardApi {
  static http.Client client = http.Client(); // Default client

  static const String baseUrl = 'http://10.0.2.2:5001/api/cards';

  static Future<List<dynamic>> searchCards(String query) async {
    final response = await client.get(Uri.parse('$baseUrl?name=$query'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load cards');
    }
  }
}