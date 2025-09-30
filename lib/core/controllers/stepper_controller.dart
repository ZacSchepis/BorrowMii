import 'package:flutter/material.dart';

class StepperController extends ChangeNotifier {
  int _currentStep = 0;
  final int maxSteps;
  final VoidCallback? onStepChanged;
  final VoidCallback? onBackAtFirstStep;
  StepperController({required this.maxSteps, this.onBackAtFirstStep, this.onStepChanged});

  int get currentStep => _currentStep;
  void next() {
    if(_currentStep < maxSteps -1) { 
      _currentStep++;
      onStepChanged?.call();
      notifyListeners();
    }
  }
  void previous() {
    if(_currentStep > 0) {
      _currentStep--;
      onStepChanged?.call();
      notifyListeners();
    } else {
      onBackAtFirstStep?.call();
    }
  }
  void goTo(int step) {
    print("We got step: $step");
    if(step >= 0 && step < maxSteps) {
      _currentStep = step;
      onStepChanged?.call();
      notifyListeners();
    } 
  }

}