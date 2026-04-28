import 'package:flutter/material.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/util/navigation_util.dart';
import 'package:sitdown/widgets/common/chevron_left.dart';
import 'package:sitdown/widgets/common/profilecircle.dart';
import 'package:sitdown/widgets/myinfo/my_info_item.dart';

class MyInfoBody extends StatefulWidget {
  const MyInfoBody({Key? key}) : super(key: key);

  @override
  State<MyInfoBody> createState() => _MyInfoBodyState();
}

class _MyInfoBodyState extends State<MyInfoBody> {
  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: "김학생"); // 이름
    final idController = TextEditingController(text: "stduent1234"); // 아이디
    final emailController = TextEditingController(
      text: "student@univ.com",
    ); // 이메일
    final phoneController = TextEditingController(
      text: "010-1234-5678",
    ); // 전화번호
    final affiliationController = TextEditingController(text: "학생"); // 소속

    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ProFileCircle(),
          SizedBox(height: 12),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: () {
                print("클릭");
              },
              child: Ink(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF2FF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "프로필 사진 변경",
                  style: TextStyle(
                    color: Color(0xFF3F7FEA),
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: 20),

            child: Container(
              padding: EdgeInsets.only(left: 100, right: 100),
              child: Column(
                children: [
                  MyInfoItem(mainTitle: "이름", controller: nameController),
                  MyInfoItem(mainTitle: "아이디", controller: idController),
                  MyInfoItem(mainTitle: "이메일", controller: emailController),
                  MyInfoItem(mainTitle: "전화번호", controller: phoneController),
                  MyInfoItem(
                    mainTitle: "소속",
                    controller: affiliationController,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    width: double.infinity,
                    height: 50,

                    child: Material(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        onTap: () {
                          print("123");
                        },
                        child: Center(
                          child: Text(
                            "수정하기",
                            style: TextStyle(color: whiteColor),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
