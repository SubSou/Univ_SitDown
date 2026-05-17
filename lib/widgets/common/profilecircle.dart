import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/providers/auth_provider.dart';

class ProFileCircle extends StatelessWidget {
  const ProFileCircle({super.key});

  @override
  Widget build(BuildContext context) {
    final myInfo = context.watch<AuthProvider>().myInfo;

    final profileImageUrl = myInfo?['profileImageUrl']?.toString() ?? '';

    final hasImage = profileImageUrl.isNotEmpty;

    return Container(
      width: 54,
      height: 54,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: primaryColor.withOpacity(0.08),
      ),
      child: ClipOval(
        child: hasImage
            ? Image.network(
                profileImageUrl,
                fit: BoxFit.cover,

                /// 🔵 로딩 중
                loadingBuilder: (context, child, progress) {
                  if (progress == null) {
                    return child;
                  }

                  return const Center(
                    child: CircularProgressIndicator(strokeWidth: 2),
                  );
                },

                /// 🔵 이미지 실패 시 기본 아이콘
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.person_outline,
                    color: primaryColor,
                    size: 40,
                  );
                },
              )
            /// 🔵 이미지 없을 때 기본 프로필
            : Icon(Icons.person_outline, color: primaryColor, size: 40),
      ),
    );
  }
}
