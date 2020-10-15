import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guessGame/game/gameHintDialog.dart';
import 'package:guessGame/game/gameHintIcon.dart';
import 'package:guessGame/game/gameLogic.dart';
import 'package:guessGame/game/guess.dart';
import 'package:guessGame/game/guessListHeader.dart';
import 'package:guessGame/game/guessListView.dart';
import 'package:guessGame/game/guessTextField.dart';
import 'package:guessGame/options/options.dart';
import 'package:guessGame/result/leaveResultPage.dart';
import 'package:guessGame/result/successResultPage.dart';
import 'package:guessGame/settings/globalSettings.dart';
import 'package:guessGame/settings/globalTexts.dart';

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
  HintDialog _hintDialog;
  List<HintIcon> _hintIconList;

  String _numberToGuess;
  int _guessCount = 0;

  _GamePageState(this.options) {
    _guessListView = GuessListView();
    _guessTextField = GuessTextField(options, _submitGuess);

    _numberToGuess = GameLogic.generateGuessNumber(
        options.level, options.isSameDigitAllowed, options.isZeroStartAllowed);
  }

  @override
  void initState() {
    setState(() {
      _hintIconList = _fillHintIconList();
      _hintDialog = HintDialog(_hintIconList);
    });
    super.initState();
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
                                builder: (context) => _buildHintDialog(context),
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LeaveResultPage(
                                guessNumber: _numberToGuess,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    //Exit Game Button
                    Container(
                      child: RaisedButton(
                        color: Colors.redAccent,
                        child: Text(
                          'Exit Game',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: GlobalSettings.generalFontSize),
                        ),
                        onPressed: () {
                          exit(0);
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

  //BUG: Selected hints don't remains as open.

  Widget _buildHintDialog(BuildContext context) {
    return AlertDialog(
      title: Text(GlobalText.hintTitle),
      content: _hintDialog,
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Colors.blueAccent,
          child: Text(
            'Ok',
            style: TextStyle(fontSize: GlobalSettings.generalFontSize),
          ),
        )
      ],
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
            builder: (context) => SuccessResultPage(
              tryCount: _guessCount,
              guessNumber: _numberToGuess,
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

  _fillHintIconList() {
    if (_hintIconList == null) {
      _hintIconList = List<HintIcon>();
      for (var i = 0; i < _numberToGuess.length; i++) {
        _hintIconList.add(HintIcon(_numberToGuess[i]));
      }
    }
    return _hintIconList;
  }
}
