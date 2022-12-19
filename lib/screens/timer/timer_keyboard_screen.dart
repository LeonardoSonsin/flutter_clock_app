import 'package:flutter/material.dart';
import 'package:flutter_clock_app/screens/timer/controller/timer_controller.dart';
import 'package:flutter_clock_app/screens/timer/state/timer_screen_state.dart';
import 'package:provider/provider.dart';

class TimerKeyboardScreen extends StatefulWidget {
  final TimerController timerController;

  const TimerKeyboardScreen({Key? key, required this.timerController}) : super(key: key);

  @override
  State<TimerKeyboardScreen> createState() => _TimerKeyboardScreenState();
}

class _TimerKeyboardScreenState extends State<TimerKeyboardScreen> {
  final TextEditingController _controller = TextEditingController();
  int tapCount = 0;

  @override
  void initState() {
    super.initState();
    _controller.text = "000000";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            displayTimeEditingController(),
            const SizedBox(height: 8.0),
            numbersKeyboard(),
          ],
        ),
      ),
      floatingActionButton: tapCount > 0
          ? SizedBox(
              height: 80,
              width: 80,
              child: FloatingActionButton(
                onPressed: () {
                  Provider.of<TimerScreenState>(context, listen: false).updateScreen();
                  widget.timerController.time = _controller.text;
                  setState(() {});
                },
                child: const Icon(Icons.play_arrow),
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  RichText displayTimeEditingController() {
    return RichText(
      text: TextSpan(
        style: const TextStyle(fontSize: 56.0),
        children: [
          TextSpan(
            text: _controller.text.substring(0, 2),
            style: TextStyle(color: tapCount >= 5 ? Colors.cyan : Colors.grey),
          ),
          TextSpan(
            text: "h",
            style: TextStyle(
                fontSize: 24.0,
                color: tapCount >= 5 ? Colors.cyan : Colors.grey),
          ),
          const WidgetSpan(child: SizedBox(width: 24.0)),
          TextSpan(
            text: _controller.text.substring(2, 4),
            style: TextStyle(color: tapCount >= 3 ? Colors.cyan : Colors.grey),
          ),
          TextSpan(
            text: "m",
            style: TextStyle(
                fontSize: 24.0,
                color: tapCount >= 3 ? Colors.cyan : Colors.grey),
          ),
          const WidgetSpan(child: SizedBox(width: 24.0)),
          TextSpan(
            text: _controller.text.substring(4, 6),
            style: TextStyle(color: tapCount > 0 ? Colors.cyan : Colors.grey),
          ),
          TextSpan(
            text: "s",
            style: TextStyle(
                fontSize: 24.0,
                color: tapCount > 0 ? Colors.cyan : Colors.grey),
          ),
        ],
      ),
    );
  }

  Column numbersKeyboard() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customNumberButton("1"),
            customNumberButton("2"),
            customNumberButton("3"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customNumberButton("4"),
            customNumberButton("5"),
            customNumberButton("6"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customNumberButton("7"),
            customNumberButton("8"),
            customNumberButton("9"),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            customNumberButton("00"),
            customNumberButton("0"),
            customBackspaceButton(),
          ],
        ),
      ],
    );
  }

  Padding customNumberButton(String text) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(100.0),
        onTap: () {
          if (tapCount < 6) {
            if (tapCount == 0 && text == "0" || text == "00") {
              null;
            } else {
              write(text);
            }
          }
          setState(() {});
        },
        child: Ink(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: Colors.grey[700],
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(fontSize: 40.0),
            ),
          ),
        ),
      ),
    );
  }

  Padding customBackspaceButton() {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(100.0),
        onTap: () {
          if (tapCount > 0) {
            backspace();
          }
          setState(() {});
        },
        child: Ink(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: Colors.blueGrey[700],
          ),
          child: const Center(
            child: Icon(
              Icons.backspace_outlined,
              size: 24.0,
            ),
          ),
        ),
      ),
    );
  }

  void write(String text) {
    String substring = _controller.text.substring(1, 6);
    String replaced = substring + text;
    _controller.text = replaced;
    tapCount += 1;
  }

  void backspace() {
    String substring = _controller.text.substring(0, 5);
    String replaced = "0$substring";
    _controller.text = replaced;
    tapCount -= 1;
  }
}
