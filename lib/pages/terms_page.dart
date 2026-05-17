import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SimpleInfoPage(title: "이용약관");
  }
}

class SimpleInfoPage extends StatelessWidget {
  final String title;

  const SimpleInfoPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        foregroundColor: Colors.black,
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Text("$title 내용이 들어갑니다."),
      ),
    );
  }
}
