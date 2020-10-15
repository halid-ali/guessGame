import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guessGame/game/gameLogic.dart';
import 'package:guessGame/options/options.dart';
import 'package:guessGame/settings/globalSettings.dart';

typedef SubmitGuessCallback = Function(String value);

class GuessTextField extends StatefulWidget {
  final Options options;
  final SubmitGuessCallback submitCallback;

  GuessTextField(this.options, this.submitCallback);

  @override
  _GuessTextFieldState createState() =>
      _GuessTextFieldState(options, submitCallback);
}

class _GuessTextFieldState extends State<GuessTextField> {
  final Options options;
  final SubmitGuessCallback submitCallback;
  final TextEditingController _textEditingController = TextEditingController();

  String _errorText;
  bool _validate = true;

  _GuessTextFieldState(this.options, this.submitCallback);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      style: TextStyle(fontSize: GlobalSettings.generalFontSize),
      textAlign: TextAlign.center,
      maxLength: options.level,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 9),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(13),
          ),
        ),
        hintText: 'Make your guess',
        errorText: _validate ? null : _errorText,
        labelStyle: TextStyle(fontSize: 17),
        suffixIcon: IconButton(
          icon: Icon(Icons.send),
          onPressed: () => _submitTextField(),
        ),
      ),
    );
  }

  void _submitTextField() {
    String value = _textEditingController.text;
    if (!_validateValue(value)) return;

    submitCallback(value);
    _textEditingController.clear();
  }

  bool _validateValue(String value) {
    if (value.length < options.level) {
      setState(() {
        _validate = false;
        _errorText = 'You must enter ${options.level} digits number.';
      });
      return false;
    }

    if (!options.isZeroStartAllowed && value[0] == '0') {
      setState(() {
        _validate = false;
        _errorText = 'This game doesn\'t allow digits start by zero (0).';
      });
      return false;
    }

    if (!options.isSameDigitAllowed && GameLogic.isContainsDuplicates(value)) {
      setState(() {
        _validate = false;
        _errorText = 'This game doesn\'t allow duplicate digits.';
      });
      return false;
    }

    setState(() {
      _validate = true;
      _errorText = null;
    });
    return true;
  }
}
