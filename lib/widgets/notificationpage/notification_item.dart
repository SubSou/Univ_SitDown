import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sitdown/constants/app_colors.dart';

class NotificationItem extends StatelessWidget {
  final int id;
  final String type;
  final String title;
  final String desc;
  final String time;
  final bool isRead;

  const NotificationItem({
    super.key,
    required this.id,
    required this.type,
    required this.title,
    required this.desc,
    required this.time,
    required this.isRead,
  });

  // 🔥 아이콘 경로 분기
  String getIconPath() {
    switch (type) {
      case "success":
        return "/icons/reservation_success.svg";
      case "notice":
        return "/icons/megaphone.svg";
      case "cancel":
        return "/icons/reservation_cancel.svg";
      case "system":
        return "/icons/system_notification.svg";
      default:
        return "/icons/system_notification.svg";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("클릭");
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: isRead
              ? Colors.white
              : primaryColor.withOpacity(0.05), // 🔥 읽음/안읽음
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isRead
                ? Colors.grey.shade200
                : primaryColor.withOpacity(0.2),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 🔥 SVG 아이콘
            SvgPicture.asset(getIconPath(), width: 32, height: 32),

            const SizedBox(width: 12),

            // 🔥 텍스트 영역
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    time,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
