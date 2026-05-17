import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitdown/pages/login_intro_page.dart';
import 'package:sitdown/pages/main_page.dart';
import 'package:sitdown/providers/auth_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => AuthProvider(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: authProvider.isLogin ? const MainPage() : const LoginIntroPage(),
    );
  }
}
