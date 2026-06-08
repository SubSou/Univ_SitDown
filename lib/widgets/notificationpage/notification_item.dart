import 'package:flutter/material.dart';
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

  IconData getIcon() {
    switch (type) {
      case "success":
        return Icons.event_available;
      case "notice":
        return Icons.campaign;
      case "cancel":
        return Icons.event_busy;
      case "system":
        return Icons.settings;
      default:
        return Icons.notifications;
    }
  }

  Color getIconColor() {
    switch (type) {
      case "success":
        return primaryColor;
      case "notice":
        return Colors.orange;
      case "cancel":
        return Colors.redAccent;
      case "system":
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        debugPrint("알림 클릭: $id");
      },
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: isRead ? Colors.white : primaryColor.withOpacity(0.05),
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
            Icon(getIcon(), size: 32, color: getIconColor()),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                      color: isRead ? Colors.grey.shade600 : Colors.black87,
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
