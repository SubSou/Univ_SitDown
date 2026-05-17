import 'package:flutter/material.dart';
import 'package:sitdown/widgets/common/CustomSwitch.dart';

class SettingBody extends StatefulWidget {
  const SettingBody({super.key});

  @override
  State<SettingBody> createState() => _SettingBody();
}

class _SettingBody extends State<SettingBody> {
  bool alarm1 = true;
  bool alarm2 = true;
  bool alarm3 = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 🔵 알림 설정 타이틀
          const Text(
            "알림 설정",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          /// 🔹 예약 알림
          buildSwitchItem("예약 알림", alarm1, (v) {
            setState(() => alarm1 = v);
          }),

          /// 🔹 이용 시간 알림
          buildSwitchItem("이용 시간 알림", alarm2, (v) {
            setState(() => alarm2 = v);
          }),

          /// 🔹 공지사항 알림
          buildSwitchItem("공지사항 알림", alarm3, (v) {
            setState(() => alarm3 = v);
          }),

          const SizedBox(height: 24),

          /// 🔵 구분선
          Container(height: 1, color: const Color(0xFFE5E7EB)),

          const SizedBox(height: 24),

          /// 🔵 기타
          const Text(
            "기타",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 16),

          /// 🔹 버전 정보
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text("버전 정보", style: TextStyle(fontSize: 14)),
              Text("1.0.0", style: TextStyle(fontSize: 14, color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }

  /// 🔧 공통 스위치 UI
  Widget buildSwitchItem(String title, bool value, Function(bool) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 14)),
          CustomSwitch(value: value, onChanged: onChanged),
        ],
      ),
    );
  }
}
