import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sitdown/api/user_api.dart';
import 'package:sitdown/constants/app_colors.dart';
import 'package:sitdown/providers/auth_provider.dart';
import 'package:sitdown/widgets/common/profilecircle.dart';
import 'package:sitdown/widgets/myinfo/my_info_item.dart';

class MyInfoBody extends StatefulWidget {
  const MyInfoBody({Key? key}) : super(key: key);

  @override
  State<MyInfoBody> createState() => _MyInfoBodyState();
}

class _MyInfoBodyState extends State<MyInfoBody> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController affiliationController;

  final ImagePicker picker = ImagePicker();

  XFile? selectedImage;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    affiliationController = TextEditingController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final myInfo = context.watch<AuthProvider>().myInfo;

    nameController.text = myInfo?['name']?.toString() ?? '';
    emailController.text = myInfo?['email']?.toString() ?? '';
    phoneController.text = myInfo?['phone']?.toString() ?? '';
    affiliationController.text =
        myInfo?['affiliation']?.toString() ?? 'UNDERGRADUATE';
  }

  String convertAffiliation(String value) {
    switch (value.trim()) {
      case '학생':
      case '학부생':
        return 'UNDERGRADUATE';
      case '대학원생':
        return 'GRADUATE';
      case '교직원':
        return 'FACULTY';
      case '조교':
        return 'ASSISTANT';
      case '외부인':
        return 'EXTERNAL';
      default:
        return value.trim().isEmpty ? 'UNDERGRADUATE' : value.trim();
    }
  }

  Future<void> pickProfileImage() async {
    try {
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image == null) return;

      setState(() {
        selectedImage = image;
      });

      print("선택한 이미지 경로: ${image.path}");
    } catch (e) {
      print("이미지 선택 에러: $e");

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("이미지를 선택할 수 없습니다.")));
    }
  }

  Future<void> updateMyProfile() async {
    final accessToken = context.read<AuthProvider>().accessToken ?? '';

    if (accessToken.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("로그인이 필요합니다.")));
      return;
    }

    try {
      setState(() {
        isLoading = true;
      });

      print("1. 기본 정보 수정 시작");

      final updatedUser = await UserApi.updateMyInfo(
        accessToken: accessToken,
        name: nameController.text.trim(),
        phone: phoneController.text.trim(),
        affiliation: convertAffiliation(affiliationController.text),
      );

      print("2. 기본 정보 수정 완료");

      if (selectedImage != null) {
        print("3. 이미지 업로드 시작");

        final uploadedUser = await UserApi.uploadProfileImage(
          accessToken: accessToken,
          imageFile: selectedImage!,
        );

        print("4. 이미지 업로드 완료");

        context.read<AuthProvider>().setMyInfo(uploadedUser);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("회원정보가 수정되었습니다.")));
    } catch (e) {
      print("회원정보 수정 에러: $e");

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString().replaceAll("Exception: ", ""))),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  Widget buildProfileImage() {
    if (selectedImage != null) {
      return ClipOval(
        child: Image.network(
          selectedImage!.path,
          width: 54,
          height: 54,
          fit: BoxFit.cover,
        ),
      );
    }

    return const ProFileCircle();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    affiliationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          buildProfileImage(),

          const SizedBox(height: 12),

          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(8),
              onTap: isLoading ? null : pickProfileImage,
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
            margin: const EdgeInsets.only(top: 20),
            padding: const EdgeInsets.only(left: 100, right: 100),
            child: Column(
              children: [
                MyInfoItem(mainTitle: "이름", controller: nameController),
                MyInfoItem(mainTitle: "이메일", controller: emailController),
                MyInfoItem(mainTitle: "전화번호", controller: phoneController),
                MyInfoItem(mainTitle: "소속", controller: affiliationController),

                Container(
                  margin: const EdgeInsets.only(top: 20),
                  width: double.infinity,
                  height: 50,
                  child: Material(
                    color: isLoading ? greyColor : primaryColor,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: isLoading ? null : updateMyProfile,
                      borderRadius: BorderRadius.circular(10),
                      child: Center(
                        child: isLoading
                            ? const CircularProgressIndicator(
                                color: whiteColor,
                                strokeWidth: 2,
                              )
                            : Text("수정하기", style: TextStyle(color: whiteColor)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
