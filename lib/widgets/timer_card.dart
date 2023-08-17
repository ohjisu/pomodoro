import 'package:flutter/material.dart';

class TimerCard extends StatelessWidget {
  String num;

  TimerCard({
    Key? key,
    required this.num,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 120,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Text(
        num,
        style: const TextStyle(
          color: Colors.red,
          fontSize: 60,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
