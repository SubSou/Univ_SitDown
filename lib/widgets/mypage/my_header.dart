import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';

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
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.08),
              ),
              child: ClipOval(
                child: (imageUrl != null && imageUrl!.isNotEmpty)
                    ? Image.network(
                        imageUrl!,
                        fit: BoxFit.cover,

                        // 🔥 로딩 중
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(strokeWidth: 2),
                          );
                        },

                        // 🔥 실패 시 기본 아이콘
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.person_outline,
                            color: primaryColor,
                            size: 40,
                          );
                        },
                      )
                    : Icon(Icons.person_outline, color: primaryColor, size: 40),
              ),
            ),

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
