import 'package:flutter/material.dart';

class SuccessContent extends StatelessWidget {
  final int guessCount;

  SuccessContent(this.guessCount);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          child: Text(
            'Congratulations',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 33),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(20),
          child: Text(
            'You solved the number in $guessCount tries.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 23),
          ),
        ),
      ],
    );
  }
}
