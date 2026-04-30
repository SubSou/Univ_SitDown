import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';

class NoticeItem extends StatefulWidget {
  final Map<String, dynamic> item;
  const NoticeItem({super.key, required this.item});

  @override
  State<NoticeItem> createState() => _NoticeItem();
}

class _NoticeItem extends State<NoticeItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20), // ⭐ 여기로 이동
      child: Material(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            print(widget.item["title"]);
          },
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Color(0xFFE5E5E5)),
              boxShadow: [
                BoxShadow(
                  color: blackColor.withOpacity(0.03),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        widget.item["title"],
                        style: TextStyle(
                          color: blackColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Container(
                      child: Text(
                        widget.item["date"],
                        style: TextStyle(color: subTextColor),
                      ),
                    ),
                  ],
                ),
                Container(child: Icon(Icons.chevron_right)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
