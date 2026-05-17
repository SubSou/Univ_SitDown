import 'package:flutter/material.dart';
import 'package:sitdown/api/auth_api.dart';
import 'package:sitdown/api/rsv_api.dart';
import 'package:sitdown/api/user_api.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLogin = false;

  String? _accessToken;
  String? _refreshToken;
  int? _accessTokenExpiresIn;

  Map<String, dynamic>? _myInfo;
  List<dynamic> _reservationList = [];

  bool get isLogin => _isLogin;

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;
  int? get accessTokenExpiresIn => _accessTokenExpiresIn;

  Map<String, dynamic>? get myInfo => _myInfo;
  List<dynamic> get reservationList => _reservationList;

  void loginFromJson(Map<String, dynamic> json) {
    _isLogin = true;

    _accessToken = json['accessToken']?.toString();
    _refreshToken = json['refreshToken']?.toString();
    _accessTokenExpiresIn = json['accessTokenExpiresIn'] is int
        ? json['accessTokenExpiresIn']
        : int.tryParse(json['accessTokenExpiresIn']?.toString() ?? '');

    final user = json['user'];
    if (user is Map<String, dynamic>) {
      _myInfo = user;
    }

    notifyListeners();
  }

  /// 로그인 API 실제 호출
  Future<void> login({
    required String email,
    required String password,
  }) async {
    final data = await AuthApi.login(email: email, password: password);
    loginFromJson(data);
  }

  /// 내 정보 API 실제 호출
  Future<void> fetchMyInfo() async {
    final token = _accessToken;
    if (token == null || token.isEmpty) return;

    final data = await UserApi.getMyInfo(accessToken: token);
    setMyInfo(data);
  }

  /// 내 예약 목록 API 실제 호출
  Future<void> fetchMyReservations({
    String? status,
    int page = 0,
    int size = 20,
  }) async {
    final token = _accessToken;
    if (token == null || token.isEmpty) return;

    final data = await RsvApi.getMyReservations(
      accessToken: token,
      status: status,
      page: page,
      size: size,
    );

    final content = data['content'];
    if (content is List) {
      setReservationList(content);
    } else {
      setReservationList([]);
    }
  }

  /// 내 정보 저장
  void setMyInfo(Map<String, dynamic> data) {
    _myInfo = data;
    notifyListeners();
  }

  void setReservationList(List<dynamic> data) {
    _reservationList = data;
    notifyListeners();
  }

  Future<void> logoutFromServer() async {
    final token = _accessToken;
    if (token != null && token.isNotEmpty) {
      await AuthApi.logout(accessToken: token);
    }

    logout();
  }

  void logout() {
    _isLogin = false;

    _accessToken = null;
    _refreshToken = null;
    _accessTokenExpiresIn = null;

    _myInfo = null;
    _reservationList = [];

    notifyListeners();
  }
}