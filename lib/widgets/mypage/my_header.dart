import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/providers/auth_provider.dart';
import 'package:sitdown/widgets/common/profilecircle.dart';

class MyHeader extends StatelessWidget {
  final String? imageUrl;

  const MyHeader({super.key, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final myInfo = context.watch<AuthProvider>().myInfo;

    final name = myInfo?['name']?.toString() ?? '사용자';
    final email = myInfo?['email']?.toString() ?? '이메일 없음';

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            /// 🔵 프로필 이미지
            ProFileCircle(),

            const SizedBox(width: 12),

            /// 🔵 사용자 정보
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  email,
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),

        const SizedBox(height: 12),

        /// 🔵 구분선
        Container(width: double.infinity, height: 2, color: greyColor),
      ],
    );
  }
}
