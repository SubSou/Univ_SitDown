import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitdown/api/stat_api.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/providers/auth_provider.dart';
import 'package:sitdown/widgets/mystats/my_stats_header.dart';
import 'package:sitdown/widgets/mystats/my_stats_bottom.dart';

class MyStatsPage extends StatefulWidget {
  const MyStatsPage({Key? key}) : super(key: key);

  @override
  State<MyStatsPage> createState() => _MyStatsPageState();
}

class _MyStatsPageState extends State<MyStatsPage> {
  bool isLoading = false;

  DateTime fromDate = DateTime.now().subtract(const Duration(days: 6));
  DateTime toDate = DateTime.now();

  Map<String, dynamic>? statsData;
  List<Map<String, dynamic>> usageList = [];

  @override
  void initState() {
    super.initState();
    loadStats();
  }

  Future<void> loadStats() async {
    setState(() {
      isLoading = true;
    });

    try {
      final accessToken = context.read<AuthProvider>().accessToken;

      if (accessToken == null || accessToken.isEmpty) {
        setState(() {
          isLoading = false;
        });
        return;
      }

      final response = await StatApi.getMyStats(
        accessToken: accessToken,
        from: formatDate(fromDate),
        to: formatDate(toDate),
      );

      print(response);

      final topSpaces = List<Map<String, dynamic>>.from(
        response["topSpaces"] ?? [],
      );

      setState(() {
        statsData = response;

        usageList = topSpaces.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;

          return {
            "rank": index + 1,
            "name": item["spaceName"] ?? "",
            "time": minutesToText(item["minutes"] ?? 0),
          };
        }).toList();

        isLoading = false;
      });
    } catch (e) {
      print("내 이용 통계 조회 실패: $e");

      setState(() {
        statsData = null;
        usageList = [];
        isLoading = false;
      });
    }
  }

  Future<void> selectFromDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: fromDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (picked == null) return;

    setState(() {
      fromDate = picked;

      if (fromDate.isAfter(toDate)) {
        toDate = fromDate;
      }
    });

    loadStats();
  }

  Future<void> selectToDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: toDate,
      firstDate: fromDate,
      lastDate: DateTime.now(),
    );

    if (picked == null) return;

    setState(() {
      toDate = picked;
    });

    loadStats();
  }

  String formatDate(DateTime date) {
    final year = date.year.toString();
    final month = date.month.toString().padLeft(2, "0");
    final day = date.day.toString().padLeft(2, "0");

    return "$year-$month-$day";
  }

  String minutesToText(int minutes) {
    final hour = minutes ~/ 60;
    final minute = minutes % 60;

    if (hour == 0) return "$minute분";
    if (minute == 0) return "$hour시간";
    return "$hour시간 $minute분";
  }

  @override
  Widget build(BuildContext context) {
    final totalMinutes = statsData?["totalMinutes"] ?? 0;
    final comparedMinutes = statsData?["comparedToPreviousMinutes"] ?? 0;

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              MyStatsHeader(
                fromDateText: formatDate(fromDate),
                toDateText: formatDate(toDate),
                totalTimeText: minutesToText(totalMinutes),
                comparedTimeText: minutesToText(comparedMinutes.abs()),
                comparedMinutes: comparedMinutes,
                onFromTap: selectFromDate,
                onToTap: selectToDate,
              ),
              isLoading
                  ? const Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: CircularProgressIndicator(),
                    )
                  : MyStatsBottom(usageList: usageList),
            ],
          ),
        ),
      ),
    );
  }
}
