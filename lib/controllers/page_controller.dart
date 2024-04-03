import 'package:flutter/material.dart';

enum type {credit,debit}

class Pagecontroller extends ChangeNotifier {

  int initialIndex = 0;
  PageController pageController = PageController(initialPage: 0);
  int currentSteps = 0;
  type segment = type.credit;

  DateTime mydate = DateTime.now();
  TimeOfDay timeMy = TimeOfDay.fromDateTime(DateTime.now());
  DateTime mytime = DateTime.now();

  void changeType({required type val}) {
    segment = val;
    notifyListeners();
  }

  void changeDate({required DateTime date}) {
    mydate = date;
   notifyListeners();
  }

  changeMytime({required DateTime time}) {
    mytime = TimeOfDay.fromDateTime(time) as DateTime;
    notifyListeners();
  }

  changeTime({required DateTime time}) {
    timeMy = TimeOfDay.fromDateTime(time);
    notifyListeners();
  }

  void changePage({required int index}) {
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    initialIndex = index;
    notifyListeners();
  }

  void stepForward() {
    if (currentSteps < 7) {
      currentSteps++;
    }
    notifyListeners();
  }

  void stepBackward() {
    if (currentSteps > 0) {
      currentSteps--;
    }
   notifyListeners();
  }

  void stepTap({required int index}) {
    currentSteps;
   notifyListeners();
  }

  StepState myState({required int index}) {
    return (currentSteps > index)
        ? StepState.complete
        : (currentSteps == index)
        ? StepState.editing
        : StepState.disabled;
  }

}