import 'package:flutter/material.dart';
import 'package:steps_indicator/steps_indicator.dart';

class StepIndicator extends StatelessWidget {
  final int stepCount;
  final int currentStep;

  const StepIndicator({
    Key key,
    this.stepCount,
    this.currentStep,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StepsIndicator(
      nbSteps: stepCount,
      selectedStep: currentStep,
      doneStepWidget: CircleAvatar(
        radius: 7,
        backgroundColor: Color(0xFF56CD4D),
        child: Icon(
          Icons.check,
          size: 11,
          color: Colors.white,
        ),
      ),
      doneLineColor: Color(0xFF56CD4D),
      selectedStepWidget: CircleAvatar(
        radius: 7,
        backgroundColor: Colors.pink,
        child: Icon(
          Icons.circle,
          size: 9,
          color: Colors.white,
        ),
      ),
      undoneLineColor: Colors.grey[700],
      unselectedStepWidget: CircleAvatar(
        radius: 7,
        backgroundColor: Colors.grey[700],
      ),
    );
  }
}
