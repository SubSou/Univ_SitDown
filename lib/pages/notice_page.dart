import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/util/navigation_util.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';
import 'package:sitdown/widgets/notice/notice_body.dart';
import 'package:sitdown/widgets/notice/notice_bottom.dart';
import 'package:sitdown/widgets/notice/notice_header.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  List<Map<String, String>> noticeList = [
    {"title": "도서관 이용 안내", "date": "2024.05.18"},
    {"title": "열람실 좌석 시스템 점검 안내", "date": "2024.05.15"},
    {"title": "스터디룸 예약 정책 변경 안내", "date": "2024.05.10"},
    {"title": "5월 도서관 휴관일 안내", "date": "2024.05.05"},
    {"title": "이벤트 당첨자 발표", "date": "2024.04.30"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              NoticeHeader(),
              NoticeBody(noticeList: noticeList),
              NoticeBottom(),
            ],
          ),
        ),
      ),
    );
  }
}
