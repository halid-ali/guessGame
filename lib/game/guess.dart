import 'package:flutter/cupertino.dart';

class Guess {
  final String guess;
  final int known, correct, wrong;

  Guess(
      {@required this.guess,
      @required this.known,
      @required this.correct,
      @required this.wrong});

  String get guessValue => guess;

  int get knownCount => known;

  int get correctCount => correct;

  int get wrongCount => wrong;
}
