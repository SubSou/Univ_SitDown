import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/pages/privacy_policy_page.dart';
import 'package:sitdown/pages/service_intro_page.dart';
import 'package:sitdown/pages/terms_page.dart';

class AppInfoBody extends StatelessWidget {
  const AppInfoBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 45),

            /// 🔵 로고
            Image.asset(
              "assets/images/small_icon_logo.png",
              width: 200,
              height: 200,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.high,
            ),

            const SizedBox(height: 10),

            /// 🔵 앱 이름
            const Text(
              "UNIV SITDOWN",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),

            /// 🔵 버전
            const Text(
              "1.0.0",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),

            /// 🔹 메뉴
            buildMenuItem(
              context,
              title: "서비스 소개",
              page: const ServiceIntroPage(),
            ),
            buildMenuItem(context, title: "이용약관", page: const TermsPage()),
            buildMenuItem(
              context,
              title: "개인정보 처리방침",
              page: const PrivacyPolicyPage(),
            ),

            const SizedBox(height: 60),

            /// 🔵 하단 문구
            const Text(
              "© 2026 UNIV SITDOWN",
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 6),
            const Text(
              "All rights reserved.",
              style: TextStyle(fontSize: 13, color: Colors.grey),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  /// 🔧 공통 메뉴 아이템
  Widget buildMenuItem(
    BuildContext context, {
    required String title,
    required Widget page,
  }) {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE5E7EB))),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF6B7280),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, size: 22, color: Color(0xFF9CA3AF)),
          ],
        ),
      ),
    );
  }
}
