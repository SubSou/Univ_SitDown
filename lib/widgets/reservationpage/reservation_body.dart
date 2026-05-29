import 'package:flutter/material.dart';
import 'package:sitdown/widgets/reservationpage/reservationpage_item.dart';

class ReservationBody extends StatelessWidget {
  final List<Map<String, dynamic>> reservationList;
  final VoidCallback onRefresh;

  const ReservationBody({
    super.key,
    required this.reservationList,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    if (reservationList.isEmpty) {
      return const Center(child: Text('예약 내역이 없습니다.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 20, bottom: 20),
      itemCount: reservationList.length,
      itemBuilder: (context, index) {
        return ReservationItem(
          item: reservationList[index],
          currentIndex: index,
          onRefresh: onRefresh,
        );
      },
    );
  }
}
