import 'package:flutter/material.dart';

class WeeklyChart extends StatelessWidget {
  const WeeklyChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      margin: const EdgeInsets.only(top: 20),
      color: Colors.blue.withOpacity(0.1),
      alignment: Alignment.center,
      child: const Text("주간 차트"),
    );
  }
}
