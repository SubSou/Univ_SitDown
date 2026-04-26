import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/widgets/reservationpage/reservation_header.dart';
import 'package:sitdown/widgets/reservationpage/reservation_body.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({Key? key}) : super(key: key);

  @override
  State<ReservationPage> createState() => _MyReservationPageState();
}

class _MyReservationPageState extends State<ReservationPage> {
  List<Map<String, dynamic>> reservationList = [
    {
      "roomName": "제1열람실 (3층)",
      "seat": "A-12",
      "time": "09:00 ~ 13:00 (4시간)",
      "status": "이용 중",
      "remainTime": "02:15:30",
    },
    {
      "roomName": "제2열람실 (2층)",
      "seat": "B-07",
      "time": "10:00 ~ 14:00 (4시간)",
      "status": "이용 중",
      "remainTime": "01:05:10",
    },
    {
      "roomName": "스터디룸 (1층)",
      "seat": "ROOM-3",
      "time": "13:00 ~ 15:00 (2시간)",
      "status": "이용 중",
      "remainTime": "00:45:20",
    },
    {
      "roomName": "스터디룸 (1층)",
      "seat": "ROOM-3",
      "time": "13:00 ~ 15:00 (2시간)",
      "status": "이용 중",
      "remainTime": "00:45:20",
    },
    {
      "roomName": "스터디룸 (1층)",
      "seat": "ROOM-3",
      "time": "13:00 ~ 15:00 (2시간)",
      "status": "이용 중",
      "remainTime": "00:45:20",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ReservationHeader(),
              ReservationBody(reservationList: reservationList),
            ],
          ),
        ),
      ),
    );
  }
}
