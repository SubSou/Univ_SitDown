import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';

class MyFavoriteBodyItem extends StatelessWidget {
  final Map<String, dynamic> item;

  const MyFavoriteBodyItem({Key? key, required this.item}) : super(key: key);

  String getCategoryName(String? category) {
    switch (category) {
      case 'READING_ROOM':
        return '열람실';
      case 'STUDY_ROOM':
        return '스터디룸';
      case 'PC_ROOM':
        return 'PC실';
      case 'LECTURE_ROOM':
        return '강의실';
      default:
        return '공간';
    }
  }

  String getCongestionName(String? congestion) {
    switch (congestion) {
      case 'LOW':
        return '여유';
      case 'NORMAL':
        return '보통';
      case 'HIGH':
        return '혼잡';
      default:
        return '-';
    }
  }

  Color getCongestionBgColor(String? congestion) {
    switch (congestion) {
      case 'LOW':
        return greenStatusColor;
      case 'NORMAL':
        return const Color(0xFFFFF3CD);
      case 'HIGH':
        return const Color(0xFFFFE0E0);
      default:
        return const Color(0xFFE5E5E5);
    }
  }

  Color getCongestionTextColor(String? congestion) {
    switch (congestion) {
      case 'LOW':
        return greenLightColor;
      case 'NORMAL':
        return const Color(0xFFB7791F);
      case 'HIGH':
        return const Color(0xFFD32F2F);
      default:
        return subTextColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    final name = item['name']?.toString() ?? '이름 없음';
    final floor = item['floor']?.toString() ?? '-';
    final category = item['category']?.toString();
    final totalSeats = item['totalSeats']?.toString() ?? '0';
    final availableSeats = item['availableSeats']?.toString() ?? '0';
    final congestion = item['congestion']?.toString();
    final openTime = item['openTime']?.toString() ?? '-';
    final closeTime = item['closeTime']?.toString() ?? '-';

    final features = item['features'] is List
        ? (item['features'] as List).map((e) => e.toString()).join(' · ')
        : '';

    return Container(
      margin: const EdgeInsets.only(top: 14),
      width: double.infinity,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.account_balance, color: primaryColor, size: 16),
              const SizedBox(width: 8),
              Text(
                getCategoryName(category),
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 6),

          Text(
            '$floor층 · 전체 $totalSeats석 · 사용 가능 $availableSeats석',
            style: TextStyle(color: subTextColor, fontSize: 14),
          ),

          if (features.isNotEmpty) ...[
            const SizedBox(height: 6),
            Text(features, style: TextStyle(color: subTextColor, fontSize: 14)),
          ],

          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.timer_outlined, color: subTextColor, size: 18),
                  const SizedBox(width: 5),
                  Text(
                    '$openTime - $closeTime',
                    style: TextStyle(color: subTextColor),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: getCongestionBgColor(congestion),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  getCongestionName(congestion),
                  style: TextStyle(
                    color: getCongestionTextColor(congestion),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
