import 'package:flutter/material.dart';

class chevron_left extends StatelessWidget {
  final VoidCallback onTap;

  const chevron_left({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(child: Icon(Icons.chevron_left)),
    );
  }
}
