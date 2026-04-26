import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/widgets/reservationpage/reservationpage_item.dart';

class ReservationBody extends StatelessWidget {
  final List<Map<String, dynamic>> reservationList;

  const ReservationBody({super.key, required this.reservationList});

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, bottom: 20),
      child: Column(
        children: reservationList.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return ReservationItem(
            roomName: item["roomName"],
            seat: item["seat"],
            time: item["time"],
            status: item["status"],
            remainTime: item["remainTime"],
            currentIndex: index,
          );
        }).toList(),
      ),
    );
  }
}
