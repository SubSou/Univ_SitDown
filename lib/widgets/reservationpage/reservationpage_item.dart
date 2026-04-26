import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/widgets/common/ActionButton.dart';

class ReservationItem extends StatelessWidget {
  final String roomName;
  final String seat;
  final String time;
  final String status;
  final String remainTime;
  final int currentIndex;

  const ReservationItem({
    super.key,
    required this.roomName,
    required this.seat,
    required this.time,
    required this.status,
    required this.remainTime,
    required this.currentIndex,
  });

  Widget build(BuildContext context) {
    return Container(
      width: 400,
      margin: EdgeInsets.only(top: currentIndex != 0 ? 20 : 0),
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
          Container(
            child: Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      roomName,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: greenStatusColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "보통",
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
          ),
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10),
            child: Text(
              seat,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(child: Text(time)),
                Container(
                  child: Text(
                    "남은 시간",
                    style: TextStyle(
                      color: greenLightColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 20),
            alignment: Alignment.centerRight,
            child: Text(
              remainTime,
              style: TextStyle(
                color: greenLightColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Row(
            children: [
              ActionButton(
                text: "연장하기",
                borderColor: primaryColor,
                textColor: primaryColor,
                onPressed: () {},
              ),
              SizedBox(width: 10),
              ActionButton(
                text: "취소하기",
                borderColor: cacleColor,
                textColor: Colors.red,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
