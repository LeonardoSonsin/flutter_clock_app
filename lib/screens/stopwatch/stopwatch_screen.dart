import 'dart:async';
import 'package:flutter/material.dart';

class StopwatchScreen extends StatefulWidget {
  const StopwatchScreen({Key? key}) : super(key: key);

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  late Timer _timer;
  late bool _showTime;
  final Stopwatch _stopwatch = Stopwatch();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(), (timer) {});
    _showTime = true;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Stopwatch'),
        actions: [
          IconButton(
            onPressed: () {
              resetStopwatch();
            },
            icon: const Icon(Icons.refresh),
          )
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * 0.65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 325,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white24, width: 10.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _showTime ? stopwatchTime() : const SizedBox.shrink(),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _stopwatch.elapsed.inMilliseconds > 0
              ? SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: FloatingActionButton(
                    onPressed: () {
                      resetStopwatch();
                    },
                    child: const Icon(Icons.replay),
                  ),
                )
              : const SizedBox(width: 50.0),
          _stopwatch.isRunning
              ? SizedBox(
                  height: 100.0,
                  width: 150.0,
                  child: FloatingActionButton.extended(
                    onPressed: () {
                      handleStartStop();
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0)),
                    label: _stopwatch.isRunning
                        ? const Icon(Icons.pause_outlined)
                        : const Icon(Icons.play_arrow),
                  ),
                )
              : SizedBox(
                  height: 100.0,
                  width: 100.0,
                  child: FloatingActionButton(
                    onPressed: () {
                      handleStartStop();
                    },
                    child: _stopwatch.isRunning
                        ? const Icon(Icons.pause_outlined)
                        : const Icon(Icons.play_arrow),
                  ),
                ),
          _stopwatch.isRunning
              ? SizedBox(
                  height: 50.0,
                  width: 50.0,
                  child: FloatingActionButton(
                    onPressed: () {},
                    child: const Icon(Icons.timer_outlined),
                  ),
                )
              : const SizedBox(width: 50.0),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void resetStopwatch() {
    _timer.cancel();
    _showTime = true;
    _stopwatch.stop();
    _stopwatch.reset();
    setState(() {});
  }

  RichText stopwatchTime() {
    return RichText(
      text: TextSpan(
        style: TextStyle(
            color: Colors.blueAccent,
            fontSize: _stopwatch.elapsed.inHours > 0
                ? 40.0
                : _stopwatch.elapsed.inMinutes >= 10
                    ? 50.0
                    : _stopwatch.elapsed.inMinutes > 0
                        ? 60.0
                        : _stopwatch.elapsed.inSeconds >= 10
                            ? 70.0
                            : 80.0),
        children: [
          _stopwatch.elapsed.inHours > 0
              ? TextSpan(text: _stopwatch.elapsed.toString().substring(0, 2))
              : const TextSpan(text: ''),
          _stopwatch.elapsed.inMinutes > 0 && _stopwatch.elapsed.inMinutes < 10
              ? TextSpan(text: _stopwatch.elapsed.toString().substring(3, 5))
              : _stopwatch.elapsed.inMinutes >= 10
                  ? TextSpan(text: _stopwatch.elapsed.toString().substring(2, 5))
                  : const TextSpan(text: ''),
          _stopwatch.elapsed.inSeconds >= 10
              ? TextSpan(text: _stopwatch.elapsed.toString().substring(5, 7))
              : TextSpan(text: _stopwatch.elapsed.toString().substring(6, 7)),
          TextSpan(
            text: ' ${_stopwatch.elapsed.toString().substring(8, 10)}',
            style: const TextStyle(fontSize: 38.0),
          ),
        ],
      ),
    );
  }

  void handleStartStop() {
    if (_stopwatch.isRunning) {
      setNewTimerUpdateScreen(duration: 500);
      _stopwatch.stop();
    } else {
      setNewTimerUpdateScreen(duration: 1);
      _showTime = true;
      _stopwatch.start();
    }
  }

  void setNewTimerUpdateScreen({required int duration}) {
    _timer.cancel();
    _timer = Timer.periodic(Duration(milliseconds: duration), (timer) {
      setState(() {
        _stopwatch.isRunning ? null : _showTime = !_showTime;
      });
    });
  }
}
