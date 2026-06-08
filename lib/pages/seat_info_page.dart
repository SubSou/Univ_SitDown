import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitdown/api/seat_api.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/providers/auth_provider.dart';
import 'package:sitdown/api/rsv_api.dart';
import 'package:sitdown/pages/reservation_complete_page.dart';

class SeatInfoPage extends StatefulWidget {
  final String seatId;
  final String spaceName;
  final int? floor;

  const SeatInfoPage({
    super.key,
    required this.seatId,
    required this.spaceName,
    this.floor,
  });

  @override
  State<SeatInfoPage> createState() => _SeatInfoPageState();
}

class _SeatInfoPageState extends State<SeatInfoPage> {
  bool isLoading = true;
  Map<String, dynamic>? seat;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSeatDetail();
    });
  }

  Future<void> getSeatDetail() async {
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
      final response = await SeatApi.getSeatDetail(
        accessToken: accessToken,
        seatId: widget.seatId,
      );

      print('좌석 상세 조회 응답: $response');

      setState(() {
        seat = response;
        isLoading = false;
      });
    } catch (e) {
      print('좌석 상세 조회 에러: $e');

      setState(() {
        isLoading = false;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('좌석 정보를 불러오지 못했습니다.')));
    }
  }

  String getStatusText(String status) {
    if (status == 'AVAILABLE') return '사용 가능';
    if (status == 'OCCUPIED') return '사용 중';
    if (status == 'RESERVED') return '예약됨';
    if (status == 'UNAVAILABLE') return '선택 불가';
    return '정보 없음';
  }

  Color getStatusBgColor(String status) {
    if (status == 'AVAILABLE') return const Color(0xFFE5F8EA);
    if (status == 'OCCUPIED') return const Color(0xFFFFE5E7);
    if (status == 'RESERVED') return const Color(0xFFE8EFFF);
    if (status == 'UNAVAILABLE') return const Color(0xFFF0F0F0);
    return const Color(0xFFF0F0F0);
  }

  Color getStatusTextColor(String status) {
    if (status == 'AVAILABLE') return const Color(0xFF2FA866);
    if (status == 'OCCUPIED') return const Color(0xFFE54855);
    if (status == 'RESERVED') return primaryColor;
    if (status == 'UNAVAILABLE') return const Color(0xFF8A8A8A);
    return const Color(0xFF8A8A8A);
  }

  String getFeaturesText(dynamic features) {
    if (features is List && features.isNotEmpty) {
      return features.map((e) => e.toString()).join(', ');
    }

    return '-';
  }

  String formatTime(String value) {
    if (value.isEmpty) return '-';

    if (value.length >= 5) {
      return value.substring(0, 5);
    }

    return value;
  }

  Future<void> goNext() async {
    final authProvider = context.read<AuthProvider>();
    final accessToken = authProvider.accessToken;

    if (accessToken == null || accessToken.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('로그인이 필요합니다.')));
      return;
    }

    final selectedSpaceDetail = authProvider.selectedSpaceDetail;

    final maxReservationHours = int.tryParse(
      selectedSpaceDetail?['maxReservationHours']?.toString() ?? '',
    );

    if (maxReservationHours == null || maxReservationHours <= 0) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('이용 시간 정보가 없습니다.')));
      return;
    }

    final startDateTime = DateTime.now();
    final endDateTime = startDateTime.add(Duration(hours: maxReservationHours));

    final startAt = startDateTime.toIso8601String().substring(0, 19);
    final endAt = endDateTime.toIso8601String().substring(0, 19);

    print('예약 startAt: $startAt');
    print('예약 endAt: $endAt');

    try {
      final response = await RsvApi.createReservation(
        accessToken: accessToken,
        seatId: widget.seatId,
        startAt: startAt,
        endAt: endAt,
      );

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ReservationCompletePage(reservation: response),
        ),
      );
    } catch (e) {
      print('예약 생성 에러: $e');

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('예약에 실패했습니다.')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedSpaceDetail = context
        .watch<AuthProvider>()
        .selectedSpaceDetail;

    final openTime = selectedSpaceDetail?['openTime']?.toString() ?? '';
    final closeTime = selectedSpaceDetail?['closeTime']?.toString() ?? '';
    final maxReservationHours =
        selectedSpaceDetail?['maxReservationHours']?.toString() ?? '';

    final label = seat?['label']?.toString() ?? '-';
    final status = seat?['status']?.toString() ?? '';
    final features = getFeaturesText(seat?['features']);

    final spaceName = seat?['spaceName']?.toString() ?? widget.spaceName;
    final floor = widget.floor == null ? '' : '${widget.floor}층';
    final location = floor.isEmpty ? spaceName : '$spaceName $floor';

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(color: primaryColor),
              )
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(32, 52, 32, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '좌석 정보',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 42),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE9EEF7)),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  label,
                                  style: const TextStyle(
                                    fontSize: 38,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF111827),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: getStatusBgColor(status),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    getStatusText(status),
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w900,
                                      color: getStatusTextColor(status),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(height: 1, color: Color(0xFFE9EEF7)),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(24, 28, 24, 30),
                            child: Column(
                              children: [
                                _InfoLine(title: '위치', value: location),
                                const SizedBox(height: 30),
                                _InfoLine(title: '특징', value: features),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 34),
                    const Text(
                      '이용 시간',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 26),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFE9EEF7)),
                      ),
                      child: Column(
                        children: [
                          _TimeRow(
                            title: '운영 시작',
                            date: '운영 시간',
                            time: formatTime(openTime),
                          ),
                          const Divider(height: 1, color: Color(0xFFE9EEF7)),
                          _TimeRow(
                            title: '운영 종료',
                            date: '운영 시간',
                            time: formatTime(closeTime),
                          ),
                          const Divider(height: 1, color: Color(0xFFE9EEF7)),
                          _UseTimeRow(maxReservationHours: maxReservationHours),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed: goNext,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: whiteColor,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          '예약',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  final String title;
  final String value;

  const _InfoLine({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Color(0xFF5B6475),
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: Color(0xFF5B6475),
          ),
        ),
      ],
    );
  }
}

class _TimeRow extends StatelessWidget {
  final String title;
  final String date;
  final String time;

  const _TimeRow({required this.title, required this.date, required this.time});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 108,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFFA0A7B5),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF4B5563),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(width: 1, color: const Color(0xFFE9EEF7)),
          SizedBox(
            width: 170,
            child: Center(
              child: Text(
                time,
                style: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF111827),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UseTimeRow extends StatelessWidget {
  final String maxReservationHours;

  const _UseTimeRow({required this.maxReservationHours});

  @override
  Widget build(BuildContext context) {
    final value = maxReservationHours.isEmpty ? '-' : '$maxReservationHours시간';

    return SizedBox(
      height: 82,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          children: [
            const Text(
              '이용 시간',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Color(0xFF8B93A3),
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w900,
                color: Color(0xFF111827),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
