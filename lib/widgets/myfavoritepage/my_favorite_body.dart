import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';

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
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: whiteColor,
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
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.account_balance, color: primaryColor, size: 15),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        "제1열람실 (3층)",
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "A-12",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
