import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/util/navigation_util.dart';
import 'package:sitdown/widgets/common/CategoryList.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';

class NoticeBottom extends StatefulWidget {
  const NoticeBottom({super.key});

  @override
  State<NoticeBottom> createState() => _NoticeBottom();
}

class _NoticeBottom extends State<NoticeBottom> {
  int selectedIndex = 0;
  List<Map<String, dynamic>> categoryList = [
    {"id": 0, "name": "전체"},
    {"id": 1, "name": "안내"},
    {"id": 2, "name": "점검"},
    {"id": 3, "name": "이벤트"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 100),
      child: Row(
        spacing: 10,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: primaryColor,
            ),

            child: Center(
              child: Text("1", style: TextStyle(color: whiteColor)),
            ),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: primaryColor,
            ),

            child: Center(
              child: Text("2", style: TextStyle(color: whiteColor)),
            ),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: primaryColor,
            ),

            child: Center(
              child: Text("3", style: TextStyle(color: whiteColor)),
            ),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: primaryColor,
            ),

            child: Center(
              child: Text("4", style: TextStyle(color: whiteColor)),
            ),
          ),
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: primaryColor,
            ),

            child: Center(
              child: Text("5", style: TextStyle(color: whiteColor)),
            ),
          ),
        ],
      ),
    );
  }
}
