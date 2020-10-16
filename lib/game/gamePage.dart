import 'package:flutter/material.dart';
import 'package:guessGame/game/gameHintDialog.dart';
import 'package:guessGame/game/gameLogic.dart';
import 'package:guessGame/game/guess.dart';
import 'package:guessGame/game/guessListHeader.dart';
import 'package:guessGame/game/guessListView.dart';
import 'package:guessGame/game/guessTextField.dart';
import 'package:guessGame/options/options.dart';
import 'package:guessGame/result/resultPage.dart';
import 'package:guessGame/settings/globalSettings.dart';

class GamePage extends StatefulWidget {
  final Options options;

  GamePage(this.options);

  @override
  _GamePageState createState() => _GamePageState(options);
}

class _GamePageState extends State<GamePage> {
  final Options options;
  GuessListView _guessListView;
  GuessTextField _guessTextField;
  List<bool> _visibleList;

  String _numberToGuess;
  int _guessCount = 0;

  _GamePageState(this.options) {
    _guessListView = GuessListView();
    _guessTextField = GuessTextField(options, _submitGuess);

    _numberToGuess = GameLogic.generateGuessNumber(
        options.level, options.isSameDigitAllowed, options.isZeroStartAllowed);

    _visibleList = List<bool>.filled(_numberToGuess.length, false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(GlobalSettings.generalTitle),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            children: <Widget>[
              //Guess TextField
              Container(padding: EdgeInsets.all(5), child: _guessTextField),
              //Header
              GuessListHeader(),
              //ListView
              Expanded(child: _guessListView),
              //Buttons
              Container(
                padding: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: Colors.grey, style: BorderStyle.solid, width: 1),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //Hint Button
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                            tooltip: 'Hint',
                            icon: Icon(
                              Icons.help,
                              color: Colors.blueAccent,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return HintDialog(
                                      _numberToGuess, _visibleList);
                                },
                              );
                            }),
                      ),
                    ),
                    //Leave Game Button
                    Container(
                      margin: const EdgeInsets.only(right: 10),
                      child: RaisedButton(
                        color: Colors.blueAccent,
                        child: Text(
                          'Leave Game',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: GlobalSettings.generalFontSize),
                        ),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _showLeaveConfirmationDialog(context));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _submitGuess(String guessValue) {
    //reset counters for new guess
    setState(() {
      GameLogic.knownCount = 0;
      GameLogic.correctCount = 0;

      //finish game if solved
      if (GameLogic.compareGuess(_numberToGuess.toString(), guessValue)) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ResultPage(
              guessCount: _guessCount,
              guessNumber: _numberToGuess,
              resultState: ResultState.success,
            ),
          ),
        );
      }
    });

    var guess = Guess(
        guess: guessValue,
        known: GameLogic.knownCount,
        correct: GameLogic.correctCount,
        wrong: GameLogic.knownCount - GameLogic.correctCount);

    _guessListView.addGuess(guess);
    setState(() {
      _guessCount++;
    });
  }

  _showLeaveConfirmationDialog(BuildContext context) {
    return AlertDialog(
      title: Text('Leave Game'),
      content: Text('You will about the leave game.\nAre you sure?'),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResultPage(
                  guessNumber: _numberToGuess,
                  guessCount: _guessCount,
                  resultState: ResultState.leave,
                ),
              ),
            );
          },
          child: Text(
            'Yes, leave.',
            style: TextStyle(fontSize: 17, color: Colors.red),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'No, stay.',
            style: TextStyle(fontSize: 17, color: Colors.green),
          ),
        ),
      ],
    );
  }
}
