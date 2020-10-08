import 'package:flutter/material.dart';

class OptionSameDigit extends StatefulWidget {
  final _OptionSameDigitState _optionSameDigitState = _OptionSameDigitState();

  bool get isSameDigitAllowed {
    return _optionSameDigitState.isAllowSameDigits;
  }

  @override
  _OptionSameDigitState createState() => _optionSameDigitState;
}

class _OptionSameDigitState extends State<OptionSameDigit> {
  bool _allowSameDigits = false;

  bool get isAllowSameDigits {
    return _allowSameDigits;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(10),
          child: Text(
            'Allow same digits: ',
            style: TextStyle(fontSize: 25),
          ),
        ),
        Transform.scale(
          scale: 1.3,
          child: Checkbox(
            onChanged: (value) {
              setState(() {
                _allowSameDigits = value;
              });
            },
            value: _allowSameDigits,
          ),
        ),
      ],
    );
  }
}
