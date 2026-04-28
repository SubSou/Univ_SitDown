import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/widgets/common/profilecircle.dart';

class MyHeader extends StatelessWidget {
  final String? imageUrl; // 🔥 네트워크 이미지

  const MyHeader({
    super.key,
    this.imageUrl, // 없어도 됨
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min, // 🔥 중앙 정렬 핵심
      children: [
        Row(
          children: [
            // 🔥 프로필 원
            ProFileCircle(),

            const SizedBox(width: 12),

            // 🔥 텍스트 영역
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "김한생",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "student1234",
                  style: TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 12),

        // 🔥 구분선
        Container(width: double.infinity, height: 2, color: greyColor),
      ],
    );
  }
}
