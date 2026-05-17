# API 사용 예시

## 로그인

```dart
try {
  final data = await AuthApi.login(
    email: emailController.text,
    password: passwordController.text,
  );

  context.read<AuthProvider>().loginFromJson(data);
} catch (e) {
  print(e);
}
```

## 내 정보 조회

```dart
final token = context.read<AuthProvider>().accessToken;

if (token != null) {
  final myInfo = await UserApi.getMyInfo(accessToken: token);
  context.read<AuthProvider>().setMyInfo(myInfo);
}
```

## 내 예약 목록 조회

```dart
final token = context.read<AuthProvider>().accessToken;

if (token != null) {
  final result = await RsvApi.getMyReservations(accessToken: token);
  context.read<AuthProvider>().setReservationList(result['content'] ?? []);
}
```

## 좌석 조회

```dart
final result = await SeatApi.getSeats(
  accessToken: token,
  spaceId: 'space-001',
);
final seats = result['seats'];
```