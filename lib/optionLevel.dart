import 'package:flutter/material.dart';

class OptionLevel extends StatefulWidget {
  final _OptionLevelState _optionLevelState = _OptionLevelState();
  int get level {
    return _optionLevelState.level;
  }

  @override
  _OptionLevelState createState() => _optionLevelState;
}

class _OptionLevelState extends State<OptionLevel> {
  int _level = 4;

  int get level {
    return _level;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          child: Text(
            'Level: ',
            style: TextStyle(fontSize: 25),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 10, top: 10),
          child: DropdownButton(
            style: TextStyle(fontSize: 19, color: Colors.black),
            value: _level,
            items: [
              DropdownMenuItem(
                child: Text('Easy (4)'),
                value: 4,
              ),
              DropdownMenuItem(
                child: Text('Medium (5)'),
                value: 5,
              ),
              DropdownMenuItem(
                child: Text('Hard (6)'),
                value: 6,
              ),
              DropdownMenuItem(
                child: Text('Veteran (8)'),
                value: 8,
              ),
            ],
            onChanged: (int value) {
              setState(() {
                _level = value;
              });
            },
          ),
        ),
      ],
    );
  }
}
