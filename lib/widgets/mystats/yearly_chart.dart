import 'package:flutter/material.dart';

class YearlyChart extends StatelessWidget {
  const YearlyChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      margin: const EdgeInsets.only(top: 20),
      color: Colors.orange.withOpacity(0.1),
      alignment: Alignment.center,
      child: const Text("연간 차트"),
    );
  }
}
