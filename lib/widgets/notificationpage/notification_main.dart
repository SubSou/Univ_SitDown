import 'package:flutter/material.dart';
import 'package:sitdown/widgets/notificationpage/notification_item.dart';

class NotificationMain extends StatefulWidget {
  const NotificationMain({super.key});

  @override
  State<NotificationMain> createState() => _NotificationMain();
}

class _NotificationMain extends State<NotificationMain> {
  List<Map<String, dynamic>> notificationList = [
    {
      "id": 1,
      "type": "success", // 예약 완료
      "title": "예약이 완료되었습니다",
      "desc": "제1열람실 A-12 좌석이 예약되었습니다.",
      "time": "방금 전",
      "isRead": false,
    },
    {
      "id": 2,
      "type": "notice", // 시간 임박
      "title": "이용 시간이 곧 종료됩니다",
      "desc": "10분 후 자동으로 종료됩니다.",
      "time": "5분 전",
      "isRead": false,
    },
    {
      "id": 3,
      "type": "cancel", // 취소
      "title": "예약이 취소되었습니다",
      "desc": "제2열람실 B-07 좌석이 취소되었습니다.",
      "time": "10분 전",
      "isRead": true,
    },
    {
      "id": 4,
      "type": "system", // 시스템
      "title": "시스템 점검 안내",
      "desc": "오늘 밤 2시 ~ 4시 서비스 이용이 제한됩니다.",
      "time": "1시간 전",
      "isRead": true,
    },
    {
      "id": 5,
      "type": "success",
      "title": "예약이 완료되었습니다",
      "desc": "스터디룸 C-03 예약이 완료되었습니다.",
      "time": "2시간 전",
      "isRead": false,
    },
    {
      "id": 6,
      "type": "notice",
      "title": "좌석 이용 시간이 얼마 남지 않았습니다",
      "desc": "연장을 원하시면 지금 신청해주세요.",
      "time": "3시간 전",
      "isRead": true,
    },
    {
      "id": 6,
      "type": "notice",
      "title": "좌석 이용 시간이 얼마 남지 않았습니다",
      "desc": "연장을 원하시면 지금 신청해주세요.",
      "time": "3시간 전",
      "isRead": true,
    },
    {
      "id": 6,
      "type": "notice",
      "title": "좌석 이용 시간이 얼마 남지 않았습니다",
      "desc": "연장을 원하시면 지금 신청해주세요.",
      "time": "3시간 전",
      "isRead": true,
    },
    {
      "id": 6,
      "type": "notice",
      "title": "좌석 이용 시간이 얼마 남지 않았습니다",
      "desc": "연장을 원하시면 지금 신청해주세요.",
      "time": "3시간 전",
      "isRead": true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: notificationList.map((item) {
          return NotificationItem(
            id: item["id"] as int,
            type: item["type"] as String,
            title: item["title"] as String,
            desc: item["desc"] as String,
            time: item["time"] as String,
            isRead: item["isRead"] as bool,
          );
        }).toList(),
      ),
    );
  }
}
