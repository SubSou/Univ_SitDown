import 'package:flutter/material.dart';
import 'package:sitdown/util/navigation_util.dart';
import 'package:sitdown/widgets/common/CategoryList.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';

class MyStatsHeader extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onChanged;
  final List<Map<String, dynamic>> categoryList;

  const MyStatsHeader({
    Key? key,
    required this.selectedIndex,
    required this.onChanged,
    required this.categoryList,
  }) : super(key: key);

  @override
  State<MyStatsHeader> createState() => _MyStatsHeaderState();
}

class _MyStatsHeaderState extends State<MyStatsHeader> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
            categoryList: widget.categoryList,
            selectedIndex: widget.selectedIndex,
            onTap: (index) {
              setState(() {
                widget.onChanged(index);
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
    );
  }
}
