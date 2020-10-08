import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class GuessTextField extends StatefulWidget {
  final int _level;
  final bool Function(String) _submitGuess;
  final _GuessTextFieldState _guessTextFieldState = _GuessTextFieldState();

  GuessTextField(this._level, this._submitGuess);

  void clear() {
    _guessTextFieldState._clear();
  }

  @override
  _GuessTextFieldState createState() => _guessTextFieldState;
}

class _GuessTextFieldState extends State<GuessTextField> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController _textEditingController = TextEditingController();

  bool _validate = true;
  String _errorText;

  void _clear() {
    _textEditingController.clear();
    //_focusNode.requestFocus();
  }

  void _submitTextField(String value) {
    if (_textEditingController.text.length < widget._level) {
      setState(() {
        _validate = false;
        _errorText = 'You must enter ${widget._level} digits number.';
      });
      return;
    }

    if (_textEditingController.text[0] == '0') {
      setState(() {
        _validate = false;
        _errorText = 'Guess number cannot start by 0 (zero).';
      });
      return;
    }

    var result = widget._submitGuess(value);
    if (!result) {
      setState(() {
        _validate = false;
        _errorText = 'This game doesn\'t allow duplicate digits.';
      });
    } else {
      setState(() {
        _validate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      focusNode: _focusNode,
      onSubmitted: (value) => _submitTextField(value),
      style: TextStyle(fontSize: 31),
      textAlign: TextAlign.center,
      maxLength: widget._level,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 9),
          border: OutlineInputBorder(),
          hintText: 'Make your guess',
          errorText: _validate ? null : _errorText,
          labelStyle: TextStyle(fontSize: 17)),
    );
  }
}
