import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:guessGame/settings/globalSettings.dart';
import 'package:guessGame/settings/globalTexts.dart';

class HintDialog extends StatefulWidget {
  final String guessNumber;
  final List<bool> visibleList;

  HintDialog(this.guessNumber, this.visibleList);

  @override
  _HintDialogState createState() =>
      _HintDialogState(guessNumber, this.visibleList);
}

class _HintDialogState extends State<HintDialog> {
  final String guessNumber;
  final List<bool> visibleList;

  _HintDialogState(this.guessNumber, this.visibleList);

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return AlertDialog(
        title: Text(GlobalText.hintTitle),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(GlobalText.hintContent),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < guessNumber.length; i++)
                  Container(
                    margin: const EdgeInsets.all(2),
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    width: 20,
                    child: RichText(
                      text: TextSpan(
                        text: visibleList[i] ? guessNumber[i] : '*',
                        style: TextStyle(
                          color: visibleList[i]
                              ? Colors.green[500]
                              : Colors.red[500],
                          fontFamily: 'RobotoMono',
                          fontSize: 33,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            setState(() {
                              visibleList[i] = true;
                            });
                          },
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            textColor: Colors.blueAccent,
            child: Text(
              'Ok',
              style: TextStyle(fontSize: GlobalSettings.generalFontSize),
            ),
          )
        ],
      );
    });
  }
}
