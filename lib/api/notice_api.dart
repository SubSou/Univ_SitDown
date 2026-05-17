import 'package:sitdown/api/api_client.dart';

class NoticeApi {
  /// [NOTI-01] 공지사항 목록 조회
  /// category: ALL / INFO / MAINTENANCE / EVENT
  static Future<Map<String, dynamic>> getNotices({
    required String accessToken,
    String category = 'ALL',
    int page = 0,
    int size = 20,
  }) async {
    final data = await ApiClient.get(
      '/notices',
      accessToken: accessToken,
      queryParameters: {
        'category': category,
        'page': page,
        'size': size,
      },
    );

    return Map<String, dynamic>.from(data);
  }

  /// [NOTI-02] 공지사항 상세 조회
  static Future<Map<String, dynamic>> getNoticeDetail({
    required String accessToken,
    required String noticeId,
  }) async {
    final data = await ApiClient.get(
      '/notices/$noticeId',
      accessToken: accessToken,
    );

    return Map<String, dynamic>.from(data);
  }
}