import 'package:flutter/material.dart';
import 'package:flutter_clock_app/screens/alarm/alarm_screen.dart';
import 'package:flutter_clock_app/screens/clock/clock_screen.dart';
import 'package:flutter_clock_app/screens/sleep/sleep_screen.dart';
import 'package:flutter_clock_app/screens/stopwatch/stopwatch_screen.dart';
import 'package:flutter_clock_app/screens/timer/timer_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const AlarmScreen(),
    const ClockScreen(),
    const TimerScreen(),
    const StopwatchScreen(),
    const SleepScreen(),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: SizedBox(
        height: 80,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          unselectedFontSize: 16.0,
          backgroundColor: Colors.blueGrey[900],
          fixedColor: Colors.white,
          currentIndex: _selectedIndex,
          onTap: onItemTapped,
          items: [
            BottomNavigationBarItem(
                icon: _selectedIndex == 0
                    ? selectedIcon(Icons.alarm)
                    : unselectedIcon(Icons.alarm),
                label: "Alarm"),
            BottomNavigationBarItem(
                icon: _selectedIndex == 1
                    ? selectedIcon(Icons.access_time_rounded)
                    : unselectedIcon(Icons.access_time_rounded),
                label: "Clock"),
            BottomNavigationBarItem(
                icon: _selectedIndex == 2
                    ? selectedIcon(Icons.hourglass_bottom)
                    : unselectedIcon(Icons.hourglass_bottom),
                label: "Timer"),
            BottomNavigationBarItem(
                icon: _selectedIndex == 3
                    ? selectedIcon(Icons.timer_outlined)
                    : unselectedIcon(Icons.timer_outlined),
                label: "Stopwatch"),
            BottomNavigationBarItem(
                icon: _selectedIndex == 4
                    ? selectedIcon(Icons.bed)
                    : unselectedIcon(Icons.bed),
                label: "Sleep"),
          ],
        ),
      ),
    );
  }

  Widget selectedIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Container(
        height: 30,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.blueGrey[800],
          borderRadius: BorderRadius.circular(50.0),
        ),
        child: Icon(icon),
      ),
    );
  }

  Widget unselectedIcon(IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.8, bottom: 10.2),
      child: Icon(icon),
    );
  }
}
