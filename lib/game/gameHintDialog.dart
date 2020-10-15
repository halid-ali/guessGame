import 'package:flutter/material.dart';
import 'package:guessGame/game/gameHintIcon.dart';
import 'package:guessGame/settings/globalTexts.dart';

class HintDialog extends StatefulWidget {
  final List<HintIcon> hintList;

  HintDialog(this.hintList);

  @override
  _HintDialogState createState() => _HintDialogState(hintList);
}

class _HintDialogState extends State<HintDialog> {
  final List<HintIcon> hintList;

  _HintDialogState(this.hintList);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(GlobalText.hintContent),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [...hintList],
        ),
      ],
    );
  }
}
