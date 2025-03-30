import 'package:flutter_test/flutter_test.dart';
import 'package:mtgHobbyApp/app/appState.dart';

void main() {
  group('MyAppState', () {
    test('initial state is created', () {
      final state = MyAppState();
      expect(state, isNotNull);
    });

    // Add more once state logic grows
  });
}
