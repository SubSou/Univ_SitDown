import 'package:flutter/material.dart';
import 'package:sitdown/util/navigation_util.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';

class SettingBody extends StatefulWidget {
  const SettingBody({super.key});

  @override
  State<SettingBody> createState() => _SettingBody();
}

class _SettingBody extends State<SettingBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(left: 7),
            child: Text(
              "알림 설정",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          Container(child: Text("data")),
          Container(child: Text("data")),
        ],
      ),
    );
  }
}
