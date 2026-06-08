import 'package:flutter/material.dart';

class MyStatsBottom extends StatelessWidget {
  final List<Map<String, dynamic>> usageList;

  const MyStatsBottom({Key? key, required this.usageList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (usageList.isEmpty) {
      return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 30),
        padding: const EdgeInsets.symmetric(vertical: 50),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xFFF6F8FB),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          "이용한 내용이 없습니다.",
          style: TextStyle(
            fontSize: 15,
            color: Color(0xFF8A94A6),
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 24),
          alignment: Alignment.centerLeft,
          child: const Text(
            "주로 이용하는 공간",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        ...usageList.map((item) {
          return Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFE5E7EB)),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 26,
                      height: 26,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F3F5),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        "${item["rank"]}",
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8A94A6),
                        ),
                      ),
                    ),
                    const SizedBox(width: 14),
                    Text(
                      "${item["name"]}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Text(
                  "${item["time"]}",
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
