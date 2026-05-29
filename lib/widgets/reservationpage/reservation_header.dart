import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';

class ReservationHeader extends StatelessWidget {
  final String selectedStatus;
  final void Function(String status) onChanged;

  const ReservationHeader({
    super.key,
    required this.selectedStatus,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final tabs = [
      {'title': '진행 중', 'status': 'ACTIVE'},
      {'title': '지난 예약', 'status': 'PAST'},
      {'title': '취소 내역', 'status': 'CANCELED'},
    ];

    return SizedBox(
      height: 64,
      child: Row(
        children: tabs.map((tab) {
          final title = tab['title']!;
          final status = tab['status']!;
          final isSelected = selectedStatus == status;

          return Expanded(
            child: InkWell(
              onTap: () {
                onChanged(status);
              },
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected
                              ? FontWeight.w800
                              : FontWeight.w500,
                          color: isSelected
                              ? primaryColor
                              : const Color(0xFF6B7280),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 4,
                    width: double.infinity,
                    color: isSelected ? primaryColor : const Color(0xFFE5E7EB),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
