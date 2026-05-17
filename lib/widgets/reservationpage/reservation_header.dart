import 'package:flutter/material.dart';

const primaryColor = Color(0xFF104FCF);

class ReservationHeader extends StatefulWidget {
  const ReservationHeader({super.key});

  @override
  State<ReservationHeader> createState() => _ReservationHeaderState();
}

class _ReservationHeaderState extends State<ReservationHeader> {
  int selectedIndex = 0;

  final tabs = ["진행 중", "지난 예약", "취소 내역"];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 64,
      child: Row(
        children: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final text = entry.value;
          final isSelected = selectedIndex == index;

          return Expanded(
            child: InkWell(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: Column(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        text,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: isSelected
                              ? FontWeight.bold
                              : FontWeight.w500,
                          color: isSelected
                              ? primaryColor
                              : const Color(0xFF6B7280),
                        ),
                      ),
                    ),
                  ),

                  // 🔥 높이 고정 (핵심)
                  Container(
                    height: 4,
                    width: double.infinity,
                    color: isSelected
                        ? primaryColor
                        : const Color(0xFFE5E7EB), // 회색 라인 유지
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
