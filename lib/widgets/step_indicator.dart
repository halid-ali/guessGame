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
      doneStepWidget: Icon(
        Icons.check_circle_rounded,
        size: 13,
        color: Color(0xFF56CD4D),
      ),
      doneLineColor: Color(0xFF56CD4D),
      selectedStepWidget: Icon(
        Icons.circle,
        size: 13,
        color: Colors.pink,
      ),
      undoneLineColor: Colors.grey[700],
      unselectedStepWidget: Icon(
        Icons.circle,
        size: 13,
        color: Colors.grey[700],
      ),
    );
  }
}
