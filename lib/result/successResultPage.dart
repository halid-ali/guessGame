import 'package:flutter/material.dart';
import 'package:guessGame/main.dart';
import 'package:guessGame/settings/globalSettings.dart';

class SuccessResultPage extends StatelessWidget {
  final int tryCount;
  final int guessNumber;

  SuccessResultPage({@required this.tryCount, @required this.guessNumber});

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
          children: [
            Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Text(
                    'Congratulations',
                    style: TextStyle(fontSize: 33),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Text(
                    'You solved the number in $tryCount tries.',
                    style: TextStyle(fontSize: 23),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Text(
                    'The number was $guessNumber',
                    style: TextStyle(fontSize: 27),
                  ),
                ),
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
                              builder: (context) => GameApp(),
                            ));
                      }),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
