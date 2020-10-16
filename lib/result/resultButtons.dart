import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guessGame/main.dart';

class ResultButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //Start new game button
        Container(
          margin: const EdgeInsets.all(20),
          child: RaisedButton(
            padding: EdgeInsets.all(10),
            color: Colors.blueAccent,
            child: Text(
              'Start new game',
              style: TextStyle(fontSize: 19, color: Colors.white),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  //TODO: Navigate to OptionPage after login feature implemented
                  builder: (context) => GameApp(),
                ),
              );
            },
          ),
        ),
        //Exit game button
        Container(
          child: RaisedButton(
            padding: EdgeInsets.all(10),
            color: Colors.redAccent,
            child: Text(
              'Exit game',
              style: TextStyle(fontSize: 19, color: Colors.white),
            ),
            onPressed: () {
              exit(0);
            },
          ),
        ),
      ],
    );
  }
}
