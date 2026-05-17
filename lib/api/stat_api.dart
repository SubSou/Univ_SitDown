import 'package:sitdown/api/api_client.dart';

class StatApi {
  /// [STAT-01] 내 이용 통계 조회
  /// period: WEEKLY / MONTHLY / YEARLY
  static Future<Map<String, dynamic>> getMyStats({
    required String accessToken,
    required String period,
    String? from,
    String? to,
  }) async {
    final data = await ApiClient.get(
      '/stats/me',
      accessToken: accessToken,
      queryParameters: {
        'period': period,
        if (from != null && from.isNotEmpty) 'from': from,
        if (to != null && to.isNotEmpty) 'to': to,
      },
    );

    return Map<String, dynamic>.from(data);
  }
}