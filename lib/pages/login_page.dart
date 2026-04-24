import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  final VoidCallback onLoginSuccess;

  const LoginPage({super.key, required this.onLoginSuccess});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(onPressed: onLoginSuccess, child: Text("로그인")),
      ),
    );
  }
}
