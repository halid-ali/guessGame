import 'package:flutter/material.dart';
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
            child: Text(
              '#$index - ',
              style: TextStyle(fontSize: GlobalSettings.listItemFontSize),
            ),
          ),
          //Guess
          Expanded(
            child: Container(
              child: Text(
                guess.guessValue,
                style: TextStyle(fontSize: GlobalSettings.listItemFontSize),
              ),
            ),
          ),
          //Known number count
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Text(
              'Known:${guess.knownCount}',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: GlobalSettings.listItemFontSize),
            ),
          ),
          //Correct place number count
          Container(
            margin: EdgeInsets.only(right: 20),
            child: Text(
              'C:${guess.correctCount}',
              style: TextStyle(
                  color: Colors.green,
                  fontSize: GlobalSettings.listItemFontSize),
            ),
          ),
          //Wrong place number count
          Container(
            child: Text(
              'W:${guess.wrongCount}',
              style: TextStyle(
                  color: Colors.red, fontSize: GlobalSettings.listItemFontSize),
            ),
          ),
        ],
      ),
    );
  }
}
