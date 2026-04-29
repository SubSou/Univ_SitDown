import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/util/navigation_util.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';

class MyFavoriteHeader extends StatefulWidget {
  const MyFavoriteHeader({Key? key}) : super(key: key);

  @override
  State<MyFavoriteHeader> createState() => _MyFavoriteHeaderState();
}

class _MyFavoriteHeaderState extends State<MyFavoriteHeader> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          child: chevron_left(
            onTap: () {
              NavUtil.pop(context);
            },
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              "내 즐겨찾기",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        Opacity(
          opacity: 0.0,
          child: Container(
            alignment: Alignment.centerLeft,
            child: chevron_left(onTap: () {}),
          ),
        ),
      ],
    );
  }
}
