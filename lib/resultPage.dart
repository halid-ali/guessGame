import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  final int tryCount;
  final int guessNumber;
  final Function newGameCallback;

  ResultPage({this.tryCount, this.guessNumber, this.newGameCallback});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(20),
          child: Text(
            'Congratulations !!!',
            style: TextStyle(
                fontSize: 31,
                fontWeight: FontWeight.bold,
                color: Colors.red[800]),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Text(
            'You\'ve found the number in \n$tryCount tries.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 23),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 30),
          child: Text(
            'The number was\n$guessNumber',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 33, color: Colors.green, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
          margin: EdgeInsets.all(30),
          child: RaisedButton(
            onPressed: newGameCallback,
            child: Text('Start a new game'),
          ),
        )
      ],
    );
  }
}
