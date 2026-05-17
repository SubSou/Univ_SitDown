import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: whiteColor,
      child: Align(
        alignment: AlignmentGeometry.centerLeft,
        child: Text(
          'UNIV SITDOWN',
          style: TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
