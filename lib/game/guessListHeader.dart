import 'package:flutter/material.dart';
import 'package:guessGame/settings/globalSettings.dart';

class GuessListHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.all(
          Radius.circular(7),
        ),
      ),
      child: Card(
        borderOnForeground: false,
        shadowColor: Colors.transparent,
        color: Colors.green[100],
        child: Row(
          children: [
            //#
            Container(
              width: 25,
              child: Text(
                '#',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.green[800],
                    fontSize: GlobalSettings.listItemFontSize),
              ),
            ),
            //Guess
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 15),
                child: Text(
                  'Guess',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: Colors.green[800],
                      fontSize: GlobalSettings.listItemFontSize),
                ),
              ),
            ),
            //Known
            Container(
              width: 70,
              child: Text(
                'Known',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.green[800],
                    fontSize: GlobalSettings.listItemFontSize),
              ),
            ),
            //Correct
            Container(
              width: 70,
              child: Text(
                'Correct',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.green[800],
                    fontSize: GlobalSettings.listItemFontSize),
              ),
            ),
            //Wrong
            Container(
              width: 70,
              child: Text(
                'Wrong',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.green[800],
                    fontSize: GlobalSettings.listItemFontSize),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
