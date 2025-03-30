// test/testUtils/test_helpers.dart
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:network_image_mock/network_image_mock.dart';

class TestHelpers {
  /// Cache for loaded JSON files to avoid reading them multiple times
  static final Map<String, String> _jsonCache = {};

  /// Load a mock JSON file from the test assets directory
  static Future<String> loadMockJson(String path) async {
    // Check if we've already loaded this file
    if (_jsonCache.containsKey(path)) {
      return _jsonCache[path]!;
    }

    try {
      final file = File(path);
      final jsonString = await file.readAsString();
      // Cache the result for future use
      _jsonCache[path] = jsonString;
      return jsonString;
    } catch (e) {
      throw Exception('Failed to load mock JSON file: $path. Error: $e');
    }
  }

  /// Create a mock HTTP client for card API testing
  static Future<MockClient> createMockCardApiClient({
    String? cardSearchPath,
    String defaultResponseCode = '404',
    String defaultResponseBody = '[]'
  }) async {
    String? cardSearchJson;

    if (cardSearchPath != null) {
      try {
        cardSearchJson = await loadMockJson(cardSearchPath);
      } catch (e) {
        print('Warning: Failed to load mock card JSON: $e');
      }
    }

    return MockClient((http.Request request) async {
      final uri = request.url;

      // Card search endpoint
      if (uri.toString().contains('/api/cards?name=')) {
        final searchTerm = uri.queryParameters['name'] ?? '';

        // If we have mock data and the search term matches any card in our mock data
        if (cardSearchJson != null) {
          final cards = jsonDecode(cardSearchJson) as List;

          // Simple search logic - in a real test you might want more sophisticated matching
          // For now, just check if any card name contains the search term (case-insensitive)
          final hasMatch = cards.any((card) =>
              card['name'].toString().toLowerCase().contains(searchTerm.toLowerCase()));

          if (hasMatch) {
            return http.Response(cardSearchJson, 200);
          }
        }

        // No matching cards found
        return http.Response('[]', 200);
      }

      // Default fallback for unhandled requests
      return http.Response(defaultResponseBody, int.parse(defaultResponseCode));
    });
  }

  /// Convenience method to run a test with mocked network images
  static Future<void> runWithMockedNetworkImages(
      WidgetTester tester,
      Future<void> Function(WidgetTester) testFunction
      ) async {
    await mockNetworkImagesFor(() async {
      await testFunction(tester);
    });
  }
}