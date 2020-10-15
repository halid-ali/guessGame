import 'package:flutter/material.dart';
import 'package:guessGame/game/gameLogic.dart';
import 'package:guessGame/game/guess.dart';
import 'package:guessGame/settings/globalSettings.dart';

class GuessListItem extends StatelessWidget {
  final int index;
  final Guess guess;

  GuessListItem({this.index, this.guess});

  //TODO: Align items in ListView.

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(5),
      child: Row(
        children: [
          //Index
          Container(
            width: 50,
            child: Text(
              '#$index:',
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
                    fontSize: GlobalSettings.listItemFontSize),
              ),
            ),
          ),
          //Known number count
          Container(
            child: Text(
              'Known:${guess.knownCount}',
              style: TextStyle(
                  fontFamily: 'RobotoMono',
                  color: Colors.blue,
                  fontSize: GlobalSettings.listItemFontSize),
            ),
          ),
          //Correct place number count
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text(
              'C:${guess.correctCount}',
              style: TextStyle(
                  fontFamily: 'RobotoMono',
                  color: Colors.green,
                  fontSize: GlobalSettings.listItemFontSize),
            ),
          ),
          //Wrong place number count
          Container(
            margin: EdgeInsets.only(left: 15),
            child: Text(
              'W:${guess.wrongCount}',
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
