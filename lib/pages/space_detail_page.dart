import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitdown/api/space_api.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/providers/auth_provider.dart';

class SpaceDetailPage extends StatefulWidget {
  final String spaceId;

  const SpaceDetailPage({super.key, required this.spaceId});

  @override
  State<SpaceDetailPage> createState() => _SpaceDetailPageState();
}

class _SpaceDetailPageState extends State<SpaceDetailPage> {
  bool isLoading = true;
  bool isFavorite = false;

  Map<String, dynamic>? space;
  List<CongestionItem> congestionList = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSpaceDetail();
    });
  }

  Future<void> getSpaceDetail() async {
    final accessToken = context.read<AuthProvider>().accessToken;

    if (accessToken == null || accessToken.isEmpty) {
      setState(() {
        isLoading = false;
      });
      return;
    }

    try {
      final detailResponse = await SpaceApi.getSpaceDetail(
        accessToken: accessToken,
        spaceId: widget.spaceId,
      );

      print(detailResponse);

      final congestionResponse = await SpaceApi.getCongestion(
        accessToken: accessToken,
        spaceId: widget.spaceId,
      );

      setState(() {
        space = detailResponse;
        isFavorite = detailResponse['isFavorite'] == true;
        congestionList = parseCongestionList(congestionResponse);
        isLoading = false;
      });
    } catch (e) {
      print('공간 상세 조회 에러: $e');

      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> toggleFavorite() async {
    print("호출");
    final accessToken = context.read<AuthProvider>().accessToken;

    if (accessToken == null || accessToken.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('로그인이 필요합니다.')));
      return;
    }

    final previousFavorite = isFavorite;

    setState(() {
      isFavorite = !isFavorite;
    });

    try {
      if (previousFavorite) {
        await SpaceApi.removeFavorite(
          accessToken: accessToken,
          spaceId: widget.spaceId,
        );
      } else {
        await SpaceApi.addFavorite(
          accessToken: accessToken,
          spaceId: widget.spaceId,
        );
      }
    } catch (e) {
      print('즐겨찾기 변경 에러: $e');

      setState(() {
        isFavorite = previousFavorite;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('즐겨찾기 변경에 실패했습니다.')));
    }
  }

  List<CongestionItem> parseCongestionList(Map<String, dynamic> response) {
    dynamic rawList;

    if (response['hourly'] is List) rawList = response['hourly'];

    if (rawList is! List) return [];

    return rawList
        .map((item) {
          if (item is Map<String, dynamic>) {
            final hourValue = item['hour'] ?? '';
            final occupancyRateValue = item['occupancyRate'] ?? 0;
            final levelValue = item['level']?.toString().toUpperCase() ?? 'LOW';

            final hourText = formatHour(hourValue);
            final occupancyRate = parseScore(occupancyRateValue);

            return CongestionItem(
              hour: hourText,
              occupancyRate: occupancyRate,
              status: levelValue,
            );
          }

          return CongestionItem(hour: '', occupancyRate: 0, status: 'LOW');
        })
        .where((item) => item.hour.isNotEmpty)
        .toList();
  }

  String formatHour(dynamic value) {
    final hour = int.tryParse(value.toString());

    if (hour != null) {
      return '${hour.toString().padLeft(2, '0')}시';
    }

    return value.toString();
  }

  double parseScore(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value.toString()) ?? 0;
  }

  String getCongestionText(String congestion) {
    if (congestion == 'NORMAL') return '보통';
    if (congestion == 'LOW') return '여유';
    if (congestion == 'HIGH') return '혼잡';
    return '정보없음';
  }

  Color getCongestionColor(String congestion) {
    if (congestion == 'LOW') return const Color(0xFFBFD0FF);
    if (congestion == 'NORMAL') return const Color(0xFFFFDCA8);
    if (congestion == 'HIGH') return const Color(0xFFFF7A7A);
    return const Color(0xFFE5E7EB);
  }

  String getFeaturesText(dynamic features) {
    if (features is List) {
      return features.map((e) => e.toString()).join(', ');
    }
    return '';
  }

  void goSeatSelect() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('좌석 선택 페이지 연결은 다음 단계에서 진행하면 됩니다.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        backgroundColor: whiteColor,
        body: Center(child: CircularProgressIndicator(color: primaryColor)),
      );
    }

    if (space == null) {
      return const Scaffold(
        backgroundColor: whiteColor,
        body: Center(child: Text('공간 정보를 불러오지 못했습니다.')),
      );
    }

    final name = space!['name']?.toString() ?? '';
    final floor = space!['floor']?.toString() ?? '';
    final totalSeats = space!['totalSeats'] ?? 0;
    final rows = space!['rows'] ?? 0;
    final columns = space!['columns'] ?? 0;
    final openTime = space!['openTime']?.toString() ?? '';
    final closeTime = space!['closeTime']?.toString() ?? '';
    final features = getFeaturesText(space!['features']);

    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: const Icon(Icons.chevron_left, size: 34),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                        IconButton(
                          onPressed: toggleFavorite,
                          icon: Icon(
                            isFavorite ? Icons.star : Icons.star_border,
                            color: const Color(0xFF1F2A44),
                            size: 30,
                          ),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 34),
                    Text(
                      floor.isEmpty ? name : '$name (${floor}층)',
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111827),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      '$totalSeats석',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF5B6475),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Wrap(
                      spacing: 12,
                      runSpacing: 10,
                      children: [
                        if (features.isNotEmpty)
                          ...features
                              .split(', ')
                              .map((text) => _Tag(text: text)),
                      ],
                    ),
                    const SizedBox(height: 40),
                    _InfoRow(title: '운영 시간', value: '$openTime - $closeTime'),
                    const SizedBox(height: 24),
                    _InfoRow(
                      title: '좌석 수',
                      value: '$totalSeats (${rows}행 x ${columns}열)',
                    ),
                    const SizedBox(height: 24),
                    _InfoRow(title: '특징', value: features),
                    const SizedBox(height: 42),
                    _CongestionCard(
                      items: congestionList,
                      getColor: getCongestionColor,
                      getText: getCongestionText,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 20),
              child: SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  onPressed: goSeatSelect,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: whiteColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    '좌석 선택하기',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CongestionItem {
  final String hour;
  final double occupancyRate;
  final String status;

  CongestionItem({
    required this.hour,
    required this.occupancyRate,
    required this.status,
  });
}

class _Tag extends StatelessWidget {
  final String text;

  const _Tag({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F8),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w800,
          color: Color(0xFF4B5563),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const _InfoRow({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF4B5563),
            ),
          ),
        ),
        Expanded(
          child: Text(
            value.isEmpty ? '-' : value,
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF4B5563),
            ),
          ),
        ),
      ],
    );
  }
}

class _CongestionCard extends StatelessWidget {
  final List<CongestionItem> items;
  final Color Function(String status) getColor;
  final String Function(String status) getText;

  const _CongestionCard({
    required this.items,
    required this.getColor,
    required this.getText,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 20),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE9EEF7)),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            '혼잡도 예측',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: Color(0xFF1F2937),
            ),
          ),
          const SizedBox(height: 20),
          if (items.isEmpty)
            const SizedBox(
              height: 130,
              child: Center(child: Text('혼잡도 예측 정보가 없습니다.')),
            )
          else
            SizedBox(
              height: 170,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(
                    width: 24,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '100',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        Text(
                          '50',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        Text(
                          '0',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: items.map((item) {
                              final height =
                                  (item.occupancyRate / 100) * 100 + 18;

                              return Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 24,
                                      child: item.status == 'NORMAL'
                                          ? Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                    horizontal: 8,
                                                    vertical: 4,
                                                  ),
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFFFF1D6),
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                              ),
                                              child: Text(
                                                getText(item.status),
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w900,
                                                  color: Color(0xFFD97706),
                                                ),
                                              ),
                                            )
                                          : null,
                                    ),
                                    const SizedBox(height: 4),
                                    Container(
                                      width: 10,
                                      height: height,
                                      decoration: BoxDecoration(
                                        color: getColor(item.status),
                                        borderRadius: BorderRadius.circular(99),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: items
                              .map(
                                (item) => Expanded(
                                  child: Center(
                                    child: Text(
                                      item.hour,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF6B7280),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
