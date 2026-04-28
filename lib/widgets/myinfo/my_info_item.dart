import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';

class MyInfoItem extends StatelessWidget {
  final String mainTitle;
  final String subTitle;

  const MyInfoItem({Key? key, required this.mainTitle, required this.subTitle})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(mainTitle, style: TextStyle(fontWeight: FontWeight.bold)),
              Text(subTitle),
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
