import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/pages/login_page.dart';

class SignupCompletePage extends StatelessWidget {
  const SignupCompletePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false, // 🔥 뒤로가기 막기
      child: Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                const Spacer(),

                /// 🔵 큰 원 + 체크 아이콘
                Container(
                  width: 100, // 🔥 기존보다 크게
                  height: 100,
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: whiteColor,
                    size: 60, // 🔥 아이콘 크게
                  ),
                ),

                const SizedBox(height: 28),

                /// 🔵 타이틀
                const Text(
                  "회원가입 완료!",
                  style: TextStyle(
                    fontSize: 22, // 🔥 살짝 키움
                    fontWeight: FontWeight.bold,
                    color: blackColor,
                  ),
                ),

                const SizedBox(height: 12),

                /// 🔵 설명
                const Text(
                  "UNIV SITDOWN을 이용해주셔서\n감사합니다.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF8A8F9E),
                    height: 1.5,
                  ),
                ),

                const Spacer(),

                /// 🔵 시작하기 버튼
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      /// 🔥 로그인 페이지로 이동 + 스택 초기화
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginPage()),
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    child: const Text(
                      "시작하기",
                      style: TextStyle(
                        color: whiteColor,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
