import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/utils/constants.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';

import '../controllers/jamming_screen_controller.dart';

class JammingScreenView extends StatelessWidget {
  JammingScreenView({Key? key}) : super(key: key);

  final JammingScreenController controller = Get.put(JammingScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.h,
        leading: IconButton(
          splashRadius: 20.r,
          icon: Icon(
            Icons.arrow_back,
            size: 20.r,
            color: VoidColors.whiteColor,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          "Jamming session",
          style: GoogleFonts.poppins(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: VoidColors.whiteColor,
          ),
        ),
        actions: [
          IconButton(
            icon: SvgPicture.asset("assets/icons/call.svg"),
            onPressed: () {},
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: VoidColors.primary,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [VoidColors.primary, VoidColors.secondary],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Container(
                  width: double.infinity,
                  height: 282.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Image.asset(
                      "assets/images/music.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(
                      () => Container(
                        width: 160.w,
                        height: 46.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: VoidColors.lightTransparent.withOpacity(0.3),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15.w),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              value: controller.selectedSong.value.isEmpty
                                  ? musicGeneres[0]
                                  : controller.selectedSong.value,
                              icon: SvgPicture.asset(
                                "assets/icons/dropdoen.svg",
                                width: 9.28.w,
                                height: 7.13.h,
                                colorFilter: ColorFilter.mode(
                                    VoidColors.whiteColor, BlendMode.srcIn),
                              ),
                              iconSize: 24.sp,
                              elevation: 16,
                              style: TextStyle(color: Colors.white),
                              dropdownColor: VoidColors.primary,
                              onChanged: (String? newValue) {
                                controller.setSelectedSong(newValue!);
                              },
                              items: musicGeneres
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.poppins(
                                      fontSize: 14.sp,
                                      color: VoidColors.whiteColor,
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Leave",
                      style: GoogleFonts.poppins(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: VoidColors.grey2,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
             ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: songs.length, // or however many items you have
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        controller.setSelectedSongIndex(index);
                      },
                      child:
                      Obx((){
                        return  Container(
                        margin: EdgeInsets.symmetric(vertical: 5.h),
                        decoration: BoxDecoration(
                          color: controller.selectedSongIndex.value == index
                              ? VoidColors.whiteColor.withOpacity(0.08)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.h, horizontal: 10.w),
                          child: Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(
                                    "assets/images/songImg.png",
                                    height: 21.h,
                                    width: 23.w,
                                  ),
                                  SizedBox(width: 13.w),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        songs[index],
                                        style: GoogleFonts.roboto(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          color: VoidColors.whiteColor,
                                        ),
                                      ),
                                      SizedBox(height: 8.h),
                                      Text(
                                        singer[index],
                                        style: GoogleFonts.roboto(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400,
                                          color: VoidColors.whiteColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Center(
                                child: GestureDetector(
                                  onTap: () {
                                    if (controller
                                            .selectedSongIndex.value ==
                                        index) {
                                      controller.togglePlaying();
                                    } else {
                                      controller.setSelectedSongIndex(index);
                                      if (!controller.isPlaying.value) {
                                        controller.togglePlaying();
                                      }
                                    }
                                  },
                                  child: Container(
                                    height: 35.h,
                                    width: 35.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: VoidColors.whiteColor,
                                    ),
                                    child: Center(
                                      child: controller.isPlaying.value &&
                                              controller
                                                      .selectedSongIndex
                                                      .value ==
                                                  index
                                          ? Icon(
                                              Icons.pause,
                                              color: VoidColors.secondary,
                                            )
                                          : SvgPicture.asset(
                                              "assets/icons/pausee.svg",
                                              height: 20.h,
                                              width: 20.w,
                                              colorFilter: ColorFilter.mode(
                                                  VoidColors.secondary,
                                                  BlendMode.srcIn),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                   
                      })
                    );
                  },
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: VoidColors.whiteColor,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            children: [
              Image.asset(
                "assets/images/song.png",
                width: 37.w,
                height: 37.h,
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "From Me to You - Mono / Remastered",
                      style: GoogleFonts.poppins(
                        fontSize: 13.5.sp,
                        fontWeight: FontWeight.w600,
                        color: VoidColors.blackColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      "BEATSPILL+",
                      style: GoogleFonts.poppins(
                        fontSize: 10.5.sp,
                        fontWeight: FontWeight.w400,
                        color: VoidColors.blackColor,
                      ),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  controller.togglePlaying();
                },
                child: Container(
                  height: 35.h,
                  width: 35.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: VoidColors.secondary,
                  ),
                  child: Center(
                    child: Obx(
                      () => controller.isPlaying.value
                          ? Icon(
                              Icons.pause,
                              color: VoidColors.whiteColor,
                            )
                          : SvgPicture.asset(
                              "assets/icons/pausee.svg",
                              height: 20.h,
                              width: 20.w,
                              colorFilter: ColorFilter.mode(
                                  VoidColors.whiteColor, BlendMode.srcIn),
                            ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
