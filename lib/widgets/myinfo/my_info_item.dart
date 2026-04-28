import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';

class MyInfoItem extends StatelessWidget {
  final String mainTitle;
  final TextEditingController controller;
  final bool enabled;

  const MyInfoItem({
    Key? key,
    required this.mainTitle,
    required this.controller,
    this.enabled = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Row(
            children: [
              SizedBox(
                width: 80,
                child: Text(
                  mainTitle,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: controller, // ⭐ 부모에서 받은 값
                  enabled: enabled,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(border: InputBorder.none),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 15),
          height: 1,
          width: double.infinity,
          color: Color(0xFFE5E5E5),
        ),
      ],
    );
  }
}
