import 'package:flutter/material.dart';

class LeaveContent extends StatelessWidget {
  final int guessCount;

  LeaveContent(this.guessCount);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          child: Text(
            'No problem.\nNext time you will do it.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 33),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(20),
          child: Text(
            'You left the game after $guessCount tries.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 23),
          ),
        ),
      ],
    );
  }
}
