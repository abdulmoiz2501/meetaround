import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/routes/app_pages.dart';
import 'package:scratch_project/app/widgets/custom_button.dart';
import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/image_strings.dart';
import '../../../utils/constraints/text_strings.dart';
import '../../../widgets/on_boarding_widget.dart';



class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    SwiperController swiperController = SwiperController();
    var currentIndex = 0.obs;


    final List<Widget> onBoardingPages = [
      OnBoardingWidget(
        imagePath: VoidImages.firstOnBoarding,
        text: VoidTexts.firstOnBoarding,
        buttonText: 'Next',
        onTap: () {
          Get.toNamed(AppPages.SIGN_UP);
        },
        onButtonPressed: () {
          swiperController.next();
        },
        showNextButton: true,
      ),
      OnBoardingWidget(
        imagePath: VoidImages.secOnBoarding,
        text: VoidTexts.secOnBoarding,
        buttonText: 'Next',
        subTitle: VoidTexts.splashTitle,
        fontSize: 30.sp,
        onButtonPressed: () {
          swiperController.next();
        },
        isCenteredText: true,
      ),
      OnBoardingWidget(
        imagePath: VoidImages.thirdOnBoarding,
        text: VoidTexts.thirdOnBoarding,
        buttonText: 'Get Started',
        subTitle: VoidTexts.splashTitle,
        titleSize: 26.sp,
        fontWeight: FontWeight.w700,
        fontSize: 20.sp,
        onButtonPressed: () {
          Get.toNamed(AppPages.SIGN_UP);
        },
        isCenteredText: true,
      ),
    ];

    // final List<Widget> walkThroughPages = [
    //   FirstOnBoardingView(swiperController: swiperController,),
    //   SecOnBoardingView(),
    //   ThirdOnBoardingView(),
    // ];

    return Scaffold(
      // appBar: AppBar(
      //   actions: [
      //     TextButton(
      //       onPressed: () {
      //         // Get.to(() => Login());
      //         print("Skip pressed");
      //       },
      //       child: Text(
      //         "Skip",
      //         style: GoogleFonts.poppins(
      //           fontWeight: FontWeight.w400,
      //           fontSize: 20.spMax,
      //           color: VoidColors.whiteColor,
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [VoidColors.primary, VoidColors.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            // stops: [0.6, 1],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 5.0.h), // Add padding to push up the progress indicator
                child: Swiper(
                  itemBuilder: (BuildContext context, int index) {
                    return onBoardingPages[index];
                  },
                  itemCount: onBoardingPages.length,
                  pagination: SwiperPagination(
                    alignment: Alignment.bottomCenter,
                    margin: EdgeInsets.only(bottom: 160.h),
                    builder: const DotSwiperPaginationBuilder(
                      color: VoidColors.whiteColor,
                      activeColor: VoidColors.blackColor,
                    ),
                  ),
                  controller: swiperController,
                  onIndexChanged: (index) {

                      currentIndex.value = index;
                      if (index == onBoardingPages.length -1) {
                        // Get.toNamed(AppPages.SIGN_UP);
                        Future.delayed(Duration(seconds: 2), () {
                          Get.toNamed(AppPages.SIGN_UP);
                        }
                        );
                      }

                  },
                ),
              ),
            ),
            // CustomButton(),
            // SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}



// class FirstOnBoardingView extends StatelessWidget {
//   final SwiperController swiperController;
//   const FirstOnBoardingView({super.key, required this.swiperController});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  Padding(
//       padding: EdgeInsets.only(top: 72.h, right: 25.0.w, left: 25.0.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               TextButton(
//                 onPressed: () {
//                   // Get.to(() => Login());
//                   print("Skip pressed");
//                 },
//                 child: Text(
//                   "Skip",
//                   style: GoogleFonts.poppins(
//                     fontWeight: FontWeight.w400,
//                     fontSize: 15.spMax,
//                     color: VoidColors.whiteColor,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           Expanded(
//             child: SizedBox(
//               height: 202.h,
//               width: 285.w,
//               child: Image.asset(VoidImages.firstOnBoarding),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               VoidTexts.firstOnBoarding,
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                   fontSize: 15.spMax,
//                   color: VoidColors.whiteColor,
//                   fontWeight: FontWeight.w400
//               ),
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(vertical: 15.0.h),
//                 child: CustomButton(
//                   text: 'Next',
//                   width: 123.w,
//                   onPressed: () {
//                     swiperController.next();
//                   },
//                   textColor: VoidColors.blackColor,
//                   color: VoidColors.whiteColor,
//                   borderRadius: 40.0.r,
//
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class SecOnBoardingView extends StatelessWidget {
//   const SecOnBoardingView({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  Padding(
//       padding: EdgeInsets.only(top: 72.h, right: 25.0.w, left: 25.0.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: SizedBox(
//               height: 202.h,
//               width: 285.w,
//               child: Image.asset(VoidImages.secOnBoarding),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               VoidTexts.thirdOnBoarding,
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                   fontSize: 15.spMax,
//                   color: VoidColors.whiteColor,
//                   fontWeight: FontWeight.w400
//               ),
//             ),
//           ),
//           Center(
//             child: Padding(
//               padding: EdgeInsets.only(bottom: 30.0.h),
//               child: Text(
//                 VoidTexts.splashTitle,
//                 textAlign: TextAlign.center,
//                 style: GoogleFonts.poppins(
//                     fontSize: 30.spMax,
//                     color: VoidColors.whiteColor,
//                     fontWeight: FontWeight.w600
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class ThirdOnBoardingView extends StatelessWidget {
//   const ThirdOnBoardingView({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return  Padding(
//       padding: EdgeInsets.only(top: 72.h, right: 25.0.w, left: 25.0.w),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: SizedBox(
//               height: 202.h,
//               width: 285.w,
//               child: Image.asset(VoidImages.thirdOnBoarding),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               VoidTexts.thirdOnBoarding,
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                   fontSize: 26.spMax,
//                   color: VoidColors.whiteColor,
//                   fontWeight: FontWeight.w700
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.only(bottom: 30.0.h),
//             child: Text(
//               VoidTexts.splashTitle,
//               textAlign: TextAlign.center,
//               style: GoogleFonts.poppins(
//                   fontSize: 20.spMax,
//                   color: VoidColors.whiteColor,
//                   fontWeight: FontWeight.w600
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



