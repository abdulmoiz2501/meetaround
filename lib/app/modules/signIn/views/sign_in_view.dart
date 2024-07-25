import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../routes/app_pages.dart';
import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/image_strings.dart';
import '../../../utils/constraints/text_strings.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_textform_field.dart';
import '../controllers/sign_in_controller.dart';

class SignInView extends GetView<SignInController> {
  const SignInView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VoidColors.whiteColor,
      body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 60.0.h,),
              Image.asset(VoidImages.secSplash, height: 100.h, width: 100.w,),
              Padding(
                padding: EdgeInsets.only(top: 20.0.h, bottom: 25.0.h),
                child: Text(
                  VoidTexts.signUpTitle,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                      fontSize: 24.spMax,
                      color: VoidColors.blackColor,
                      fontWeight: FontWeight.w600
                  ),
                ),
              ),

              SizedBox(height: 40.0.h,),
              CustomTextFormField(
                obscureText: false,
                hint: 'Email',
                prefix: Icon(Icons.email_outlined,
                  size: 24.sp, color: VoidColors.darkGrey,),),

              CustomTextFormField(
                obscureText: false,
                hint: 'Password',
                prefix: Icon(Icons.lock_outline,
                  size: 24.sp, color: VoidColors.darkGrey,),),

              SizedBox(height: 30.0.h,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: CustomButton(
                  text: VoidTexts.signIn,
                  onPressed: () {
                    Get.toNamed(Routes.BOTTOM_NAV_BAR);
                  },
                  borderRadius: 24.r,

                ),
              ),

              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                          height: 0.5,
                          color: VoidColors.darkGrey
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: 10.w,
                      ),
                      child: Text(
                          'Or Continue with',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                              color: VoidColors.darkGrey,
                            ),
                          )
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 0.5,
                        color: VoidColors.darkGrey,
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                height: 48.h,
                margin: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 15.0.h),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: VoidColors.lightGrey,
                  borderRadius: BorderRadius.circular(5.0.r),
                ),
                child: Center(
                  child: Image.asset(VoidImages.googleIcon,
                    height: 32.h, width: 32.w,),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    VoidTexts.noAccount,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                        fontSize: 12.spMax,
                        color: VoidColors.darkGrey,
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  InkWell(
                    onTap: () {

                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 5.0.h),
                      child: Text(
                        VoidTexts.signUp,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.poppins(
                            fontSize: 12.spMax,
                            decoration: TextDecoration.underline,
                            color: VoidColors.blueColor,
                            fontWeight: FontWeight.w400
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ).marginOnly(bottom: 30.0.h)
      ),
    );
  }
}
