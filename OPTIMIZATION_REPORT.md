# Univ SitDown 최적화 작업 보고서

## 이번 ZIP에 적용한 작업

1. 공유용 ZIP 용량 정리
   - `.git/`, `.dart_tool/`, `build/` 폴더는 최종 ZIP에서 제외했습니다.
   - 이 폴더들은 `flutter pub get`, `flutter run`, `flutter build` 시 다시 생성됩니다.

2. API 호출 구조 분리
   - `lib/api/auth_api.dart`를 추가했습니다.
   - 회원가입 API: `AuthApi.signup()`
   - 로그인 API: `AuthApi.login()`
   - 공통 URL 결합 처리, JSON header, timeout 처리를 API 파일로 분리했습니다.

3. 회원가입 페이지 정리
   - `signup_page.dart`에서 직접 API URL을 만들거나 불필요한 import를 쓰는 부분을 정리했습니다.
   - 회원가입 페이지는 `AuthApi.signup()`만 호출하도록 수정했습니다.

4. 로그인 전역상태 연결
   - `login_page.dart`를 실제 로그인 API 호출 구조로 수정했습니다.
   - 로그인 성공 시 `AuthProvider.login()`으로 전역 로그인 상태를 변경합니다.
   - `main.dart`의 `AuthProvider.isLogin` 값에 따라 `LoginIntroPage` / `MainPage`가 자동 전환됩니다.

5. 로그아웃 전역상태 연결
   - `logout_confirm_page.dart`에서 로그아웃 버튼 클릭 시 `AuthProvider.logout()`을 호출하도록 수정했습니다.
   - 로그아웃 후 첫 화면으로 돌아가도록 route stack을 정리했습니다.

6. BottomNavigation 최적화 유지
   - `MainPage`는 `IndexedStack` 구조를 유지합니다.
   - 탭 이동 시 페이지 상태가 유지되고, 같은 탭을 다시 누를 때 불필요한 `setState`가 실행되지 않습니다.

## 확인해야 할 부분

- 로그인 API 경로는 현재 `/api/auth/login`으로 작성되어 있습니다.
- 서버 경로가 다르면 `lib/api/auth_api.dart`에서 `_uri('/api/auth/login')` 부분만 수정하면 됩니다.
- Flutter SDK가 없는 환경이라 `flutter analyze`와 실제 실행 검증은 하지 못했습니다.

## 로컬에서 실행할 명령어

```bash
flutter clean
flutter pub get
flutter analyze
flutter run
```
