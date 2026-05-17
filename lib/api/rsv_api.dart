import 'package:sitdown/api/api_client.dart';

class RsvApi {
  /// [RSV-01] 예약 생성
  static Future<Map<String, dynamic>> createReservation({
    required String accessToken,
    required String seatId,
    required String startAt,
    required String endAt,
  }) async {
    final data = await ApiClient.post(
      '/reservations',
      accessToken: accessToken,
      body: {
        'seatId': seatId,
        'startAt': startAt,
        'endAt': endAt,
      },
    );

    return Map<String, dynamic>.from(data);
  }

  /// [RSV-02] 내 예약 목록 조회
  /// status: ACTIVE / PAST / CANCELED
  static Future<Map<String, dynamic>> getMyReservations({
    required String accessToken,
    String? status,
    int page = 0,
    int size = 20,
  }) async {
    final data = await ApiClient.get(
      '/reservations/me',
      accessToken: accessToken,
      queryParameters: {
        if (status != null && status.isNotEmpty) 'status': status,
        'page': page,
        'size': size,
      },
    );

    return Map<String, dynamic>.from(data);
  }

  /// [RSV-03] 예약 상세 조회
  static Future<Map<String, dynamic>> getReservationDetail({
    required String accessToken,
    required String reservationId,
  }) async {
    final data = await ApiClient.get(
      '/reservations/$reservationId',
      accessToken: accessToken,
    );

    return Map<String, dynamic>.from(data);
  }

  /// [RSV-04] 예약 연장
  static Future<Map<String, dynamic>> extendReservation({
    required String accessToken,
    required String reservationId,
    required int additionalMinutes,
  }) async {
    final data = await ApiClient.patch(
      '/reservations/$reservationId/extend',
      accessToken: accessToken,
      body: {'additionalMinutes': additionalMinutes},
    );

    return Map<String, dynamic>.from(data);
  }

  /// [RSV-05] 예약 취소
  static Future<void> cancelReservation({
    required String accessToken,
    required String reservationId,
    String? reason,
  }) async {
    await ApiClient.delete(
      '/reservations/$reservationId',
      accessToken: accessToken,
      queryParameters: {
        if (reason != null && reason.isNotEmpty) 'reason': reason,
      },
    );
  }
}