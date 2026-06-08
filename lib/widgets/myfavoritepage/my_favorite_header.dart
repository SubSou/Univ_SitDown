import 'package:flutter/material.dart';
import 'package:sitdown/util/navigation_util.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';

class MyFavoriteHeader extends StatelessWidget {
  const MyFavoriteHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        chevron_left(
          onTap: () {
            NavUtil.pop(context);
          },
        ),
        const Expanded(
          child: Center(
            child: Text(
              "내 즐겨찾기",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
        ),
        Opacity(opacity: 0.0, child: chevron_left(onTap: () {})),
      ],
    );
  }
}
