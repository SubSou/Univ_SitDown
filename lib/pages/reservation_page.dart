import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitdown/api/rsv_api.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/providers/auth_provider.dart';
import 'package:sitdown/widgets/reservationpage/reservation_header.dart';
import 'package:sitdown/widgets/reservationpage/reservation_body.dart';

class ReservationPage extends StatefulWidget {
  const ReservationPage({super.key});

  @override
  State<ReservationPage> createState() => _ReservationPageState();
}

class _ReservationPageState extends State<ReservationPage> {
  bool isLoading = true;
  String? errorMessage;
  List<Map<String, dynamic>> reservationList = [];

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      getReservations();
    });
  }

  Future<void> getReservations() async {
    try {
      final authProvider = context.read<AuthProvider>();
      final accessToken = authProvider.accessToken;

      if (accessToken == null || accessToken.isEmpty) {
        setState(() {
          errorMessage = '로그인이 필요합니다.';
          isLoading = false;
        });
        return;
      }

      final result = await RsvApi.getMyReservations(
        accessToken: accessToken,
        status: 'ACTIVE',
        page: 0,
        size: 20,
      );

      final content = result['content'] as List<dynamic>;

      setState(() {
        reservationList = content.map((e) {
          final item = Map<String, dynamic>.from(e);

          return {
            "roomName": "${item["spaceName"]} (${item["spaceFloor"]}층)",
            "seat": item["seatLabel"] ?? "",
            "time":
                "${formatTime(item["startAt"])} ~ ${formatTime(item["endAt"])}",
            "status": item["status"] ?? "",
            "remainTime": formatRemainTime(item["remainingSeconds"]),
          };
        }).toList();

        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  String formatTime(dynamic value) {
    if (value == null) return '';

    final dateTime = DateTime.parse(value.toString());
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');

    return '$hour:$minute';
  }

  String formatRemainTime(dynamic seconds) {
    if (seconds == null) return '00:00:00';

    final duration = Duration(seconds: int.parse(seconds.toString()));

    final h = duration.inHours.toString().padLeft(2, '0');
    final m = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final s = duration.inSeconds.remainder(60).toString().padLeft(2, '0');

    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            const ReservationHeader(),

            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : errorMessage != null
                  ? Center(child: Text(errorMessage!))
                  : reservationList.isEmpty
                  ? const Center(child: Text('예약 내역이 없습니다.'))
                  : SingleChildScrollView(
                      child: ReservationBody(reservationList: reservationList),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
