import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/widgets/common/CategoryList.dart';

class SearchHeader extends StatefulWidget {
  final void Function({String? category, String? searchKeyword}) onSearch;

  const SearchHeader({super.key, required this.onSearch});

  @override
  State<SearchHeader> createState() => _SearchHeader();
}

class _SearchHeader extends State<SearchHeader> {
  final TextEditingController controller = TextEditingController();

  int selectedIndex = 0;

  final List<Map<String, dynamic>> categoryList = [
    {"id": 0, "name": "전체", "value": null},
    {"id": 1, "name": "열람실", "value": "READING_ROOM"},
    {"id": 2, "name": "스터디룸", "value": "STUDY_ROOM"},
    {"id": 3, "name": "PC실", "value": "PC_ROOM"},
    {"id": 4, "name": "강의실", "value": "LECTURE_ROOM"},
  ];

  void submitSearch() {
    final keyword = controller.text.trim();

    final selectedValue = categoryList[selectedIndex]["value"];

    widget.onSearch(
      category: selectedValue,
      searchKeyword: keyword.isEmpty ? null : keyword,
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          height: 50,
          width: double.infinity,
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
          child: Row(
            children: [
              const Icon(Icons.search),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(left: 10),
                  child: TextField(
                    controller: controller,
                    onSubmitted: (_) {
                      submitSearch();
                    },
                    decoration: const InputDecoration(
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
          margin: const EdgeInsets.only(top: 10),
          width: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: CategoryList(
              categoryList: categoryList,
              selectedIndex: selectedIndex,
              onTap: (index) {
                setState(() {
                  selectedIndex = index;
                });

                submitSearch();
              },
            ),
          ),
        ),
      ],
    );
  }
}
