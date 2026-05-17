import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';
import 'package:sitdown/widgets/common/CategoryList.dart';

class NotificationHeader extends StatefulWidget {
  const NotificationHeader({super.key});

  @override
  State<NotificationHeader> createState() => _NotificationHeader();
}

class _NotificationHeader extends State<NotificationHeader> {
  int selectedIndex = 0;
  List<Map<String, dynamic>> categoryList = [
    {"id": 0, "name": "전체"},
    {"id": 1, "name": "예약"},
    {"id": 2, "name": "시스템"},
    {"id": 3, "name": "공지"},
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,

      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Text(
                        "알림",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  print("전체 읽음");
                },
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Color(0xFFF5F8FF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "전체 읽음",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF2F6BFF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: CategoryList(
              categoryList: categoryList,
              selectedIndex: selectedIndex,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
