import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/widgets/myfavoritepage/my_favorite_body_item.dart';

class MyFavoriteBody extends StatefulWidget {
  final List<Map<String, dynamic>> favoriteSeatList;
  const MyFavoriteBody({Key? key, required this.favoriteSeatList})
    : super(key: key);

  @override
  State<MyFavoriteBody> createState() => _MyFavoriteBodyState();
}

class _MyFavoriteBodyState extends State<MyFavoriteBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 5, top: 20),
            child: Text("즐겨찾기한 좌석"),
          ),
          Container(
            margin: EdgeInsets.only(left: 5, top: 5, bottom: 10),
            child: Text(
              "총 3개 좌석",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          ...widget.favoriteSeatList.map((item) {
            return MyFavoriteBodyItem(item: item);
          }).toList(),
        ],
      ),
    );
  }
}
