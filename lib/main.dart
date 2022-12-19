import 'package:flutter/material.dart';
import 'package:flutter_clock_app/screens/navigation/navigation_screen.dart';
import 'package:flutter_clock_app/screens/timer/state/timer_screen_state.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TimerScreenState(screen: "Key")),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clock App',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.cyan,
      ),
      home: const NavigationScreen()
    );
  }
}
