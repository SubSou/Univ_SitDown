import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/util/navigation_util.dart';
import 'package:sitdown/widgets/common/CategoryList.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';

class NoticeHeader extends StatefulWidget {
  const NoticeHeader({super.key});

  @override
  State<NoticeHeader> createState() => _NoticeHeader();
}

class _NoticeHeader extends State<NoticeHeader> {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          chevron_left(
            onTap: () {
              NavUtil.pop(context);
            },
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
