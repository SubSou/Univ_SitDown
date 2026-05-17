import 'package:image_picker/image_picker.dart';
import 'package:sitdown/api/api_client.dart';

class UserApi {
  /// 내 정보 조회
  static Future<Map<String, dynamic>> getMyInfo({
    required String accessToken,
  }) async {
    final data = await ApiClient.get('/users/me', accessToken: accessToken);

    return Map<String, dynamic>.from(data);
  }

  /// 내 정보 수정
  static Future<Map<String, dynamic>> updateMyInfo({
    required String accessToken,
    String? name,
    String? phone,
    String? affiliation,
  }) async {
    final body = {
      if (name != null && name.trim().isNotEmpty) 'name': name.trim(),
      if (phone != null && phone.trim().isNotEmpty) 'phone': phone.trim(),
      if (affiliation != null && affiliation.trim().isNotEmpty)
        'affiliation': affiliation.trim(),
    };

    print("회원정보 수정 요청 body: $body");

    final data = await ApiClient.patch(
      '/users/me',
      accessToken: accessToken,
      body: body,
    );

    return Map<String, dynamic>.from(data);
  }

  /// 프로필 사진 업로드
  static Future<Map<String, dynamic>> uploadProfileImage({
    required String accessToken,
    required XFile imageFile,
  }) async {
    final data = await ApiClient.uploadFile(
      '/users/me/profile-image',
      accessToken: accessToken,
      file: imageFile,
      fileFieldName: 'image',
    );

    return Map<String, dynamic>.from(data);
  }
}
