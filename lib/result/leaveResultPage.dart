import 'package:flutter/material.dart';
import 'package:guessGame/main.dart';
import 'package:guessGame/settings/globalSettings.dart';

class LeaveResultPage extends StatelessWidget {
  final int number;

  LeaveResultPage({@required this.number});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(GlobalSettings.generalTitle),
      ),
      body: Center(
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    'Number was $number',
                    style: TextStyle(fontSize: 31),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: RaisedButton(
                    color: Colors.blueAccent,
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Start new game',
                      style: TextStyle(fontSize: 21, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GameApp(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
