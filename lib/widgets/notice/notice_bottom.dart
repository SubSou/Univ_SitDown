import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';

class NoticeBottom extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Function(int page) onTapPage;

  const NoticeBottom({
    super.key,
    required this.currentPage,
    required this.totalPages,
    required this.onTapPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalPages, (index) {
          final bool isSelected = currentPage == index;

          return GestureDetector(
            onTap: () {
              onTapPage(index);
            },
            child: Container(
              width: 30,
              height: 30,
              margin: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: isSelected ? primaryColor : Colors.grey.shade200,
              ),
              child: Center(
                child: Text(
                  "${index + 1}",
                  style: TextStyle(
                    color: isSelected ? whiteColor : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
