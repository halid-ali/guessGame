import 'package:flutter/material.dart';
import 'package:guessGame/options/optionPage.dart';
import 'package:guessGame/settings/globalSettings.dart';

void main() {
  runApp(GameApp());
}

class GameApp extends StatefulWidget {
  @override
  _GameAppState createState() => _GameAppState();
}

class _GameAppState extends State<GameApp> {
  bool isGameStarted = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(GlobalSettings.generalTitle),
          backgroundColor: Colors.green,
        ),
        body: OptionPage(),
      ),
    );
  }
}
