import 'package:flutter_test/flutter_test.dart';
import 'package:guessGame/game/gameLogic.dart';

main() {
  group('Compare guess numbers', () {
    test('which are identical', () {
      //arrange
      var number1 = '56987320';
      var number2 = '56987320';

      //act
      var result = GameLogic.compareGuess(number1, number2);

      //assert
      expect(result, equals(true));
    });
    test('which are non-identical', () {
      //arrange
      var number1 = '56987320';
      var number2 = '56187320';

      GameLogic.knownCount = 0;
      GameLogic.correctCount = 0;

      //act
      var result = GameLogic.compareGuess(number1, number2);

      //assert
      expect(result, equals(false));
    });
  });
}
