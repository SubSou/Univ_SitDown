import 'package:flutter/material.dart';
import 'package:sitdown/pages/home_page.dart';
import 'package:sitdown/pages/search_page.dart';
import 'package:sitdown/pages/reservation_page.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/pages/notification_page.dart';
import 'package:sitdown/pages/my_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MainPage> {
  int currentIndex = 0;

  void onTapBottomItem(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  final List<Widget> NavPages = [
    const HomePage(),
    const SearchPage(),
    const ReservationPage(),
    const NotificationPage(),
    const MyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NavPages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: blackColor,
        currentIndex: currentIndex,
        onTap: onTapBottomItem,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            activeIcon: Icon(Icons.search),
            label: "검색",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            activeIcon: Icon(Icons.calendar_month_outlined),
            label: "예약 내역",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            activeIcon: Icon(Icons.notifications_outlined),
            label: "알림",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            activeIcon: Icon(Icons.person_outline),
            label: "마이",
          ),
        ],
      ),
    );
  }
}
