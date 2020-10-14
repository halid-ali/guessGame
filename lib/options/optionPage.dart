import 'package:flutter/material.dart';
import 'package:guessGame/game/gamePage.dart';
import 'package:guessGame/options/levelMenuItem.dart';
import 'package:guessGame/options/options.dart';
import 'package:guessGame/settings/globalSettings.dart';
import 'package:guessGame/settings/globalTexts.dart';

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
          //Level
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
              IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => _buildInfoDialog(context,
                        GlobalText.levelTitle, GlobalText.levelContent),
                  );
                },
              ),
            ],
          ),
          Container(height: 10),
          //Allow same digits
          Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(right: 10),
                child: Text(
                  'Allow same digits:',
                  style: TextStyle(fontSize: GlobalSettings.generalFontSize),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Checkbox(
                    value: _isSameDigitAllowed,
                    onChanged: (value) {
                      setState(
                        () {
                          _isSameDigitAllowed = value;
                        },
                      );
                    },
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.info_outline),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => _buildInfoDialog(context,
                        GlobalText.sameDigitTitle, GlobalText.sameDigitContent),
                  );
                },
              ),
            ],
          ),
          Container(height: 10),
          //Error message
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
          //Start Game button
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

  Widget _buildInfoDialog(BuildContext context, String title, String content) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Text(
            'Ok',
            style: TextStyle(fontSize: GlobalSettings.generalFontSize),
          ),
        )
      ],
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
