import 'dart:math';

import 'package:flutter/material.dart';
import 'package:guessGame/guessListView.dart';
import 'package:guessGame/guessTextField.dart';
import 'package:guessGame/option.dart';
import 'package:guessGame/resultPage.dart';

// ignore: must_be_immutable
class Game extends StatefulWidget {
  final Options _options;
  final Function _newGameCallback;
  _GameState _gameState;
  GuessTextField _guessTextField;
  GuessListView _guessListView;

  Game(this._options, this._newGameCallback) {
    _gameState = _GameState(_options, _newGameCallback);
    _guessTextField = GuessTextField(_options.level, _gameState._submitGuess);
    _guessListView = GuessListView();

    _gameState._generateGuessNumber(
        _options.level, _options.isSameDigitsAllowed);
  }

  @override
  _GameState createState() => _gameState;
}

class _GameState extends State<Game> {
  int _numberToGuess;
  int _guessCount = 0;
  int _knownCount = 0;
  int _correctCount = 0;
  String _actualNumber;
  String _currentNumber;
  bool _isSolved = false;
  Options _options;
  Function _newGameCallback;

  _GameState(this._options, this._newGameCallback);

  int _generateGuessNumber(int digitCount, bool allowSame) {
    final _random = Random();
    int minValue = pow(10, digitCount - 1);
    int maxValue = pow(10, digitCount);

    _numberToGuess = minValue + _random.nextInt(maxValue - minValue);

    if (!allowSame && _isContainsDuplicates(_numberToGuess.toString())) {
      _numberToGuess = _generateGuessNumber(digitCount, allowSame);
    }

    print('Number to guess: ' + _numberToGuess.toString());
    return _numberToGuess;
  }

  bool _isContainsDuplicates(String number) {
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

  bool _compareGuess(String currentGuess) {
    _actualNumber = _numberToGuess.toString();
    _currentNumber = currentGuess;

    if (_actualNumber == _currentNumber) {
      return true;
    }

    //find digits which are on correct place
    _findDigitsOnCorrectPlace();

    //find digits which are on wrong place
    _findDigitsOnWrongPlace();

    return false;
  }

  void _findDigitsOnCorrectPlace() {
    var index = 0;
    while (index < _currentNumber.length) {
      if (_currentNumber[index] == _actualNumber[index]) {
        _correctCount++;
        _knownCount++;

        //mark found digits
        _currentNumber = markCharAt(_currentNumber, index);
        _actualNumber = markCharAt(_actualNumber, index);
      }

      index++;
    }
  }

  void _findDigitsOnWrongPlace() {
    for (int i = 0; i < _currentNumber.length; i++) {
      if (_currentNumber[i] == 'X') {
        continue;
      }

      bool isKnown = false;
      int foundIndex = -1;
      for (int j = 0; j < _actualNumber.length; j++) {
        if (_actualNumber[j] == 'X') {
          continue;
        }

        if (_actualNumber[j] == _currentNumber[i]) {
          if (!isKnown) {
            isKnown = true;
            _knownCount++;
            foundIndex = j;
          }
        }

        if (isKnown) {
          _actualNumber = markCharAt(_actualNumber, foundIndex);
        }
      }
    }
  }

  String markCharAt(String oldString, int index) {
    return oldString.substring(0, index) + 'X' + oldString.substring(index + 1);
  }

  bool _submitGuess(String guess) {
    //reset counters
    setState(() {
      _knownCount = 0;
      _correctCount = 0;
    });

    if (!_options.isSameDigitsAllowed && _isContainsDuplicates(guess)) {
      return false;
    }

    setState(() {
      _isSolved = _compareGuess(guess);
    });

    var _wrongCount = _knownCount - _correctCount;
    widget._guessListView
        .addItem(guess, _knownCount, _correctCount, _wrongCount);
    widget._guessTextField.clear();

    setState(() {
      _guessCount++;
    });

    return true;
  }

  @override
  Widget build(BuildContext context) {
    print('Game has started.');
    print('Level: ' + widget._options.level.toString());
    print('Same digit allowed: ' +
        widget._options.isSameDigitsAllowed.toString());
    return !_isSolved
        ? Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: widget._guessTextField,
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(right: 20),
                child: Text(
                  'Guess count: $_guessCount',
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Container(child: widget._guessListView),
              Container(
                child: RaisedButton(
                  onPressed: _newGameCallback,
                  child: Text(
                    'Leave Game',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                  color: Colors.red[700],
                ),
              )
            ],
          )
        : ResultPage(
            tryCount: _guessCount,
            guessNumber: _numberToGuess,
            newGameCallback: _newGameCallback,
          );
  }
}
