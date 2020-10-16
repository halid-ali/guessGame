import 'package:flutter/material.dart';
import 'package:guessGame/result/leaveContent.dart';
import 'package:guessGame/result/resultButtons.dart';
import 'package:guessGame/result/successContent.dart';
import 'package:guessGame/settings/globalSettings.dart';

enum ResultState { leave, success }

class ResultPage extends StatelessWidget {
  final int guessCount;
  final String guessNumber;
  final ResultState resultState;

  ResultPage(
      {@required this.guessCount,
      @required this.guessNumber,
      @required this.resultState});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(GlobalSettings.generalTitle),
      ),
      body: Center(
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: <Widget>[
                (resultState == ResultState.leave
                    //Leave result
                    ? LeaveContent(guessCount)
                    //Success result
                    : SuccessContent(guessCount)),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Text(
                    'The number was\n$guessNumber',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 27),
                  ),
                ),
                ResultButtons(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
