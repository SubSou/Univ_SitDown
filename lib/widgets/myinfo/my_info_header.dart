import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/util/navigation_util.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';

class MyInfoHeader extends StatefulWidget {
  const MyInfoHeader({Key? key}) : super(key: key);

  @override
  State<MyInfoHeader> createState() => _MyInfoHeaderState();
}

class _MyInfoHeaderState extends State<MyInfoHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        chevron_left(
          onTap: () {
            NavUtil.pop(context);
          },
        ),
        Container(
          margin: EdgeInsets.only(left: 20),
          child: Text(
            "내정보",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
