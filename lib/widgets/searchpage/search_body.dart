import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({super.key});

  @override
  State<SearchBody> createState() => _SearchBody();
}

class _SearchBody extends State<SearchBody> {
  final List<Map<String, dynamic>> roomList = [
  {
    "id": 1,
    "title": "제1열람실",
    "status": "보통",
    "time": "06:00 ~ 22:00",
    "info": "804석 · 콘센트 · 조용",
    "image": "assets/images/test.jpg",
  },
  {
    "id": 2,
    "title": "제2열람실",
    "status": "여유",
    "time": "06:00 ~ 22:00",
    "info": "120석 · 조용 · 개인석",
    "image": "assets/images/test.jpg",
  },
  {
    "id": 3,
    "title": "스터디룸 A",
    "status": "혼잡",
    "time": "09:00 ~ 21:00",
    "info": "6인실 · 예약필수 · 화이트보드",
    "image": "assets/images/test.jpg",
  },
  {
    "id": 4,
    "title": "스터디룸 B",
    "status": "보통",
    "time": "09:00 ~ 21:00",
    "info": "4인실 · 모니터 · 콘센트",
    "image": "assets/images/test.jpg",
  },
  {
    "id": 5,
    "title": "PC실",
    "status": "여유",
    "time": "08:00 ~ 20:00",
    "info": "40석 · 프린터 · 인터넷",
    "image": "assets/images/test.jpg",
  },
  {
    "id": 6,
    "title": "노트북존",
    "status": "보통",
    "time": "07:00 ~ 23:00",
    "info": "60석 · 콘센트 · 와이파이",
    "image": "assets/images/test.jpg",
  },
  {
    "id": 7,
    "title": "멀티미디어실",
    "status": "여유",
    "time": "09:00 ~ 18:00",
    "info": "25석 · 영상장비 · 조용",
    "image": "assets/images/test.jpg",
  },
  {
    "id": 8,
    "title": "자유열람실",
    "status": "혼잡",
    "time": "24시간",
    "info": "200석 · 자유석 · 콘센트",
    "image": "assets/images/test.jpg",
  },
  {
    "id": 9,
    "title": "세미나실 101",
    "status": "보통",
    "time": "10:00 ~ 18:00",
    "info": "12인실 · 빔프로젝터",
    "image": "assets/images/test.jpg",
  },
  {
    "id": 10,
    "title": "세미나실 102",
    "status": "여유",
    "time": "10:00 ~ 18:00",
    "info": "10인실 · 화이트보드",
    "image": "assets/images/test.jpg",
  },
  {
    "id": 11,
    "title": "제3열람실",
    "status": "보통",
    "time": "06:00 ~ 22:00",
    "info": "300석 · 조용 · 개인석",
    "image": "assets/images/test.jpg",
  },
  {
    "id": 12,
    "title": "제4열람실",
    "status": "여유",
    "time": "06:00 ~ 22:00",
    "info": "250석 · 콘센트 · 조용",
    "image": "assets/images/test.jpg",
  },
  {
    "id": 13,
    "title": "그룹스터디룸",
    "status": "혼잡",
    "time": "09:00 ~ 22:00",
    "info": "8인실 · 예약필수",
    "image": "assets/images/test.jpg",
  },
  {
    "id": 14,
    "title": "디지털자료실",
    "status": "보통",
    "time": "09:00 ~ 20:00",
    "info": "30석 · PC · 프린터",
    "image": "assets/images/test.jpg",
  },
  {
    "id": 15,
    "title": "집중학습실",
    "status": "여유",
    "time": "07:00 ~ 23:00",
    "info": "90석 · 무소음 · 개인석",
    "image": "assets/images/test.jpg",
  },
  {
    "id": 16,
    "title": "오픈라운지",
    "status": "보통",
    "time": "08:00 ~ 21:00",
    "info": "50석 · 대화가능 · 콘센트",
    "image": "assets/images/test.jpg",
  },
  {
    "id": 17,
    "title": "창가석 구역",
    "status": "여유",
    "time": "06:00 ~ 22:00",
    "info": "40석 · 창가 · 조용",
    "image": "assets/images/test.jpg",
  },
  {
    "id": 18,
    "title": "예약전용실",
    "status": "혼잡",
    "time": "09:00 ~ 19:00",
    "info": "20석 · 예약필수 · 개인석",
    "image": "assets/images/test.jpg",
  },
  {
    "id": 19,
    "title": "휴게학습존",
    "status": "보통",
    "time": "08:00 ~ 22:00",
    "info": "70석 · 대화가능 · 와이파이",
    "image": "assets/images/test.jpg",
  },
  {
    "id": 20,
    "title": "강의실 301",
    "status": "여유",
    "time": "09:00 ~ 18:00",
    "info": "45석 · 빔프로젝터 · 강의실",
    "image": "assets/images/test.jpg",
  },
];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: roomList.map((room) {
          return Container(
            margin: const EdgeInsets.only(top: 10),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 🔥 이미지
                Container(
                  height: 100,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: AssetImage(room["image"]),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                /// 🔥 텍스트 영역
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// 제목
                        Text(
                          room["title"],
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        /// 상태 + 시간 + 아이콘
                        Row(
                          children: [
                            Text(
                              room["status"],
                              style: const TextStyle(
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(room["time"]),
                            const Spacer(),
                            const Icon(Icons.chevron_right),
                          ],
                        ),

                        /// 설명
                        Text(
                          room["info"],
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(), // 🔥 중요
      ),
    );
  }
}