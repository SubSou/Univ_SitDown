import 'package:flutter/material.dart';

class MonthlyChart extends StatelessWidget {
  const MonthlyChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      margin: const EdgeInsets.only(top: 20),
      color: Colors.green.withOpacity(0.1),
      alignment: Alignment.center,
      child: const Text("월간 차트"),
    );
  }
}
