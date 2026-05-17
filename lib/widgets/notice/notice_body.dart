import 'package:flutter/material.dart';
import 'package:sitdown/widgets/notice/notice_item.dart';

class NoticeBody extends StatelessWidget {
  final List<Map<String, dynamic>> noticeList;

  const NoticeBody({super.key, required this.noticeList});

  @override
  Widget build(BuildContext context) {
    if (noticeList.isEmpty) {
      return const Center(
        child: Text(
          "조회된 공지사항이 없습니다.",
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: noticeList.length,
      itemBuilder: (context, index) {
        return NoticeItem(item: noticeList[index]);
      },
    );
  }
}
