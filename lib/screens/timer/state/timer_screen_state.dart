import 'package:flutter/material.dart';

class TimerScreenState extends ChangeNotifier {
  String screen;

  TimerScreenState({required this.screen});

  void updateScreen() {
    if (screen == "Key") {
      screen = "";
    } else {
      screen = "Key";
    }
    notifyListeners();
  }
}
