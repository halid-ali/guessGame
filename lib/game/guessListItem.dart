import 'package:flutter/material.dart';
import 'package:guessGame/game/guess.dart';
import 'package:guessGame/settings/globalSettings.dart';

class GuessListItem extends StatelessWidget {
  final int index;
  final Guess guess;

  GuessListItem({this.index, this.guess});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        children: [
          //Index
          Container(
            width: 25,
            child: Text(
              '$index',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontFamily: 'RobotoMono',
                  fontSize: GlobalSettings.listItemFontSize),
            ),
          ),
          //Guess
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 15),
              child: Text(
                guess.guessValue,
                style: TextStyle(
                    fontFamily: 'RobotoMono',
                    color: Colors.blue,
                    fontSize: GlobalSettings.listItemFontSize),
              ),
            ),
          ),
          //Known number count
          Container(
            width: 70,
            child: Text(
              '${guess.knownCount}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'RobotoMono',
                  color: Colors.purple,
                  fontSize: GlobalSettings.listItemFontSize),
            ),
          ),
          //Correct place number count
          Container(
            width: 70,
            child: Text(
              '${guess.correctCount}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'RobotoMono',
                  color: Colors.green,
                  fontSize: GlobalSettings.listItemFontSize),
            ),
          ),
          //Wrong place number count
          Container(
            width: 70,
            child: Text(
              '${guess.wrongCount}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontFamily: 'RobotoMono',
                  color: Colors.red,
                  fontSize: GlobalSettings.listItemFontSize),
            ),
          ),
        ],
      ),
    );
  }
}
