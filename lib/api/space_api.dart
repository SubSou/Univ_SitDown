import 'package:sitdown/api/api_client.dart';

class SpaceApi {
  /// [SPACE-01] 공간 목록 조회
  static Future<Map<String, dynamic>> getSpaces({
    required String accessToken,
    String? category,
    String? keyword,
    int page = 0,
    int size = 20,
  }) async {
    final data = await ApiClient.get(
      '/spaces',
      accessToken: accessToken,
      queryParameters: {
        if (category != null && category.isNotEmpty) 'category': category,
        if (keyword != null && keyword.isNotEmpty) 'keyword': keyword,
        'page': page,
        'size': size,
      },
    );

    return Map<String, dynamic>.from(data);
  }

  /// [SPACE-02] 공간 상세 조회
  static Future<Map<String, dynamic>> getSpaceDetail({
    required String accessToken,
    required String spaceId,
  }) async {
    final data = await ApiClient.get(
      '/spaces/$spaceId',
      accessToken: accessToken,
    );

    return Map<String, dynamic>.from(data);
  }

  /// [SPACE-03] 혼잡도 예측 조회
  static Future<Map<String, dynamic>> getCongestion({
    required String accessToken,
    required String spaceId,
    String? date,
  }) async {
    final data = await ApiClient.get(
      '/spaces/$spaceId/congestion',
      accessToken: accessToken,
      queryParameters: {if (date != null && date.isNotEmpty) 'date': date},
    );

    return Map<String, dynamic>.from(data);
  }

  /// [SPACE-04] 즐겨찾기 추가
  static Future<dynamic> addFavorite({
    required String accessToken,
    required String spaceId,
  }) {
    return ApiClient.post(
      '/spaces/$spaceId/favorite',
      accessToken: accessToken,
    );
  }

  /// [SPACE-05] 즐겨찾기 해제
  static Future<void> removeFavorite({
    required String accessToken,
    required String spaceId,
  }) async {
    await ApiClient.delete(
      '/spaces/$spaceId/favorite',
      accessToken: accessToken,
    );
  }
}
