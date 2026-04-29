import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/widgets/mystats/my_stats_header.dart';
import 'package:sitdown/widgets/mystats/monthly_chart.dart';
import 'package:sitdown/widgets/mystats/weekly_chart.dart';
import 'package:sitdown/widgets/mystats/yearly_chart.dart';
import 'package:sitdown/widgets/mystats/my_stats_bottom.dart';

class MyStatsPage extends StatefulWidget {
  const MyStatsPage({Key? key}) : super(key: key);

  @override
  State<MyStatsPage> createState() => _MyStatsPageState();
}

class _MyStatsPageState extends State<MyStatsPage> {
  int selectedIndex = 0;
  List<Map<String, dynamic>> categoryList = [
    {"id": 0, "name": "주간"},
    {"id": 1, "name": "월간"},
    {"id": 2, "name": "연간"},
  ];

  List<Map<String, dynamic>> usageList = [
    {"rank": 1, "name": "제1열람실", "floor": "3층", "time": "8시간 30분"},
    {"rank": 2, "name": "중앙도서관", "floor": "4층", "time": "3시간 20분"},
    {"rank": 3, "name": "스터디룸 A", "floor": "2층", "time": "40분"},
  ];

  void onChanged(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              MyStatsHeader(
                selectedIndex: selectedIndex,
                onChanged: onChanged,
                categoryList: categoryList,
              ),
              buildChart(),
              MyStatsBottom(usageList: usageList),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildChart() {
    switch (selectedIndex) {
      case 0:
        return WeeklyChart();
      case 1:
        return MonthlyChart();
      case 2:
        return YearlyChart();
      default:
        return WeeklyChart();
    }
  }
}
