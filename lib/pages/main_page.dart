import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitdown/api/rsv_api.dart';
import 'package:sitdown/api/user_api.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/pages/home_page.dart';
import 'package:sitdown/pages/my_page.dart';
import 'package:sitdown/pages/notification_page.dart';
import 'package:sitdown/pages/reservation_page.dart';
import 'package:sitdown/pages/search_page.dart';
import 'package:sitdown/providers/auth_provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMyInfo();
    });
  }

  Widget getCurrentPage() {
    switch (currentIndex) {
      case 0:
        return const HomePage();
      case 1:
        return const SearchPage();
      case 2:
        return const ReservationPage();
      case 3:
        return const NotificationPage();
      case 4:
        return const MyPage();
      default:
        return const HomePage();
    }
  }

  Future<void> getMyInfo() async {
    final accessToken = context.read<AuthProvider>().accessToken ?? '';

    if (accessToken.isEmpty) {
      print("토큰이 없습니다.");
      return;
    }

    /// 🔵 내 정보 조회
    try {
      final data = await UserApi.getMyInfo(accessToken: accessToken);

      context.read<AuthProvider>().setMyInfo(data);
    } catch (e) {
      print("내 정보 조회 에러 : $e");
    }

    /// 🔵 내 예약 조회
    try {
      final data = await RsvApi.getMyReservations(
        accessToken: accessToken,
        status: 'ACTIVE',
        page: 0,
        size: 20,
      );

      final reservationList = data['content'] ?? [];

      context.read<AuthProvider>().setReservationList(reservationList);
    } catch (e) {
      print("예약 목록 조회 에러 : $e");
    }
  }

  void onTapBottomItem(int index) {
    setState(() {
      currentIndex = index;
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMyInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getCurrentPage(),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: whiteColor,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: blackColor,
        currentIndex: currentIndex,
        onTap: onTapBottomItem,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: '홈',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            activeIcon: Icon(Icons.search),
            label: '검색',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            activeIcon: Icon(Icons.calendar_month),
            label: '예약 내역',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications),
            label: '알림',
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: '마이',
          ),
        ],
      ),
    );
  }
}
