import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitdown/api/user_api.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/providers/auth_provider.dart';
import 'package:sitdown/widgets/myfavoritepage/my_favorite_body.dart';
import 'package:sitdown/widgets/myfavoritepage/my_favorite_header.dart';

class MyFavoritePage extends StatefulWidget {
  const MyFavoritePage({Key? key}) : super(key: key);

  @override
  State<MyFavoritePage> createState() => _MyFavoritePageState();
}

class _MyFavoritePageState extends State<MyFavoritePage> {
  List<Map<String, dynamic>> favoriteSpaceList = [];

  bool isLoading = true;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    fetchFavorites();
  }

  Future<void> fetchFavorites() async {
    try {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final token = authProvider.accessToken;

      if (token == null || token.isEmpty) {
        setState(() {
          isLoading = false;
          errorMessage = '로그인이 필요합니다.';
        });
        return;
      }

      final data = await UserApi.getMyFavorites(
        accessToken: token,
        page: 0,
        size: 20,
      );

      final content = data['content'];

      setState(() {
        favoriteSpaceList = content is List
            ? content.map((e) => Map<String, dynamic>.from(e)).toList()
            : [];
        isLoading = false;
      });
    } catch (e) {
      debugPrint('즐겨찾기 조회 실패: $e');

      setState(() {
        isLoading = false;
        errorMessage = '즐겨찾기 목록을 불러오지 못했습니다.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const MyFavoriteHeader(),
              const SizedBox(height: 20),

              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : errorMessage != null
                    ? Center(
                        child: Text(
                          errorMessage!,
                          style: TextStyle(color: subTextColor),
                        ),
                      )
                    : MyFavoriteBody(favoriteSpaceList: favoriteSpaceList),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
