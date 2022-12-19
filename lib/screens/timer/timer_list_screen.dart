import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_clock_app/screens/timer/state/timer_screen_state.dart';
import 'package:provider/provider.dart';

import 'controller/timer_controller.dart';

class TimerListScreen extends StatefulWidget {
  final TimerController timerController;

  const TimerListScreen({Key? key, required this.timerController})
      : super(key: key);

  @override
  State<TimerListScreen> createState() => _TimerListScreenState();
}

class _TimerListScreenState extends State<TimerListScreen> {
  late Timer _timer;
  double time = 0;
  double fullTime = 0;
  int hours = 0;
  int minutes = 0;
  int seconds = 0;

  @override
  void initState() {
    super.initState();
    setTime();
    updateTime();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            timerContainer(),
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 100,
        width: 100,
        child: FloatingActionButton(
          onPressed: () {
            Provider.of<TimerScreenState>(context, listen: false)
                .updateScreen();
            setState(() {});
          },
          child: const Icon(Icons.add),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Container timerContainer() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.grey[800], borderRadius: BorderRadius.circular(30.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child:
                Text("Timer $fullTime", style: const TextStyle(fontSize: 40.0)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 180,
                    width: 180,
                    child: CircularProgressIndicator.adaptive(
                      backgroundColor: Colors.grey[700],
                      value: time / fullTime,
                      strokeWidth: 8,
                    ),
                  ),
                  Column(
                    children: [
                      time != fullTime
                          ? const SizedBox(height: 40.0)
                          : const SizedBox.shrink(),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                              fontSize: time > 3600
                                  ? 36.0
                                  : time > 60
                                      ? 42.0
                                      : 48.0),
                          children: [
                            TextSpan(
                                text:
                                    time <= 0 ? "0" : time.toStringAsFixed(1)),
                          ],
                        ),
                      ),
                      time != fullTime
                          ? IconButton(
                              onPressed: () {
                                _timer.cancel();
                                time = fullTime;
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.replay,
                                size: 32.0,
                                color: Colors.cyan,
                              ))
                          : const SizedBox.shrink(),
                    ],
                  ),
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      time += 10;
                      fullTime += 10;
                      setState(() {});
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueGrey[600],
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 26.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0))),
                    child: const Text("+0:10",
                        style: TextStyle(color: Colors.white, fontSize: 20.0)),
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      _timer.isActive ? _timer.cancel() : updateTime();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink[100],
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 38.5),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0))),
                    child:
                        Icon(_timer.isActive ? Icons.pause : Icons.play_arrow),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void updateTime() {
    _timer = Timer.periodic(const Duration(milliseconds: 10), (timer) {
      if (time > 0) {
        time -= 0.01;
      } else {
        _timer.cancel();
      }
      setState(() {});
    });
  }

  void setTime() {
    String oldTime = widget.timerController.time;
    hours = int.parse(oldTime.substring(0, 2));
    minutes = int.parse(oldTime.substring(2, 4));
    seconds = int.parse(oldTime.substring(4, 6));

    if (minutes >= 60) {
      hours += 1;
      minutes -= 60;
    }
    if (seconds >= 60) {
      minutes += 1;
      seconds -= 60;
    }

    fullTime = (hours * 3600.0) + (minutes * 60.0) + seconds;
    time = fullTime;
  }
}
