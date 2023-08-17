import 'package:flutter/material.dart';
import 'package:pomodoro/screens/home_screen.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: const Color(0xffe64d3d),
        textTheme: TextTheme(
          displayLarge: TextStyle(
            color: const Color(0xFFF4EDDB).withOpacity(0.4),
            fontSize: 25,
            fontWeight: FontWeight.w600,
          ),
          displayMedium: const TextStyle(
            color: Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        cardColor: Colors.white,
        primarySwatch: Colors.red,
      ),
      home: const HomeScreen(),
    );
  }
}
