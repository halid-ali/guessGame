import 'package:flutter/material.dart';
import 'package:guessGame/gameLib/gameLogic.dart';
import 'package:guessGame/gameLib/guess.dart';
import 'package:guessGame/gameLib/guessListView.dart';
import 'package:guessGame/gameLib/guessTextField.dart';
import 'package:guessGame/main.dart';
import 'package:guessGame/optionLib/options.dart';
import 'package:guessGame/resultPage.dart';
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

  int _numberToGuess;
  int _guessCount = 0;

  _GamePageState(this.options) {
    _guessListView = GuessListView();
    _guessTextField = GuessTextField(options, _submitGuess);

    _numberToGuess = GameLogic.generateGuessNumber(
        options.level, options.isSameDigitAllowed);
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
              Container(padding: EdgeInsets.all(5), child: _guessTextField),
              Expanded(child: _guessListView),
              Container(
                padding: EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                        color: Colors.grey, style: BorderStyle.solid, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      'Guess count: $_guessCount',
                      style:
                          TextStyle(fontSize: GlobalSettings.generalFontSize),
                    )),
                    RaisedButton(
                      color: Colors.redAccent,
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
                            builder: (context) => GameApp(),
                          ),
                        );
                      },
                    )
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
}
