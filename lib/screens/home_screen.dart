import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro/widgets/timer_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const fiveSeconds = 2;
  static const fiveMinutes = 5 * 60;
  static const fifteenFiveMinutes = 15 * 60;
  static const twentyMinutes = 20 * 60;
  static const twentyFiveMinutes = 1500;
  static const thirtyMinutes = 30 * 60;
  static const thirtyFiveMinutes = 35 * 60;
  int resetSeconds = fiveSeconds;
  int totalSeconds = fiveSeconds;
  bool isRunning = false;
  late Timer timer;
  late Timer restTimer;
  int totalPomodoros = 0;
  int totalGoals = 0;
  bool isDisabled = false;

  void onTick(Timer timer) {
    if (totalSeconds == 0) {
      setState(() {
        totalPomodoros = totalPomodoros + 1;
        if (totalPomodoros == 4) {
          totalGoals = totalGoals + 1;
          totalPomodoros = 0;
          isDisabled = true;
        }
        isRunning = false;
        totalSeconds = resetSeconds;
      });
      timer.cancel();
    } else {
      setState(() {
        totalSeconds = totalSeconds - 1;
      });
    }
  }

  String min_format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 4);
  }

  String sec_format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(5, 7);
  }

  void updateTotalSeconds(int time) {
    var seconds = 0;
    switch (time) {
      case 0:
        seconds = fiveSeconds;
        break;
      case 15:
        seconds = fifteenFiveMinutes;
        break;
      case 20:
        seconds = twentyMinutes;
        break;
      case 25:
        seconds = twentyFiveMinutes;
        break;
      case 30:
        seconds = thirtyMinutes;
        break;
      case 35:
        seconds = thirtyFiveMinutes;
        break;
      default:
        seconds = fiveSeconds;
        break;
    }
    setState(() {
      totalSeconds = seconds;
      resetSeconds = seconds;
      isRunning = false;
    });
    timer.cancel();
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausePressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).backgroundColor,
        title: const Text("POMOTIMER"),
      ),
      backgroundColor:
          isDisabled ? Colors.deepPurple : Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TimerCard(
                    num: min_format(totalSeconds),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ":",
                      style: TextStyle(
                        color: const Color(0xFFF4EDDB).withOpacity(0.4),
                        fontSize: 40,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  TimerCard(
                    num: sec_format(totalSeconds),
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (var time in [0, 15, 20, 25, 30, 35])
                    OutlinedButton(
                      onPressed: () {
                        updateTotalSeconds(time);
                      },
                      child: Text(
                        '$time',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    )
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Center(
              child: isDisabled
                  ? const Text("(5분간 휴식)")
                  : IconButton(
                      onPressed: isRunning ? onPausePressed : onStartPressed,
                      icon: Icon(
                        isRunning
                            ? Icons.pause_circle_outline
                            : Icons.play_circle_outline_outlined,
                      ),
                      iconSize: 100,
                      color: Theme.of(context).cardColor,
                    ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        '$totalPomodoros/4',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Text(
                        'ROUND',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '$totalGoals/12',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Text(
                        'GOAL',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
