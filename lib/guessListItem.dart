import 'package:flutter/material.dart';

class GuessListItem extends StatelessWidget {
  final String guess;
  final int index;
  final int knownCount;
  final int correctCount;
  final int wrongCount;

  GuessListItem(
      {this.guess,
      this.index,
      this.knownCount,
      this.correctCount,
      this.wrongCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //Index
        Container(
          child: Text(
            '#$index - ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        //Guess
        Expanded(
          child: Container(
            child: Text(
              'Guess ' + guess,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
          ),
        ),
        //Known number count
        Container(
          margin: EdgeInsets.only(right: 30),
          child: Text(
            'Known: $knownCount',
            style: TextStyle(
                color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        //Correct place number count
        Container(
          margin: EdgeInsets.only(right: 30),
          child: Text(
            '+ ' + correctCount.toString(),
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        ),
        //Wrong place number count
        Container(
          child: Text(
            '- ' + wrongCount.toString(),
            style: TextStyle(
                color: Colors.red, fontWeight: FontWeight.bold, fontSize: 17),
          ),
        )
      ],
    );
  }
}
