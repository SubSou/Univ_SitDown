import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/providers/auth_provider.dart';
import 'package:sitdown/widgets/homepage/home_header.dart';
import 'package:sitdown/widgets/homepage/home_body.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadHomeData();
  }

  Future<void> loadHomeData() async {
    final authProvider = context.read<AuthProvider>();

    await authProvider.fetchMyInfo();
    await authProvider.fetchMyReservations(status: 'ACTIVE');

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(children: const [HomeHeader(), HomeBody()]),
                ),
              ),
      ),
    );
  }
}
