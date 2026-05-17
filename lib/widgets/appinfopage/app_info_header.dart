import 'package:flutter/material.dart';
import 'package:sitdown/util/navigation_util.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';

class AppInfoHeader extends StatefulWidget {
  const AppInfoHeader({super.key});

  @override
  State<AppInfoHeader> createState() => _AppInfoHeader();
}

class _AppInfoHeader extends State<AppInfoHeader> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
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
