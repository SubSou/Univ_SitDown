import 'package:flutter/material.dart';
import 'package:sitdown/util/navigation_util.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';

class MyStatsHeader extends StatelessWidget {
  final String fromDateText;
  final String toDateText;
  final String totalTimeText;
  final String comparedTimeText;
  final int comparedMinutes;
  final VoidCallback onFromTap;
  final VoidCallback onToTap;

  const MyStatsHeader({
    Key? key,
    required this.fromDateText,
    required this.toDateText,
    required this.totalTimeText,
    required this.comparedTimeText,
    required this.comparedMinutes,
    required this.onFromTap,
    required this.onToTap,
  }) : super(key: key);

  String getCompareText() {
    if (comparedMinutes > 0) {
      return "이전 기간보다 +$comparedTimeText";
    }

    if (comparedMinutes < 0) {
      return "이전 기간보다 -$comparedTimeText";
    }

    return "이전 기간과 동일해요";
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        chevron_left(
          onTap: () {
            NavUtil.pop(context);
          },
        ),
        const SizedBox(height: 20),

        const Text(
          "내 이용 통계",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),

        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: onFromTap,
                child: _DateBox(label: "시작일", dateText: fromDateText),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: onToTap,
                child: _DateBox(label: "종료일", dateText: toDateText),
              ),
            ),
          ],
        ),

        const SizedBox(height: 20),

        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFFF6F8FB),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "선택 기간 총 이용 시간",
                style: TextStyle(fontSize: 14, color: Color(0xFF8A94A6)),
              ),
              const SizedBox(height: 8),
              Text(
                totalTimeText,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                getCompareText(),
                style: TextStyle(
                  fontSize: 14,
                  color: comparedMinutes >= 0
                      ? const Color(0xFF0B57D0)
                      : Colors.red,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DateBox extends StatelessWidget {
  final String label;
  final String dateText;

  const _DateBox({required this.label, required this.dateText});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 14),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFE5E7EB)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Color(0xFF8A94A6)),
          ),
          const SizedBox(height: 6),
          Row(
            children: [
              Expanded(
                child: Text(
                  dateText,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              const Icon(Icons.calendar_month, size: 18),
            ],
          ),
        ],
      ),
    );
  }
}
