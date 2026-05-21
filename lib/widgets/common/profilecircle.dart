import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/providers/auth_provider.dart';

class ProFileCircle extends StatelessWidget {
  const ProFileCircle({super.key});

  String getProfileImageUrl(String rawUrl) {
    if (rawUrl.isEmpty) return '';

    if (rawUrl.startsWith('http://') || rawUrl.startsWith('https://')) {
      return rawUrl;
    }

    if (rawUrl.startsWith('/')) {
      return 'http://sitdown.bond$rawUrl';
    }

    return 'http://sitdown.bond/$rawUrl';
  }

  @override
  Widget build(BuildContext context) {
    final myInfo = context.watch<AuthProvider>().myInfo;

    final rawProfileImageUrl = myInfo?['profileImageUrl']?.toString() ?? '';

    final profileImageUrl = getProfileImageUrl(rawProfileImageUrl);

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
                width: 54,
                height: 54,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  debugPrint('이미지 로드 실패: $error');
                  debugPrint('이미지 URL: $profileImageUrl');

                  return Icon(
                    Icons.person_outline,
                    color: primaryColor,
                    size: 40,
                  );
                },
              )
            : Icon(Icons.person_outline, color: primaryColor, size: 40),
      ),
    );
  }
}
