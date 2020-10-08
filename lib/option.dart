import 'package:flutter/material.dart';
import 'package:guessGame/optionLevel.dart';
import 'package:guessGame/optionSameDigit.dart';

// ignore: must_be_immutable
class Options extends StatefulWidget {
  final Function startGame;
  _OptionsState _optionsState;

  Options({@required this.startGame}) {
    _optionsState = _OptionsState(startGame: startGame);
  }

  int get level {
    return _optionsState.level;
  }

  bool get isSameDigitsAllowed {
    return _optionsState.isSameDigitsAllowed;
  }

  @override
  _OptionsState createState() => _optionsState;
}

class _OptionsState extends State<Options> {
  final Function startGame;
  final OptionLevel _optionLevel = OptionLevel();
  final OptionSameDigit _optionSameDigit = OptionSameDigit();

  _OptionsState({@required this.startGame});

  int get level {
    return _optionLevel.level;
  }

  bool get isSameDigitsAllowed {
    return _optionSameDigit.isSameDigitAllowed;
  }

  @override
  Widget build(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          _optionLevel,
        ]),
        TableRow(children: [
          _optionSameDigit,
        ]),
        TableRow(children: [
          Container(
            margin: EdgeInsets.all(10),
            child: RaisedButton(
              onPressed: () {
                startGame();
              },
              child: Text(
                'Start',
                style: TextStyle(fontSize: 25),
              ),
              color: Colors.red,
              textColor: Colors.white,
              padding: EdgeInsets.all(10),
            ),
          )
        ])
      ],
    );
  }
}
