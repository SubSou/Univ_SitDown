import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/providers/auth_provider.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final myInfo = context.watch<AuthProvider>().myInfo;
    final reservationList = context.watch<AuthProvider>().reservationList;

    final name = myInfo?['name']?.toString() ?? '사용자';
    final hasReservation = reservationList.isNotEmpty;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Text(
              "안녕하세요, $name님",
              style: TextStyle(
                color: blackColor,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 10),
            width: double.infinity,
            child: const Text("오늘도 좋은 하루 되세요!", style: TextStyle(fontSize: 20)),
          ),

          Container(
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.all(16),
            width: double.infinity,
            height: 180,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: hasReservation
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("내 예약", style: TextStyle(color: whiteColor)),

                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Text(
                          "제1열람실 (3층) A-12",
                          style: TextStyle(color: whiteColor),
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "09:00 - 13:00",
                              style: TextStyle(color: whiteColor),
                            ),
                            Text("남은시간", style: TextStyle(color: whiteColor)),
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        alignment: Alignment.centerRight,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Container(
                              alignment: Alignment.center,
                              width: 70,
                              height: 25,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.2),
                              ),
                              child: Text(
                                "02:15:30",
                                style: TextStyle(color: whiteColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.event_busy_outlined,
                          color: whiteColor,
                          size: 42,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "현재 예약이 없습니다.",
                          style: TextStyle(
                            color: whiteColor,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "지금 원하는 공간을 예약해보세요!",
                          style: TextStyle(
                            color: whiteColor.withOpacity(0.8),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
          ),

          const SizedBox(height: 20),

          Container(
            margin: const EdgeInsets.only(top: 20),
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
                Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "실시간 혼잡도",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "제1열람실 (3층)",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
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

                SizedBox(
                  height: 100,
                  child: LineChart(
                    LineChartData(
                      gridData: const FlGridData(show: false),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            interval: 1,
                            getTitlesWidget: (value, meta) {
                              switch (value.toInt()) {
                                case 0:
                                  return const Text(
                                    "08시",
                                    style: TextStyle(fontSize: 12),
                                  );
                                case 1:
                                  return const Text(
                                    "09시",
                                    style: TextStyle(fontSize: 12),
                                  );
                                case 2:
                                  return const Text(
                                    "12시",
                                    style: TextStyle(fontSize: 12),
                                  );
                                case 3:
                                  return const Text(
                                    "15시",
                                    style: TextStyle(fontSize: 12),
                                  );
                                case 4:
                                  return const Text(
                                    "18시",
                                    style: TextStyle(fontSize: 12),
                                  );
                                case 5:
                                  return const Text(
                                    "21시",
                                    style: TextStyle(fontSize: 12),
                                  );
                                default:
                                  return const SizedBox.shrink();
                              }
                            },
                          ),
                        ),
                        leftTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: const [
                            FlSpot(0, 1),
                            FlSpot(1, 3),
                            FlSpot(2, 2),
                            FlSpot(3, 4),
                            FlSpot(4, 3),
                            FlSpot(5, 2),
                          ],
                          isCurved: true,
                          barWidth: 3,
                          color: primaryColor,
                          dotData: const FlDotData(show: true),
                        ),
                      ],
                    ),
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

class MainButton extends StatelessWidget {
  final String title;
  final IconData icon;

  const MainButton({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: prupleColor),
          const SizedBox(height: 5),
          Text(
            title,
            style: TextStyle(
              color: blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
