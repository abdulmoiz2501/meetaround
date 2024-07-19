import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scratch_project/app/modules/signUp/views/welcome_view.dart';
import 'package:scratch_project/app/widgets/music_genres_tile_widget.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/image_strings.dart';
import '../../../utils/constraints/text_strings.dart';
import '../../../widgets/clickable_tile.dart';
import '../../../widgets/custom_button.dart';
import '../controllers/sign_up_controller.dart';



class GetUserLocationView extends StatefulWidget {

  const GetUserLocationView({super.key});

  @override
  State<GetUserLocationView> createState() => _GetUserLocationViewState();
}

class _GetUserLocationViewState extends State<GetUserLocationView> {
  final signUpController = Get.put(SignUpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VoidColors.whiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: SizedBox(
            width: 32.w,
            height: 32.h,
            child: Image.asset(VoidImages.backArrow),
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                  child: Text(
                    VoidTexts.getLocationTitle,
                    // textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 32.spMax,
                        color: VoidColors.secondary,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ),
                // Spacer(),

                Center(
                  child: Image.asset(VoidImages.getLocation,
                  height: 150.h,
                  width: 150.w,),
                ),

              ],
            ),
          ),
          SizedBox(height: 150.0.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: CustomButton(
              text: 'Next',
              onPressed: () {
                Get.toNamed(Routes.WELCOME);
              },
              borderRadius: 24.r,

            ),
          ),

          SizedBox(height: 20.0.h,)



        ],
      ),
    );
  }
}

