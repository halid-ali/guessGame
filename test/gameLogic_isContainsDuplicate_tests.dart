import 'package:flutter_test/flutter_test.dart';
import 'package:guessGame/game/gameLogic.dart';

main() {
  group('Number', () {
    test('contains duplicate digits', () {
      //arrange
      var numberListOfDuplicateDigits = [
        '71345863',
        '81324581',
        '90246592',
        '50370257',
        '65023513',
        '34592396'
      ];

      //act-assert
      for (var number in numberListOfDuplicateDigits) {
        expect(GameLogic.isContainsDuplicates(number), equals(true));
      }
    });
    test('doesn\'t contains duplicate digits', () {
      //arrange
      var numberListOfDistinctDigits = [
        '19027364',
        '40759128',
        '36172590',
        '59601432',
        '71820469',
        '25143906'
      ];

      //act-assert
      for (var number in numberListOfDistinctDigits) {
        expect(GameLogic.isContainsDuplicates(number), equals(false));
      }
    });
  });
}
