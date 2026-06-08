import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/widgets/myfavoritepage/my_favorite_body_item.dart';

class MyFavoriteBody extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteSpaceList;

  const MyFavoriteBody({Key? key, required this.favoriteSpaceList})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favoriteSpaceList.isEmpty) {
      return Center(
        child: Text(
          '즐겨찾기한 공간이 없습니다.',
          style: TextStyle(color: subTextColor, fontSize: 15),
        ),
      );
    }

    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Text(
              "총 ${favoriteSpaceList.length}개 공간",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            ...favoriteSpaceList.map((item) {
              return MyFavoriteBodyItem(item: item);
            }).toList(),
          ],
        ),
      ),
    );
  }
}
