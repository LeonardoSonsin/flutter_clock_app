import 'package:flutter/material.dart';
import 'package:flutter_clock_app/screens/timer/controller/timer_controller.dart';
import 'package:flutter_clock_app/screens/timer/state/timer_screen_state.dart';
import 'package:flutter_clock_app/screens/timer/timer_keyboard_screen.dart';
import 'package:flutter_clock_app/screens/timer/timer_list_screen.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  State<TimerScreen> createState() => _TimerScreenState();
}

class _TimerScreenState extends State<TimerScreen> {
  final timerController = Get.put(TimerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TimerScreenState>(
        builder: (BuildContext context, TimerScreenState timerScreenController,
            Widget? widget) {
          return timerScreenController.screen == "Key"
              ? TimerKeyboardScreen(timerController: timerController)
              : TimerListScreen(timerController: timerController);
        },
      ),
    );
  }
}
