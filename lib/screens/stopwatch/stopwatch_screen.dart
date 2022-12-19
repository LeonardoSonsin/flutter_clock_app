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
  final List lap = [];
  ScrollController listScrollController = ScrollController();

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
      body: lap.isEmpty ? centerStopwatchBody() : stopwatchLapsBody(),
      floatingActionButton: floatingActionButtons(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Column stopwatchLapsBody() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 300,
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
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: ListView.builder(
              itemExtent: 24.0,
              controller: listScrollController,
              itemBuilder: (context, index) => Text(
                  'Nº   ${index + 1}   ${lap[index]}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16.0)),
              itemCount: lap.length,
            ),
          ),
        ),
        const SizedBox(height: 128.0),
      ],
    );
  }

  SizedBox centerStopwatchBody() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 300,
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
    );
  }

  Column stopwatchTime() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
                fontSize: _stopwatch.elapsed.inHours > 0
                    ? 60.0
                    : _stopwatch.elapsed.inMinutes >= 10
                        ? 70.0
                        : _stopwatch.elapsed.inMinutes > 0
                            ? 80.0
                            : _stopwatch.elapsed.inSeconds >= 10
                                ? 90.0
                                : 100.0),
            children: [
              _stopwatch.elapsed.inHours > 0
                  ? TextSpan(
                      text: _stopwatch.elapsed.toString().substring(0, 2))
                  : const TextSpan(text: ''),
              _stopwatch.elapsed.inMinutes > 0 &&
                      _stopwatch.elapsed.inMinutes < 10
                  ? TextSpan(
                      text: _stopwatch.elapsed.toString().substring(3, 5))
                  : _stopwatch.elapsed.inMinutes >= 10
                      ? TextSpan(
                          text: _stopwatch.elapsed.toString().substring(2, 5))
                      : const TextSpan(text: ''),
              _stopwatch.elapsed.inSeconds >= 10
                  ? TextSpan(
                      text: _stopwatch.elapsed.toString().substring(5, 7))
                  : TextSpan(
                      text: _stopwatch.elapsed.toString().substring(6, 7)),
            ],
          ),
        ),
        Text(
          ' ${_stopwatch.elapsed.toString().substring(8, 10)}',
          style: const TextStyle(fontSize: 48.0, height: 0.8),
          textAlign: TextAlign.end,
        ),
      ],
    );
  }

  Row floatingActionButtons() {
    return Row(
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
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
                child: InkWell(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (_) => myAlertDialog(),
                    );
                  },
                  child: FloatingActionButton(
                    onPressed: () {
                      lap.add(_stopwatch.elapsed.toString().substring(2, 10));
                      if (listScrollController.hasClients) {
                        final position = listScrollController.position.maxScrollExtent + 16.0;
                        listScrollController.jumpTo(position);
                      }
                    },
                    child: const Icon(Icons.timer_outlined),
                  ),
                ),
              )
            : const SizedBox(width: 50.0),
      ],
    );
  }

  AlertDialog myAlertDialog() {
    return AlertDialog(
      title: const Text("Remove laps"),
      content: const Text("Do you really want to clean up your lap list?"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("NO"),
        ),
        TextButton(
          onPressed: () {
            lap.clear();
            Navigator.of(context).pop();
          },
          child: const Text("YES"),
        ),
      ],
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

  void resetStopwatch() {
    _timer.cancel();
    _showTime = true;
    _stopwatch.stop();
    _stopwatch.reset();
    lap.clear();
    setState(() {});
  }
}
