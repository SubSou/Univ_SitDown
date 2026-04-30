import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/util/navigation_util.dart';
import 'package:sitdown/widgets/common/CategoryList.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';
import 'package:sitdown/widgets/notice/notice_item.dart';

class NoticeBody extends StatefulWidget {
  final List<Map<String, dynamic>> noticeList;
  const NoticeBody({super.key, required this.noticeList});

  @override
  State<NoticeBody> createState() => _NoticeBody();
}

class _NoticeBody extends State<NoticeBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: widget.noticeList.map((item) {
        return NoticeItem(item: item);
      }).toList(),
    );
  }
}
