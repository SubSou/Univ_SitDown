import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';

class CategoryList extends StatelessWidget {
  final List<Map<String, dynamic>> categoryList;
  final int selectedIndex;
  final Function(int) onTap;

  const CategoryList({
    super.key,
    required this.categoryList,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(categoryList.length, (index) {
        bool isSelected = selectedIndex == index;

        return GestureDetector(
          onTap: () => onTap(index),
          child: Container(
            margin: EdgeInsets.only(right: 8),
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? primaryColor.withOpacity(0.1) : Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected
                    ? primaryColor.withOpacity(0.4)
                    : Colors.grey.shade300,
              ),
            ),
            child: Text(
              categoryList[index]["name"],
              style: TextStyle(
                color: isSelected ? primaryColor : Colors.grey.shade700,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }),
    );
  }
}
