import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  State<ReservationPage> createState() => _MyReservationPageState();
}

class _MyReservationPageState extends State<ReservationPage> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(children: [Text("data123")]),
      ),
    );
  }
}
