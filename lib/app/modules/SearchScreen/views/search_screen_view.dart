import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/modules/ProfileScreen/controllers/profile_screen_controller.dart';
import 'package:scratch_project/app/modules/SearchScreen/controllers/search_screen_controller.dart';
import 'package:scratch_project/app/modules/signIn/controllers/sign_in_controller.dart';
import 'package:scratch_project/app/routes/app_pages.dart';
import 'package:scratch_project/app/utils/constants.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';
import 'package:scratch_project/app/utils/constraints/image_strings.dart';
import 'package:scratch_project/app/utils/constraints/text_strings.dart';
import 'package:scratch_project/app/widgets/homeHeaderWidget.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Map<String, String>> itemsList = List.generate(
    10,
    (index) => {
      'image': VoidImages.testImg,
      'name': 'David $index',
    },
  );

  final SignInController signInController = Get.put(SignInController());
  final SearchScreenController searchController = Get.put(SearchScreenController());
  final ProfileScreenController controller = Get.put(ProfileScreenController());

  @override
  void initState() {
    super.initState();
    searchController.fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: VoidColors.whiteColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              homeHeaderWidget2(
                itemsList,
                100.0,
                () {
                  Get.toNamed(Routes.SUGGESTED_PEOPLE);
                },
                VoidTexts.suggestPeople,
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: searchController.users.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(bottom: 20.h),
                    child: Container(
                      height: 750.h,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Image.asset(
                            "assets/images/girl2.png",
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 400.h,
                            right: 25.w,
                            child: Container(
                              width: ScreenUtil().screenWidth - 50.w,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.h),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Music Genres:",
                                      style: GoogleFonts.manrope(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: VoidColors.blackColor,
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Wrap(
                                      spacing: 10.w,
                                      runSpacing: 10.h,
                                      children: List.generate(musicGeners.length, (index) {
                                        return GestureDetector(
                                          onTap: () {
                                            controller.toggleMusicGenre(index);
                                          },
                                          child: Obx(() {
                                            bool isSelected = controller.selectedMusicGenres.contains(index);
                                            return Container(
                                              padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 5.5.h),
                                              height: 28.h,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50.r),
                                                color: isSelected ? VoidColors.secondary : VoidColors.whiteColor,
                                                border: Border.all(
                                                  color: VoidColors.grey2,
                                                ),
                                              ),
                                              child: Text(
                                                musicGeners[index],
                                                style: GoogleFonts.poppins(
                                                  fontSize: 10.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: isSelected ? VoidColors.whiteColor : VoidColors.blackColor,
                                                ),
                                              ),
                                            );
                                          }),
                                        );
                                      }),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        searchController.fetchUsers();
                                        print(searchController.users);
                                      },
                                      child: Container(
                                        height: 40.h,
                                        width: 90.w,
                                        color: Colors.black,
                                        child: Text(
                                          signInController.id.value,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 56.h,
                                          width: 56.w,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: VoidColors.lightGrey,
                                          ),
                                          child: Center(
                                            child: SvgPicture.asset(
                                              "assets/icons/chat1.svg",
                                              height: 30.h,
                                              width: 30.w,
                                              colorFilter: ColorFilter.mode(VoidColors.secondary, BlendMode.srcIn),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 20.w),
                                        GestureDetector(
                                          onTap: () {
                                            searchController.fetchUsers();
                                            print(searchController.users);
                                          },
                                          child: Container(
                                            height: 56.h,
                                            width: 56.w,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: VoidColors.secondary,
                                            ),
                                            child: Center(
                                              child: SvgPicture.asset(
                                                "assets/icons/music.svg",
                                                height: 30.h,
                                                width: 30.w,
                                                colorFilter: ColorFilter.mode(VoidColors.whiteColor, BlendMode.srcIn),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
