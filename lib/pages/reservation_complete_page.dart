import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/pages/main_page.dart';

class ReservationCompletePage extends StatelessWidget {
  final Map<String, dynamic> reservation;

  const ReservationCompletePage({super.key, required this.reservation});

  String formatDate(String value) {
    if (value.isEmpty) return '-';

    try {
      final dateText = value.split(' ').first;
      final parts = dateText.split('-');

      if (parts.length == 3) {
        return '${parts[0]}.${parts[1]}.${parts[2]}';
      }

      return dateText;
    } catch (_) {
      return value;
    }
  }

  String formatTime(String value) {
    if (value.isEmpty) return '-';

    try {
      final timeText = value.split(' ').last;
      return timeText.substring(0, 5);
    } catch (_) {
      return value;
    }
  }

  @override
  Widget build(BuildContext context) {
    final spaceName = reservation['spaceName']?.toString() ?? '-';
    final seatLabel = reservation['seatLabel']?.toString() ?? '-';
    final startAt = reservation['startAt']?.toString() ?? '';
    final endAt = reservation['endAt']?.toString() ?? '';
    final durationHours = reservation['durationHours']?.toString() ?? '-';

    final date = formatDate(startAt);
    final startTime = formatTime(startAt);
    final endTime = formatTime(endAt);

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28, 70, 28, 28),
          child: Column(
            children: [
              const Spacer(),

              Container(
                width: 86,
                height: 86,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.check, color: whiteColor, size: 50),
              ),

              const SizedBox(height: 34),

              const Text(
                '예약이 완료되었습니다!',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF111827),
                ),
              ),

              const SizedBox(height: 70),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(24, 28, 24, 28),
                decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFE9EEF7)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      spaceName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF111827),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      seatLabel,
                      style: const TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF111827),
                      ),
                    ),

                    const SizedBox(height: 34),

                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF5B6475),
                      ),
                    ),

                    const SizedBox(height: 14),

                    Text(
                      '$startTime ~ $endTime ($durationHours시간)',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF5B6475),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),
              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const MainPage()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: whiteColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    '홈으로 이동',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
