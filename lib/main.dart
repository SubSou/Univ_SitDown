import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});


  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLogin
          ? MainPage()
          : LoginPage(
              onLoginSuccess: () {
                setState(() {
                  isLogin = true;
                });
              },
            ),
    );
  }
}
