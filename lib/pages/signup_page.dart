import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/pages/signup_complete_page.dart';
import 'package:sitdown/api/auth_api.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isObscure1 = true;
  bool isObscure2 = true;
  bool isPasswordMismatch = false;
  bool isLoading = false;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool get isFormValid {
    return emailController.text.trim().isNotEmpty &&
        nameController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty &&
        confirmPasswordController.text.trim().isNotEmpty;
  }

  @override
  void initState() {
    super.initState();

    emailController.addListener(updateButtonState);
    nameController.addListener(updateButtonState);
    passwordController.addListener(updateButtonState);
    confirmPasswordController.addListener(updateButtonState);
  }

  void updateButtonState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    emailController.removeListener(updateButtonState);
    nameController.removeListener(updateButtonState);
    passwordController.removeListener(updateButtonState);
    confirmPasswordController.removeListener(updateButtonState);

    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  InputDecoration inputStyle(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Color(0xFFE5E7EB)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: primaryColor, width: 1.5),
      ),
    );
  }

  Future<void> signup() async {
    try {
      setState(() {
        isLoading = true;
      });

      final data = await AuthApi.signup(
        email: emailController.text.trim(),
        name: nameController.text.trim(),
        password: passwordController.text.trim(),
      );

      debugPrint('회원가입 응답값: $data');

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const SignupCompletePage()),
      );
    } catch (e) {
      debugPrint("회원가입 API 호출 에러: $e");

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceAll('Exception: ', ''))),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void handleSignup() async {
    if (emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("이메일을 입력해주세요.")));
      return;
    }

    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("이름을 입력해주세요.")));
      return;
    }

    if (passwordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("비밀번호를 입력해주세요.")));
      return;
    }

    if (confirmPasswordController.text.trim().isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("비밀번호 확인을 입력해주세요.")));
      return;
    }

    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      setState(() {
        isPasswordMismatch = true;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("비밀번호가 일치하지 않습니다.")));

      return;
    }

    setState(() {
      isPasswordMismatch = false;
    });

    await signup();
  }

  @override
  Widget build(BuildContext context) {
    final bool canSubmit = isFormValid && !isLoading;

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),

              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.chevron_left, size: 28),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "회원가입",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 40),

              const Text("이메일", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: inputStyle("이메일을 입력하세요"),
              ),

              const SizedBox(height: 12),

              const Text("이름", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: nameController,
                decoration: inputStyle("이름을 입력하세요"),
              ),

              const SizedBox(height: 20),

              const Text("비밀번호", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              TextField(
                controller: passwordController,
                obscureText: isObscure1,
                decoration: inputStyle("비밀번호를 입력하세요").copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      isObscure1 ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        isObscure1 = !isObscure1;
                      });
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Text(
                "비밀번호 확인",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: confirmPasswordController,
                obscureText: isObscure2,
                decoration: inputStyle("비밀번호를 다시 입력하세요").copyWith(
                  suffixIcon: IconButton(
                    icon: Icon(
                      isObscure2 ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        isObscure2 = !isObscure2;
                      });
                    },
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

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: canSubmit ? handleSignup : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: whiteColor,
                    disabledBackgroundColor: primaryColor.withOpacity(0.5),
                    disabledForegroundColor: whiteColor.withOpacity(0.7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: whiteColor,
                          ),
                        )
                      : const Text(
                          "회원가입",
                          style: TextStyle(fontWeight: FontWeight.bold),
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
