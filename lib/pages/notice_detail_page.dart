import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/util/navigation_util.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';

class NoticeDetailPage extends StatelessWidget {
  final Map<String, dynamic> item;

  const NoticeDetailPage({super.key, required this.item});

  String formatDateTime(String? value) {
    if (value == null || value.isEmpty) return '';

    try {
      final dateTime = DateTime.parse(value);

      final year = dateTime.year;
      final month = dateTime.month.toString().padLeft(2, '0');
      final day = dateTime.day.toString().padLeft(2, '0');
      final hour = dateTime.hour.toString().padLeft(2, '0');
      final minute = dateTime.minute.toString().padLeft(2, '0');

      return '$year-$month-$day $hour:$minute';
    } catch (e) {
      return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final String title = item["title"]?.toString() ?? "제목 없음";

    final String content =
        item["content"]?.toString() ??
        item["description"]?.toString() ??
        "내용이 없습니다.";

    final String date = formatDateTime(
      item["date"]?.toString() ??
          item["createdAt"]?.toString() ??
          item["publishedAt"]?.toString(),
    );

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              chevron_left(
                onTap: () {
                  NavUtil.pop(context);
                },
              ),

              const SizedBox(height: 20),

              Text(
                title,
                style: TextStyle(
                  color: blackColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(date, style: TextStyle(color: subTextColor, fontSize: 14)),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                height: 1,
                color: const Color(0xFFE5E5E5),
              ),

              const SizedBox(height: 24),

              Text(
                content,
                style: TextStyle(color: blackColor, fontSize: 16, height: 1.6),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
