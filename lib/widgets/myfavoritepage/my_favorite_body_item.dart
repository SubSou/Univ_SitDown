import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';

class MyFavoriteBodyItem extends StatefulWidget {
  final Map<String, dynamic> item;
  const MyFavoriteBodyItem({Key? key, required this.item}) : super(key: key);

  @override
  State<MyFavoriteBodyItem> createState() => _MyFavoriteBodyItem();
}

class _MyFavoriteBodyItem extends State<MyFavoriteBodyItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                        widget.item["roomName"],
                        style: TextStyle(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.item["seat"],
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(Icons.chevron_right),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.item["desc"],
                    style: TextStyle(color: subTextColor),
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Icon(
                                Icons.timer_outlined,
                                color: subTextColor,
                              ),
                            ),
                            Container(
                              child: Text(
                                widget.item["time"],
                                style: TextStyle(color: subTextColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: greenStatusColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          widget.item["status"],
                          style: TextStyle(
                            color: greenLightColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
