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
    {"id": 0, "name": "전체"},
    {"id": 1, "name": "열람실"},
    {"id": 2, "name": "스터디룸"},
    {"id": 3, "name": "PC실"},
  ];

  void submitSearch() {
    final keyword = controller.text.trim();

    final selectedName = categoryList[selectedIndex]["name"];

    widget.onSearch(
      category: selectedIndex == 0 ? null : selectedName,
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
      ],
    );
  }
}
