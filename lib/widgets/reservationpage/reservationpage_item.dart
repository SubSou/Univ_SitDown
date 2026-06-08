import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitdown/api/rsv_api.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/providers/auth_provider.dart';
import 'package:sitdown/widgets/common/ActionButton.dart';

class ReservationItem extends StatefulWidget {
  final Map<String, dynamic> item;
  final int currentIndex;
  final VoidCallback onRefresh;

  const ReservationItem({
    super.key,
    required this.item,
    required this.currentIndex,
    required this.onRefresh,
  });

  @override
  State<ReservationItem> createState() => _ReservationItemState();
}

class _ReservationItemState extends State<ReservationItem> {
  Timer? timer;
  int remainingSeconds = 0;

  @override
  void initState() {
    super.initState();

    remainingSeconds =
        int.tryParse(widget.item['remainingSeconds']?.toString() ?? '0') ?? 0;

    startTimer();
  }

  void startTimer() {
    timer?.cancel();

    if (remainingSeconds > 0) {
      timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (!mounted) return;

        if (remainingSeconds <= 0) {
          timer?.cancel();
          return;
        }

        setState(() {
          remainingSeconds--;
        });
      });
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  String formatDateTime(String? value) {
    if (value == null || value.isEmpty) return '';

    try {
      final dateTime = DateTime.parse(value);

      final year = dateTime.year;
      final month = dateTime.month.toString().padLeft(2, '0');
      final day = dateTime.day.toString().padLeft(2, '0');
      final hour = dateTime.hour.toString().padLeft(2, '0');
      final minute = dateTime.minute.toString().padLeft(2, '0');

      return '$year-$month-$day $hour:$minute';
    } catch (e) {
      return value;
    }
  }

  String getStatusText(String status) {
    if (status == 'IN_USE') return '이용 중';
    if (status == 'SCHEDULED') return '예약 중';
    if (status == 'COMPLETED') return '완료';
    if (status == 'CANCELED') return '취소';
    return status;
  }

  String formatRemainTime(int seconds) {
    if (seconds <= 0) return '00:00:00';

    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainSeconds = seconds % 60;

    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${remainSeconds.toString().padLeft(2, '0')}';
  }

  bool get canExtend {
    return remainingSeconds > 600;
  }

  Future<void> extendReservation() async {
    if (!canExtend) return;

    final accessToken = context.read<AuthProvider>().accessToken;

    if (accessToken == null || accessToken.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('로그인이 필요합니다.')));
      return;
    }

    try {
      final reservationId = widget.item['id'].toString();
      final authProvider = context.read<AuthProvider>();

      await RsvApi.extendReservation(
        accessToken: accessToken,
        reservationId: reservationId,
        additionalMinutes: 30,
      );

      await RsvApi.extendReservation(
        accessToken: accessToken,
        reservationId: reservationId,
        additionalMinutes: 30,
      );

      await authProvider.fetchMyReservations(status: 'ACTIVE');

      widget.onRefresh();

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('예약이 연장되었습니다.')));
    } catch (e) {
      print('연장 실패 : $e');

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('예약 연장에 실패했습니다.')));
    }
  }

  Future<void> cancelReservation() async {
    final accessToken = context.read<AuthProvider>().accessToken;

    if (accessToken == null || accessToken.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('로그인이 필요합니다.')));
      return;
    }

    try {
      final reservationId = widget.item['id'].toString();

      await RsvApi.cancelReservation(
        accessToken: accessToken,
        reservationId: reservationId,
        reason: '사용자 취소',
      );

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('예약이 취소되었습니다.')));

      /// 목록 재조회
      widget.onRefresh();
    } catch (e) {
      print('예약 취소 실패 : $e');

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('예약 취소에 실패했습니다.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final spaceName = widget.item['spaceName']?.toString() ?? '공간명 없음';
    final seatLabel = widget.item['seatLabel']?.toString() ?? '';
    final floor = widget.item['spaceFloor']?.toString() ?? '';
    final startAt = formatDateTime(widget.item['startAt']?.toString());
    final endAt = formatDateTime(widget.item['endAt']?.toString());
    final status = widget.item['status']?.toString() ?? '';

    final bool isDangerTime = status == 'IN_USE' && remainingSeconds <= 1800;
    final Color remainTimeColor = isDangerTime ? Colors.red : greenLightColor;

    final Color statusBackgroundColor = status == 'CANCELED'
        ? const Color(0xFFFFEBEE)
        : greenStatusColor;

    final Color statusTextColor = status == 'CANCELED'
        ? const Color(0xFFD32F2F)
        : greenLightColor;

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: widget.currentIndex != 0 ? 20 : 0),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E5E5)),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                spaceName,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusBackgroundColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  getStatusText(status),
                  style: TextStyle(
                    color: statusTextColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '$floor층 $seatLabel',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$startAt ~ $endAt',
                style: const TextStyle(fontSize: 13, color: Color(0xFF6B7280)),
              ),
              if (status == 'IN_USE')
                Text(
                  '남은 시간',
                  style: TextStyle(
                    color: remainTimeColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),

          if (status == 'IN_USE')
            Container(
              margin: const EdgeInsets.only(bottom: 20, top: 4),
              alignment: Alignment.centerRight,
              child: Text(
                formatRemainTime(remainingSeconds),
                style: TextStyle(
                  color: remainTimeColor,
                  fontSize: isDangerTime ? 18 : 16,
                  fontWeight: isDangerTime ? FontWeight.w900 : FontWeight.w700,
                ),
              ),
            ),

          if (status == 'IN_USE' || status == 'SCHEDULED')
            Row(
              children: [
                Expanded(
                  child: ActionButton(
                    text: canExtend ? '연장하기' : '연장불가',
                    borderColor: canExtend ? primaryColor : Colors.grey,
                    textColor: canExtend ? primaryColor : Colors.grey,
                    onPressed: extendReservation,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ActionButton(
                    text: '취소하기',
                    borderColor: cacleColor,
                    textColor: Colors.red,
                    onPressed: () async {
                      final result = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('예약 취소'),
                            content: const Text('정말 예약을 취소하시겠습니까?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, false);
                                },
                                child: const Text('아니오'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                },
                                child: const Text(
                                  '예',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        },
                      );

                      if (result == true) {
                        await cancelReservation();
                      }
                    },
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
