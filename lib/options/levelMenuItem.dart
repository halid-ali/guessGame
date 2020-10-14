import 'package:flutter/material.dart';
import 'package:guessGame/settings/globalSettings.dart';

class LevelMenuItem {
  final String text;
  final int value;

  LevelMenuItem(this.text, this.value);

  Widget getMenu() {
    return DropdownMenuItem(
      child: Text(
        '$text',
        style: TextStyle(fontSize: GlobalSettings.generalFontSize),
      ),
      value: value,
    );
  }
}
