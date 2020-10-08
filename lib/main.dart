import 'package:flutter/material.dart';
import 'package:guessGame/game.dart';
import 'package:guessGame/option.dart';

void main() {
  runApp(GameApp());
}

class GameApp extends StatefulWidget {
  @override
  _GameAppState createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  Options _options;
  bool isGameStarted = false;

  _GameAppState() {
    _options = Options(startGame: _startGame);
  }

  void _startGame() {
    setState(() {
      isGameStarted = true;
    });
  }

  void _newGame() {
    setState(() {
      isGameStarted = false;
      _options = Options(startGame: _startGame);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Number Guess Game',
            style: TextStyle(fontSize: 25),
          ),
          backgroundColor: Colors.green,
        ),
        body: !isGameStarted ? _options : Game(_options, _newGame),
      ),
    );
  }
}
