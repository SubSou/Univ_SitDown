import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitdown/api/notice_api.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/providers/auth_provider.dart';
import 'package:sitdown/widgets/notice/notice_body.dart';
import 'package:sitdown/widgets/notice/notice_bottom.dart';
import 'package:sitdown/widgets/notice/notice_header.dart';

class NoticePage extends StatefulWidget {
  const NoticePage({Key? key}) : super(key: key);

  @override
  State<NoticePage> createState() => _NoticePageState();
}

class _NoticePageState extends State<NoticePage> {
  bool isLoading = true;

  int selectedIndex = 0;
  int page = 0;
  int size = 20;
  int totalPages = 1;

  List<Map<String, dynamic>> noticeList = [];

  final List<Map<String, dynamic>> categoryList = [
    {"id": 0, "name": "전체", "value": "ALL"},
    {"id": 1, "name": "안내", "value": "INFO"},
    {"id": 2, "name": "점검", "value": "MAINTENANCE"},
    {"id": 3, "name": "이벤트", "value": "EVENT"},
  ];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getNotices();
    });
  }

  Future<void> getNotices({int newPage = 0}) async {
    final accessToken = context.read<AuthProvider>().accessToken;

    if (accessToken == null || accessToken.isEmpty) {
      setState(() {
        isLoading = false;
        noticeList = [];
      });
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final category = categoryList[selectedIndex]["value"];

      final response = await NoticeApi.getNotices(
        accessToken: accessToken,
        category: category,
        page: newPage,
        size: size,
      );

      final rawList = response["content"] ?? [];

      List<Map<String, dynamic>> newList = [];

      if (rawList is List) {
        newList = rawList
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
      }

      print(mounted);

      if (!mounted) return;

      setState(() {
        noticeList = newList;
        page = response["page"] ?? newPage;
        totalPages = response["totalPages"] ?? 1;
        isLoading = false;
      });

      print(page);
      print(totalPages);
    } catch (e) {
      print("공지사항 조회 에러: $e");

      if (!mounted) return;

      setState(() {
        isLoading = false;
        noticeList = [];
      });
    }
  }

  void onChangeCategory(int index) {
    setState(() {
      selectedIndex = index;
      page = 0;
    });

    getNotices(newPage: 0);
  }

  void onChangePage(int pageIndex) {
    getNotices(newPage: pageIndex);
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
              NoticeHeader(
                categoryList: categoryList,
                selectedIndex: selectedIndex,
                onTapCategory: onChangeCategory,
              ),

              const SizedBox(height: 20),

              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: primaryColor),
                      )
                    : NoticeBody(noticeList: noticeList),
              ),

              NoticeBottom(
                currentPage: page,
                totalPages: totalPages,
                onTapPage: onChangePage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
