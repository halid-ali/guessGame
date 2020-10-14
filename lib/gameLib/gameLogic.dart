import 'dart:math';
import 'package:flutter/material.dart';

class GameLogic {
  static int correctCount;
  static int knownCount;

  static int generateGuessNumber(int digitCount, bool allowSame) {
    final _random = Random();
    int minValue = pow(10, digitCount - 1);
    int maxValue = pow(10, digitCount);

    int numberToGuess;

    numberToGuess = minValue + _random.nextInt(maxValue - minValue);

    if (!allowSame && isContainsDuplicates(numberToGuess.toString())) {
      numberToGuess = generateGuessNumber(digitCount, allowSame);
    }

    print('Number to guess: ' + numberToGuess.toString());
    return numberToGuess;
  }

  static bool compareGuess(String actualNumber, String currentNumber) {
    if (actualNumber == currentNumber) {
      return true;
    }

    //find digits which are on correct place
    _findDigitsOnCorrectPlace(actualNumber, currentNumber);

    return false;
  }

  static bool isContainsDuplicates(String number) {
    var charList = List<String>();

    for (int i = 0; i < number.length; i++) {
      var c = number.characters.elementAt(i);

      if (charList.contains(c)) {
        return true;
      } else {
        charList.add(c);
      }
    }

    return false;
  }

  static void _findDigitsOnCorrectPlace(String actual, String current) {
    var index = 0;
    while (index < current.length) {
      if (current[index] == actual[index]) {
        correctCount++;
        knownCount++;

        //mark found digits
        current = _markCharAt(current, index);
        actual = _markCharAt(actual, index);
      }

      index++;
    }

    //find digits which are on wrong place
    _findDigitsOnWrongPlace(actual, current);
  }

  static void _findDigitsOnWrongPlace(String actual, String current) {
    for (int i = 0; i < current.length; i++) {
      if (current[i] == 'X') {
        continue;
      }

      bool isKnown = false;
      int foundIndex = -1;
      for (int j = 0; j < actual.length; j++) {
        if (actual[j] == 'X') {
          continue;
        }

        if (actual[j] == current[i]) {
          if (!isKnown) {
            isKnown = true;
            knownCount++;
            foundIndex = j;
          }
        }

        if (isKnown) {
          actual = _markCharAt(actual, foundIndex);
        }
      }
    }
  }

  static String _markCharAt(String oldString, int index) {
    return oldString.substring(0, index) + 'X' + oldString.substring(index + 1);
  }
}
