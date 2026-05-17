import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';

class FindPasswordPage extends StatefulWidget {
  const FindPasswordPage({super.key});

  @override
  State<FindPasswordPage> createState() => _FindPasswordPageState();
}

class _FindPasswordPageState extends State<FindPasswordPage> {
  final emailController = TextEditingController();
  final codeController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isCodeSent = false;
  bool isEmailVerified = false;
  bool isObscure1 = true;
  bool isObscure2 = true;
  bool isPasswordMismatch = false;

  @override
  void dispose() {
    emailController.dispose();
    codeController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  InputDecoration inputStyle(String hint, {Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFFB0B7C3), fontSize: 14),
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: primaryColor, width: 1.5),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }

  Widget label(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: blackColor,
      ),
    );
  }

  void sendCode() {
    setState(() {
      isCodeSent = true;
      isEmailVerified = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("인증번호가 전송되었습니다.")));
  }

  void verifyCode() {
    if (codeController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("인증번호를 입력해주세요.")));
      return;
    }

    setState(() {
      isEmailVerified = true;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("이메일 인증이 완료되었습니다.")));
  }

  void resetPassword() {
    if (!isEmailVerified) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("이메일 인증을 먼저 완료해주세요.")));
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      setState(() {
        isPasswordMismatch = true;
      });
      return;
    }

    setState(() {
      isPasswordMismatch = false;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("비밀번호가 변경되었습니다.")));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              IconButton(
                icon: const Icon(Icons.chevron_left, size: 30),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 12),

              const Text(
                "비밀번호 찾기",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: blackColor,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "가입한 이메일로 인증을 완료한 뒤\n새 비밀번호를 설정해주세요.",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF8A8F9E),
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 36),

              label("이메일"),
              const SizedBox(height: 8),

              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                enabled: !isEmailVerified,
                decoration: inputStyle("이메일을 입력하세요"),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: isEmailVerified ? null : sendCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    disabledBackgroundColor: const Color(0xFFE5E7EB),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    isCodeSent ? "인증번호 재전송" : "인증번호 전송",
                    style: const TextStyle(
                      color: whiteColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              if (isCodeSent) ...[
                const SizedBox(height: 24),

                label("인증번호"),
                const SizedBox(height: 8),

                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: codeController,
                        enabled: !isEmailVerified,
                        keyboardType: TextInputType.number,
                        decoration: inputStyle("인증번호 입력"),
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 92,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isEmailVerified ? null : verifyCode,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isEmailVerified
                              ? const Color(0xFFE5E7EB)
                              : primaryColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          isEmailVerified ? "완료" : "확인",
                          style: const TextStyle(
                            color: whiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              const SizedBox(height: 30),

              AnimatedOpacity(
                opacity: isEmailVerified ? 1 : 0.4,
                duration: const Duration(milliseconds: 200),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    label("새 비밀번호"),
                    const SizedBox(height: 8),

                    TextField(
                      controller: passwordController,
                      enabled: isEmailVerified,
                      obscureText: isObscure1,
                      decoration: inputStyle(
                        "새 비밀번호를 입력하세요",
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscure1
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: isEmailVerified
                              ? () {
                                  setState(() {
                                    isObscure1 = !isObscure1;
                                  });
                                }
                              : null,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    label("새 비밀번호 확인"),
                    const SizedBox(height: 8),

                    TextField(
                      controller: confirmPasswordController,
                      enabled: isEmailVerified,
                      obscureText: isObscure2,
                      decoration: inputStyle(
                        "새 비밀번호를 다시 입력하세요",
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscure2
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: isEmailVerified
                              ? () {
                                  setState(() {
                                    isObscure2 = !isObscure2;
                                  });
                                }
                              : null,
                        ),
                      ),
                    ),

                    if (isPasswordMismatch)
                      const Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text(
                          "비밀번호가 일치하지 않습니다",
                          style: TextStyle(color: Colors.red, fontSize: 12),
                        ),
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: isEmailVerified ? resetPassword : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    disabledBackgroundColor: const Color(0xFFE5E7EB),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    "비밀번호 변경",
                    style: TextStyle(
                      color: whiteColor,
                      fontSize: 15,
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
    );
  }
}
