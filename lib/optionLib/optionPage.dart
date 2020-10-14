import 'package:flutter/material.dart';
import 'package:guessGame/gameLib/gamePage.dart';
import 'package:guessGame/optionLib/levelMenuItem.dart';
import 'package:guessGame/optionLib/options.dart';
import 'package:guessGame/settings/globalSettings.dart';

class OptionPage extends StatefulWidget {
  @override
  _OptionPageState createState() => _OptionPageState();
}

class _OptionPageState extends State<OptionPage> {
  final List<DropdownMenuItem> levels = [
    LevelMenuItem('Easy', 4).getMenu(),
    LevelMenuItem('Medium', 5).getMenu(),
    LevelMenuItem('Hard', 6).getMenu(),
    LevelMenuItem('Veteran', 8).getMenu()
  ];

  int _level;
  bool _isSameDigitAllowed = false;
  String _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Text(
                  'Level:',
                  style: TextStyle(fontSize: GlobalSettings.generalFontSize),
                ),
              ),
              Expanded(
                child: DropdownButton(
                  isExpanded: true,
                  value: _level,
                  hint: Text(
                    'Please select the level.',
                    style: TextStyle(fontSize: GlobalSettings.generalFontSize),
                  ),
                  items: levels,
                  onChanged: (value) {
                    setState(() {
                      _level = value;
                      _errorMessage = null;
                    });
                  },
                ),
              ),
            ],
          ),
          Container(height: 10),
          Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Text(
                  'Allow same digits:',
                  style: TextStyle(fontSize: GlobalSettings.generalFontSize),
                ),
              ),
              Checkbox(
                  value: _isSameDigitAllowed,
                  onChanged: (value) {
                    setState(() {
                      _isSameDigitAllowed = value;
                    });
                  })
            ],
          ),
          Container(height: 10),
          Row(
            children: <Widget>[
              (_errorMessage == null
                  ? Container()
                  : Container(
                      child: Text(
                        _errorMessage,
                        style: TextStyle(
                            fontSize: GlobalSettings.generalFontSize,
                            color: Colors.redAccent),
                      ),
                    )),
            ],
          ),
          Container(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              RaisedButton(
                color: Colors.blueAccent,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  alignment: Alignment.centerRight,
                  child: Text(
                    'Start Game',
                    style: TextStyle(
                        fontSize: GlobalSettings.generalFontSize,
                        color: Colors.white),
                  ),
                ),
                onPressed: () => startNewGame(),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void startNewGame() {
    if (_level == null) {
      setState(() {
        _errorMessage = 'You must select level before start.';
      });
      return;
    }

    var options =
        Options(level: _level, isSameDigitAllowed: _isSameDigitAllowed);

    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => GamePage(options),
        ));
  }
}
