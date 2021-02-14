import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:guessGame/generated/l10n.dart';

class GameMainScreen extends StatefulWidget {
  GameMainScreen({Key key}) : super(key: key);

  @override
  _GameMainScreenState createState() => _GameMainScreenState();
}

class _GameMainScreenState extends State<GameMainScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textController = TextEditingController();
  final int _level = 9;
  final bool _isZeroStartAllowed = false;
  final bool _isSameDigitAllowed = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topCenter,
                    child: TextFormField(
                      controller: _textController,
                      style: TextStyle(fontSize: 33, letterSpacing: 5),
                      textAlign: TextAlign.center,
                      maxLength: 9,
                      keyboardType: TextInputType.number,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      validator: _validateValue,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(0),
                          ),
                        ),
                        hintText: '_________',
                        errorStyle: TextStyle(fontSize: 11),
                        errorMaxLines: 2,
                        suffixIcon: IconButton(
                          icon: Icon(Icons.send, color: Colors.pink),
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              print('Valid Number: ${_textController.text}');
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _validateValue(String value) {
    if (value.length < _level) {
      return S.of(context).guess_error_invalid_number(_level);
    }

    if (!_isZeroStartAllowed && value[0] == '0') {
      return S.of(context).guess_error_zero_start;
    }

    if (!_isSameDigitAllowed && _isContainsDuplicates(value)) {
      return S.of(context).guess_error_same_digit;
    }

    return null;
  }

  bool _isContainsDuplicates(String number) {
    var charList = List<String>();

    for (int i = 0; i < number.length; i++) {
      var c = number.characters.elementAt(i);

      if (charList.contains(c)) {
        return true;
      } else {
        charList.add(c);
      }
    }

    return false;
  }
}
