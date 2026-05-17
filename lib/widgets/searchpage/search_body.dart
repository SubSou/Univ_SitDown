import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sitdown/api/space_api.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/pages/space_detail_page.dart';
import 'package:sitdown/providers/auth_provider.dart';

class SearchBody extends StatefulWidget {
  final String? category;
  final String? keyword;

  const SearchBody({super.key, this.category, this.keyword});

  @override
  State<SearchBody> createState() => _SearchBody();
}

class _SearchBody extends State<SearchBody> {
  bool isLoading = true;
  bool isMoreLoading = false;

  int page = 0;
  int totalPages = 1;
  final int size = 20;

  List<Map<String, dynamic>> roomList = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      getSpaces(isRefresh: true);
    });
  }

  @override
  void didUpdateWidget(covariant SearchBody oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.category != widget.category ||
        oldWidget.keyword != widget.keyword) {
      getSpaces(isRefresh: true);
    }
  }

  bool get canLoadMore {
    return page < totalPages;
  }

  Future<void> getSpaces({bool isRefresh = false}) async {
    if (isLoading && !isRefresh) return;
    if (isMoreLoading) return;
    if (!isRefresh && !canLoadMore) return;

    final accessToken = context.read<AuthProvider>().accessToken;

    if (accessToken == null || accessToken.isEmpty) {
      if (!mounted) return;

      setState(() {
        roomList = [];
        isLoading = false;
        isMoreLoading = false;
      });

      return;
    }

    if (isRefresh) {
      page = 0;
      totalPages = 1;

      setState(() {
        isLoading = true;
        isMoreLoading = false;
        roomList = [];
      });
    } else {
      setState(() {
        isMoreLoading = true;
      });
    }

    try {
      final response = await SpaceApi.getSpaces(
        accessToken: accessToken,
        category: widget.category,
        keyword: widget.keyword,
        page: page,
        size: size,
      );

      final dynamic rawList = response['content'] ?? [];

      List<Map<String, dynamic>> newList = [];

      if (rawList is List) {
        newList = rawList
            .whereType<Map>()
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
      }

      final int responseTotalPages = response['totalPages'] ?? 1;

      if (!mounted) return;

      setState(() {
        if (isRefresh) {
          roomList = newList;
        } else {
          roomList.addAll(newList);
        }

        totalPages = responseTotalPages;
        page++;

        isLoading = false;
        isMoreLoading = false;
      });
    } catch (e) {
      print('공간 목록 조회 에러: $e');

      if (!mounted) return;

      setState(() {
        isLoading = false;
        isMoreLoading = false;
      });
    }
  }

  String getCongestionText(String congestion) {
    if (congestion == 'NORMAL') return '보통';
    if (congestion == 'LOW') return '여유';
    if (congestion == 'HIGH') return '혼잡';
    return '정보없음';
  }

  Color getStatusColor(String congestion) {
    if (congestion == 'LOW') return Colors.green;
    if (congestion == 'NORMAL') return Colors.orange;
    if (congestion == 'HIGH') return Colors.red;
    return Colors.grey;
  }

  String getFeaturesText(dynamic features) {
    if (features is List) {
      return features.map((e) => e.toString()).join(' · ');
    }

    return '';
  }

  Widget buildRoomImage(dynamic image) {
    final imageText = image?.toString() ?? '';

    return Image.network(
      imageText,
      height: 100,
      width: 150,
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) {
        return Container(
          height: 100,
          width: 150,
          color: Colors.grey.shade200,
          alignment: Alignment.center,
          child: const Icon(
            Icons.image_not_supported_outlined,
            color: Colors.grey,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: primaryColor),
      );
    }

    if (roomList.isEmpty) {
      return const Center(
        child: Text(
          '조회된 공간이 없습니다.',
          style: TextStyle(fontSize: 15, color: Colors.grey),
        ),
      );
    }

    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        if (notification.metrics.extentAfter < 300) {
          if (!isMoreLoading && canLoadMore) {
            getSpaces();
          }
        }

        return false;
      },
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: roomList.length + (isMoreLoading ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == roomList.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(
                child: CircularProgressIndicator(color: primaryColor),
              ),
            );
          }

          final room = roomList[index];

          final id = room['id'] ?? '';
          final name = room['name'] ?? '';
          final floor = room['floor'] ?? '';
          final congestion = room['congestion'] ?? '';
          final openTime = room['openTime'] ?? '';
          final closeTime = room['closeTime'] ?? '';
          final totalSeats = room['totalSeats'] ?? 0;
          final availableSeats = room['availableSeats'] ?? 0;
          final features = room['features'];
          final thumbnailUrl = room['thumbnailUrl'];

          final time = '$openTime ~ $closeTime';
          final info =
              '$availableSeats/$totalSeats석 · ${getFeaturesText(features)}';

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: () {
                  if (id.toString().isEmpty) return;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => SpaceDetailPage(spaceId: id.toString()),
                    ),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: buildRoomImage(thumbnailUrl),
                    ),
                    const SizedBox(width: 16),

                    Expanded(
                      child: SizedBox(
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              floor == ''
                                  ? name.toString()
                                  : '$name (${floor}층)',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),

                            Row(
                              children: [
                                Text(
                                  getCongestionText(congestion.toString()),
                                  style: TextStyle(
                                    color: getStatusColor(
                                      congestion.toString(),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 16),

                                Expanded(
                                  child: Text(
                                    time,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),

                                const Icon(Icons.chevron_right),
                              ],
                            ),

                            Text(
                              info,
                              style: const TextStyle(color: Colors.grey),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
