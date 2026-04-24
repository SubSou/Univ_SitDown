import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';

class SearchHeader extends StatefulWidget {
  const SearchHeader({super.key});

  @override
  State<SearchHeader> createState() => _SearchHeader();
}

class _SearchHeader extends State<SearchHeader> {
  final TextEditingController controller = TextEditingController();
  int selectedIndex = 0;
  List<Map<String, dynamic>> categoryList = [
    {"id": 0, "name": "전체"},
    {"id": 1, "name": "열람실"},
    {"id": 2, "name": "스터디룸"},
    {"id": 3, "name": "PC실"},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color(0xFFE5E5E5)),
            boxShadow: [
              BoxShadow(
                color: blackColor.withOpacity(0.03),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(child: Icon(Icons.search)),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (value) {
                      if (value.isNotEmpty) {
                        print("검색 : $value");
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "공간, 강의실 검색",
                      enabledBorder: InputBorder.none,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      isCollapsed: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Row(
            children: List.generate(categoryList.length, (index) {
              bool isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Container(
                  margin: EdgeInsets.only(right: 8),
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isSelected ? primaryColor : Colors.grey[200], // 배경색
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    categoryList[index]["name"],
                    style: TextStyle(
                      color: isSelected ? whiteColor : blackColor, // 글자색
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
