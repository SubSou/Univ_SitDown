import 'package:sitdown/api/api_client.dart';

class StatApi {
  static Future<Map<String, dynamic>> getMyStats({
    required String accessToken,
    required String from,
    required String to,
  }) async {
    final data = await ApiClient.get(
      '/stats/me',
      accessToken: accessToken,
      queryParameters: {'from': from, 'to': to},
    );

    return Map<String, dynamic>.from(data);
  }
}
