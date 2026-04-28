import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/widgets/myinfo/my_info_body.dart';
import 'package:sitdown/widgets/myinfo/my_info_header.dart';

class MyInfoPage extends StatefulWidget {
  const MyInfoPage({Key? key}) : super(key: key);

  @override
  State<MyInfoPage> createState() => _MyInfoPageState();
}

class _MyInfoPageState extends State<MyInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [MyInfoHeader(), MyInfoBody()],
          ),
        ),
      ),
    );
  }
}
