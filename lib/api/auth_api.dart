import 'package:sitdown/api/api_client.dart';

class AuthApi {
  /// [AUTH-01] 회원가입
  static Future<Map<String, dynamic>> signup({
    required String email,
    required String password,
    required String name,
    String? phone,
    String? affiliation,
  }) async {
    final data = await ApiClient.post(
      '/auth/signup',
      body: {
        'email': email,
        'password': password,
        'name': name,
        if (phone != null && phone.isNotEmpty) 'phone': phone,
        if (affiliation != null && affiliation.isNotEmpty)
          'affiliation': affiliation,
      },
    );

    return Map<String, dynamic>.from(data);
  }

  /// [AUTH-02] 이메일 인증 코드 발송
  static Future<Map<String, dynamic>> sendEmailCode({
    required String email,
  }) async {
    final data = await ApiClient.post(
      '/auth/email/send',
      body: {'email': email},
    );

    return Map<String, dynamic>.from(data);
  }

  /// [AUTH-03] 이메일 인증 코드 확인
  static Future<Map<String, dynamic>> verifyEmailCode({
    required String email,
    required String code,
  }) async {
    final data = await ApiClient.post(
      '/auth/email/verify',
      body: {
        'email': email,
        'code': code,
      },
    );

    return Map<String, dynamic>.from(data);
  }

  /// [AUTH-04] 로그인
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final data = await ApiClient.post(
      '/auth/login',
      body: {
        'email': email,
        'password': password,
      },
    );

    return Map<String, dynamic>.from(data);
  }

  /// [AUTH-05] 토큰 갱신
  static Future<Map<String, dynamic>> refresh({
    required String refreshToken,
  }) async {
    final data = await ApiClient.post(
      '/auth/refresh',
      body: {'refreshToken': refreshToken},
    );

    return Map<String, dynamic>.from(data);
  }

  /// [AUTH-06] 로그아웃
  static Future<void> logout({
    required String accessToken,
  }) async {
    await ApiClient.post('/auth/logout', accessToken: accessToken);
  }

  /// [AUTH-07] 비밀번호 재설정 메일 발송
  static Future<dynamic> resetPassword({
    required String email,
  }) {
    return ApiClient.post(
      '/auth/password/reset',
      body: {'email': email},
    );
  }
}