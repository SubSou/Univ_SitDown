import 'package:sitdown/api/api_client.dart';

class SeatApi {
  /// [SEAT-01] 좌석 배치 및 상태 조회
  static Future<Map<String, dynamic>> getSeats({
    required String accessToken,
    required String spaceId,
    String? at,
  }) async {
    final data = await ApiClient.get(
      '/spaces/$spaceId/seats',
      accessToken: accessToken,
      queryParameters: {
        if (at != null && at.isNotEmpty) 'at': at,
      },
    );

    return Map<String, dynamic>.from(data);
  }

  /// [SEAT-02] 좌석 상세 조회
  static Future<Map<String, dynamic>> getSeatDetail({
    required String accessToken,
    required String seatId,
  }) async {
    final data = await ApiClient.get(
      '/seats/$seatId',
      accessToken: accessToken,
    );

    return Map<String, dynamic>.from(data);
  }
}