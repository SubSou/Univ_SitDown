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
  Map<String, dynamic>? space;

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
      final response = await SpaceApi.getSpaceDetail(
        accessToken: accessToken,
        spaceId: widget.spaceId,
      );

      setState(() {
        space = response;
        isLoading = false;
      });
    } catch (e) {
      print('공간 상세 조회 에러: $e');

      setState(() {
        isLoading = false;
      });
    }
  }

  String getCongestionText(String congestion) {
    if (congestion == 'NORMAL') return '보통';
    if (congestion == 'LOW') return '여유';
    if (congestion == 'HIGH') return '혼잡';
    return '정보없음';
  }

  String getFeaturesText(dynamic features) {
    if (features is List) {
      return features.map((e) => e.toString()).join(' · ');
    }
    return '';
  }

  Widget buildImage(dynamic images) {
    String imageUrl = '';

    if (images is List && images.isNotEmpty) {
      imageUrl = images.first.toString();
    }

    if (imageUrl.isEmpty) {
      return Container(
        height: 220,
        color: Colors.grey.shade200,
        alignment: Alignment.center,
        child: const Icon(Icons.image_not_supported_outlined),
      );
    }

    return Image.network(
      imageUrl,
      height: 220,
      width: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) {
        return Container(
          height: 220,
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: const Icon(Icons.image_not_supported_outlined),
        );
      },
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

    final name = space!['name'] ?? '';
    final floor = space!['floor'] ?? '';
    final totalSeats = space!['totalSeats'] ?? 0;
    final availableSeats = space!['availableSeats'] ?? 0;
    final rows = space!['rows'] ?? 0;
    final columns = space!['columns'] ?? 0;
    final congestion = space!['congestion'] ?? '';
    final openTime = space!['openTime'] ?? '';
    final closeTime = space!['closeTime'] ?? '';
    final maxReservationHours = space!['maxReservationHours'] ?? 0;
    final features = space!['features'];
    final images = space!['images'];
    final isFavorite = space!['isFavorite'] == true;

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        backgroundColor: whiteColor,
        elevation: 0,
        foregroundColor: blackColor,
        title: Text(name.toString()),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildImage(images),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    floor == '' ? name.toString() : '$name (${floor}층)',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    getCongestionText(congestion.toString()),
                    style: const TextStyle(
                      fontSize: 15,
                      color: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 24),

                  Text('운영시간: $openTime ~ $closeTime'),
                  const SizedBox(height: 8),
                  Text('좌석: $availableSeats / $totalSeats석'),
                  const SizedBox(height: 8),
                  Text('좌석 배치: $rows행 x $columns열'),
                  const SizedBox(height: 8),
                  Text('최대 예약 시간: $maxReservationHours시간'),
                  const SizedBox(height: 8),
                  Text('편의시설: ${getFeaturesText(features)}'),
                  const SizedBox(height: 8),
                  Text('즐겨찾기: ${isFavorite ? "등록됨" : "미등록"}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
