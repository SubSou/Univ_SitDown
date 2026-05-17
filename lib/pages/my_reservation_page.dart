import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';

class MyReservationPage extends StatefulWidget {
  const MyReservationPage({Key? key}) : super(key: key);

  @override
  State<MyReservationPage> createState() => _MyReservationPageState();
}

class _MyReservationPageState extends State<MyReservationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              chevron_left(onTap: () {}),
              Text("data"),
            ],
          ),
        ),
      ),
    );
  }
}
