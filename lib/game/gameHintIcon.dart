import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class HintIcon extends StatefulWidget {
  final String digit;

  HintIcon(this.digit);

  @override
  _HintIconState createState() => _HintIconState(digit);
}

class _HintIconState extends State<HintIcon> {
  final String digit;
  bool _isAsked = false;

  _HintIconState(this.digit);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(2),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      width: 20,
      child: RichText(
        text: TextSpan(
          text: _isAsked ? digit : '*',
          style: TextStyle(
            color: _isAsked ? Colors.green[500] : Colors.red[500],
            fontFamily: 'RobotoMono',
            fontSize: 33,
            fontWeight: FontWeight.bold,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              setState(() {
                _isAsked = true;
              });
            },
        ),
      ),
    );
  }
}
