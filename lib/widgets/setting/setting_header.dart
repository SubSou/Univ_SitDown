import 'package:flutter/material.dart';
import 'package:sitdown/util/navigation_util.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';

class SettingHeader extends StatefulWidget {
  const SettingHeader({super.key});

  @override
  State<SettingHeader> createState() => _SettingHeader();
}

class _SettingHeader extends State<SettingHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          chevron_left(
            onTap: () {
              NavUtil.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
