import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/util/navigation_util.dart';
import 'package:sitdown/widgets/common/CategoryList.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              chevron_left(
                onTap: () {
                  NavUtil.pop(context);
                },
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: CategoryList(
                  categoryList: categoryList,
                  selectedIndex: selectedIndex,
                  onTap: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
              ),
              SizedBox(height: 24),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.chevron_left),
                    Container(child: Text("2026.04.28 ~ 2026.04.29")),
                    Icon(Icons.chevron_right),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
