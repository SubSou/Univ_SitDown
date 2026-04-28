import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';

class ProFileCircle extends StatelessWidget {
  final String? imageUrl; // 🔥 네트워크 이미지

  const ProFileCircle({
    super.key,
    this.imageUrl, // 없어도 됨
  });
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
