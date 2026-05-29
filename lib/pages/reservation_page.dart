import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitdown/api/rsv_api.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/providers/auth_provider.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';
import 'package:sitdown/widgets/reservationpage/reservation_body.dart';
import 'package:sitdown/widgets/reservationpage/reservation_header.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPage();
}

class _ReservationPage extends State<ReservationPage> {
  bool isLoading = true;
  String selectedStatus = 'ACTIVE';

  List<Map<String, dynamic>> reservationList = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getMyReservations();
    });
  }

  Future<void> getMyReservations() async {
    final accessToken = context.read<AuthProvider>().accessToken;

    if (accessToken == null || accessToken.isEmpty) {
      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('로그인이 필요합니다.')));
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      final response = await RsvApi.getMyReservations(
        accessToken: accessToken,
        status: selectedStatus,
        page: 0,
        size: 20,
      );

      setState(() {
        reservationList = List<Map<String, dynamic>>.from(
          response['content'] ?? [],
        );
        isLoading = false;
      });
    } catch (e) {
      print('내 예약 목록 조회 에러: $e');

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('예약 목록을 불러오지 못했습니다.')));
    }
  }

  void changeStatus(String status) {
    setState(() {
      selectedStatus = status;
    });

    getMyReservations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              chevron_left(
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              const SizedBox(height: 20),

              ReservationHeader(
                selectedStatus: selectedStatus,
                onChanged: changeStatus,
              ),

              Expanded(
                child: isLoading
                    ? const Center(
                        child: CircularProgressIndicator(color: primaryColor),
                      )
                    : ReservationBody(
                        reservationList: reservationList,
                        onRefresh: getMyReservations,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
