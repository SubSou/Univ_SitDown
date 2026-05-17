import 'package:flutter/material.dart';
import 'package:sitdown/util/navigation_util.dart';
import 'package:sitdown/widgets/common/CategoryList.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';

class NoticeHeader extends StatelessWidget {
  final List<Map<String, dynamic>> categoryList;
  final int selectedIndex;
  final Function(int index) onTapCategory;

  const NoticeHeader({
    super.key,
    required this.categoryList,
    required this.selectedIndex,
    required this.onTapCategory,
  });

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
          margin: const EdgeInsets.only(top: 10),
          child: CategoryList(
            categoryList: categoryList,
            selectedIndex: selectedIndex,
            onTap: onTapCategory,
          ),
        ),
      ],
    );
  }
}
