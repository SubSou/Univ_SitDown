import 'package:flutter/material.dart';
import 'package:sitdown/util/navigation_util.dart';
import 'package:sitdown/widgets/common/CategoryList.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';

class MyStatsBottom extends StatefulWidget {
  final List<Map<String, dynamic>> usageList;

  const MyStatsBottom({Key? key, required this.usageList}) : super(key: key);

  @override
  State<MyStatsBottom> createState() => _MyStatsBottomState();
}

class _MyStatsBottomState extends State<MyStatsBottom> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 20, bottom: 20),
          alignment: Alignment.centerLeft,
          child: Text(
            "주로 이용하는 공간",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        ...widget.usageList.map((item) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,

                children: [
                  Container(
                    width: 22,
                    height: 22,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFF1F3F5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      "1",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF8A94A6),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Container(
                      height: 22,
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(left: 20),
                      child: Text(
                        "제 1열람실",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              Container(child: Text("data")),
            ],
          );
        }),
      ],
    );
  }
}
