import 'package:flutter_test/flutter_test.dart';
import 'package:guessGame/game/gameLogic.dart';

void main() {
  for (var level = 4; level < 10; level++) {
    group('Guess number test', () {
      test('zero start not allowed', () {
        for (var i = 0; i < 10000; i++) {
          var guessNumber = GameLogic.generateGuessNumber(level, true, false);
          expect(guessNumber.length, equals(level));
        }
      });
      test('zero start allowed', () {
        for (var i = 0; i < 10000; i++) {
          var guessNumber = GameLogic.generateGuessNumber(level, true, true);
          expect(guessNumber.length, equals(level));
        }
      });
    });
  }
}
