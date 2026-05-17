import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sitdown/constants/api_url.dart';

class ApiException implements Exception {
  final int statusCode;
  final String message;
  final String? code;
  final dynamic data;

  ApiException({
    required this.statusCode,
    required this.message,
    this.code,
    this.data,
  });

  @override
  String toString() {
    if (code == null) return message;
    return '[$code] $message';
  }
}

class ApiClient {
  static const Duration timeout = Duration(seconds: 10);

  static String get _baseUrl {
    final base = URL.endsWith('/') ? URL.substring(0, URL.length - 1) : URL;
    return '$base/api';
  }

  static Uri uri(String path, [Map<String, dynamic>? queryParameters]) {
    final cleanPath = path.startsWith('/') ? path : '/$path';

    final query = <String, String>{};
    queryParameters?.forEach((key, value) {
      if (value == null) return;
      query[key] = value.toString();
    });

    return Uri.parse(
      '$_baseUrl$cleanPath',
    ).replace(queryParameters: query.isEmpty ? null : query);
  }

  static Map<String, String> jsonHeaders({String? accessToken}) {
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
      if (accessToken != null && accessToken.isNotEmpty)
        'Authorization': 'Bearer $accessToken',
    };
  }

  static Future<dynamic> get(
    String path, {
    String? accessToken,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await http
        .get(
          uri(path, queryParameters),
          headers: jsonHeaders(accessToken: accessToken),
        )
        .timeout(timeout);

    return _handleResponse(response);
  }

  static Future<dynamic> post(
    String path, {
    String? accessToken,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await http
        .post(
          uri(path, queryParameters),
          headers: jsonHeaders(accessToken: accessToken),
          body: body == null ? null : jsonEncode(body),
        )
        .timeout(timeout);

    return _handleResponse(response);
  }

  static Future<dynamic> patch(
    String path, {
    String? accessToken,
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await http
        .patch(
          uri(path, queryParameters),
          headers: jsonHeaders(accessToken: accessToken),
          body: body == null ? null : jsonEncode(body),
        )
        .timeout(timeout);

    return _handleResponse(response);
  }

  static Future<dynamic> delete(
    String path, {
    String? accessToken,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await http
        .delete(
          uri(path, queryParameters),
          headers: jsonHeaders(accessToken: accessToken),
        )
        .timeout(timeout);

    return _handleResponse(response);
  }

  static Future<dynamic> uploadFile(
    String path, {
    required String accessToken,
    required XFile file,
    String fileFieldName = 'image',
    Map<String, String>? fields,
  }) async {
    final request = http.MultipartRequest('POST', uri(path));

    request.headers['Authorization'] = 'Bearer $accessToken';
    request.headers['Accept'] = 'application/json';

    if (fields != null) {
      request.fields.addAll(fields);
    }

    final bytes = await file.readAsBytes();

    request.files.add(
      http.MultipartFile.fromBytes(fileFieldName, bytes, filename: file.name),
    );

    final streamedResponse = await request.send().timeout(timeout);
    final response = await http.Response.fromStream(streamedResponse);

    return _handleResponse(response);
  }

  static dynamic _handleResponse(http.Response response) {
    final body = utf8.decode(response.bodyBytes).trim();

    dynamic data;

    if (body.isNotEmpty) {
      try {
        data = jsonDecode(body);
      } catch (_) {
        data = body;
      }
    }

    final isSuccess = response.statusCode >= 200 && response.statusCode < 300;

    if (isSuccess) {
      return data ?? {};
    }

    String message = 'API 호출에 실패했습니다.';
    String? code;

    if (data is Map<String, dynamic>) {
      message = data['message']?.toString() ?? message;
      code = data['code']?.toString();
    } else if (data is String && data.isNotEmpty) {
      message = data;
    }

    throw ApiException(
      statusCode: response.statusCode,
      message: message,
      code: code,
      data: data,
    );
  }
}
