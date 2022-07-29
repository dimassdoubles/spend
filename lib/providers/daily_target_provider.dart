import 'package:flutter/material.dart';

class DailyTargetProvider extends ChangeNotifier {
  int _dailyTarget = 20000;

  int get dailyTarget {
    return _dailyTarget;
  }

  void setDailyTarget(int dailyTarget) {
    _dailyTarget = dailyTarget;
    notifyListeners();
  }
}
