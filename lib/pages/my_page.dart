import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/providers/auth_provider.dart';
import 'package:sitdown/widgets/mypage/my_header.dart';
import 'package:sitdown/widgets/mypage/my_body.dart';

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadMyPageData();
  }

  Future<void> loadMyPageData() async {
    await context.read<AuthProvider>().fetchMyInfo();

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final myInfo = context.watch<AuthProvider>().myInfo;
    final profileImageUrl =
        myInfo?['profileImageUrl']?.toString() ?? 'assets/images.test,jpg';

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    MyHeader(imageUrl: profileImageUrl),
                    const MyBody(),
                  ],
                ),
              ),
      ),
    );
  }
}
