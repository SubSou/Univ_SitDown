import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';
import 'package:sitdown/widgets/myfavoritepage/my_favorite_body.dart';
import 'package:sitdown/widgets/myfavoritepage/my_favorite_header.dart';

class MyFavoritePage extends StatefulWidget {
  const MyFavoritePage({Key? key}) : super(key: key);

  @override
  State<MyFavoritePage> createState() => _MyFavoritePageState();
}

class _MyFavoritePageState extends State<MyFavoritePage> {
  List<Map<String, dynamic>> favoriteSeatList = [
    {
      "roomName": "제1열람실 (3층)",
      "seat": "A-12",
      "desc": "창가 좌석 · 콘센트 있음",
      "time": "09:00 - 13:00",
      "status": "사용 가능",
    },
    {
      "roomName": "제2열람실 (2층)",
      "seat": "B-03",
      "desc": "조용한 구역 · 콘센트 있음",
      "time": "14:00 - 18:00",
      "status": "사용 중",
    },
    {
      "roomName": "스터디룸 A (2층)",
      "seat": "C-07",
      "desc": "화이트보드 · 4인실",
      "time": "10:00 - 12:00",
      "status": "예약됨",
    },
    {
      "roomName": "PC실 (1층)",
      "seat": "PC-01",
      "desc": "고성능 PC · 듀얼모니터",
      "time": "09:00 - 22:00",
      "status": "사용 가능",
    },
    {
      "roomName": "제1열람실 (3층)",
      "seat": "A-05",
      "desc": "중앙 좌석 · 조용함",
      "time": "13:00 - 17:00",
      "status": "사용 중",
    },
  ];

  void goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              MyFavoriteHeader(),
              MyFavoriteBody(favoriteSeatList: favoriteSeatList),
            ],
          ),
        ),
      ),
    );
  }
}
