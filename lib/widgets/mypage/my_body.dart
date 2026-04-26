import 'package:flutter/material.dart';
import 'package:sitdown/pages/SettingPage.dart';
import 'package:sitdown/pages/appInfo_page.dart';
import 'package:sitdown/pages/my_favorite_page.dart';
import 'package:sitdown/pages/my_info_page.dart';
import 'package:sitdown/pages/my_reservation_page.dart';
import 'package:sitdown/pages/my_stats_page.dart';
import 'package:sitdown/pages/notice_page.dart';

const MyGreyColor800 = Color(0xFF424242);

class MyBody extends StatefulWidget {
  const MyBody({Key? key}) : super(key: key);

  @override
  State<MyBody> createState() => _MyBodyState();
}

class _MyBodyState extends State<MyBody> {
  List<Map<String, dynamic>> myMenuList = [
    {"title": "내 정보", "icon": Icons.person_outline, "page": const MyInfoPage()},

    {
      "title": "내 이용 통계",
      "icon": Icons.bar_chart_outlined,
      "page": const MyStatsPage(),
    },
    {
      "title": "내 즐겨찾기", // ✅ 추가
      "icon": Icons.star_border,
      "page": const MyFavoritePage(),
    },
    {
      "title": "공지사항",
      "icon": Icons.campaign_outlined,
      "page": const NoticePage(),
    },
    {
      "title": "설정",
      "icon": Icons.settings_outlined,
      "page": const SettingPage(),
    },
    {"title": "로그아웃", "icon": Icons.logout},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: myMenuList.map((item) {
        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // 🔥 로그아웃 분기
              if (item["title"] == "로그아웃") {
                print("로그아웃 처리");
                return;
              }

              // 🔥 페이지 이동 (push)
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => item["page"]),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 14),
              child: Row(
                children: [
                  Icon(item["icon"], size: 22),
                  const SizedBox(width: 16),

                  Expanded(
                    child: Text(
                      item["title"],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: MyGreyColor800,
                      ),
                    ),
                  ),

                  const Icon(Icons.chevron_right, color: MyGreyColor800),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
