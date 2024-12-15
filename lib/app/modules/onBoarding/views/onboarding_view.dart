// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:scratch_project/app/modules/signUp/views/sign_up_view.dart';
// import 'package:scratch_project/app/routes/app_pages.dart';
// import 'package:scratch_project/app/widgets/custom_button.dart';
// import '../../../utils/constraints/colors.dart';
// import '../../../utils/constraints/image_strings.dart';
// import '../../../utils/constraints/text_strings.dart';
// import '../../../widgets/on_boarding_widget.dart';

// class OnBoardingView extends StatelessWidget {
//   const OnBoardingView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     PageController pageController = PageController();
//     var currentIndex = 0.obs;

//     final List<Widget> onBoardingPages = [
//       OnBoardingWidget(
//         imagePath: VoidImages.firstOnBoarding,
//         text: VoidTexts.firstOnBoarding,
//         buttonText: 'MeetAround',
//         onTap: () {
//           Get.toNamed(AppPages.SIGN_UP);
//         },
//         onButtonPressed: () {
//           Get.toNamed(AppPages.SIGN_UP);
//         },
//         showNextButton: true,
//       ),
//       OnBoardingWidget(
//         imagePath: VoidImages.thirdOnBoarding,
//         text: VoidTexts.thirdOnBoarding,
//         buttonText: 'MeetAround',
//         subTitle: VoidTexts.splashTitle,
//         titleSize: 26.sp,
//         fontWeight: FontWeight.w700,
//         fontSize: 20.sp,
//         onButtonPressed: () {
//           Get.toNamed(AppPages.SIGN_UP);
//         },
//         isCenteredText: true,
//       ),
      
     
//        OnBoardingWidget(
//         imagePath: VoidImages.secOnBoarding,
//         text: VoidTexts.secOnBoarding,
//         buttonText: 'Next',
//         subTitle: VoidTexts.splashTitle,
//         fontSize: 30.sp,
//         onButtonPressed: () {
//           Get.to(SignUpView());
//         },
//       ),
//     ];

//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [VoidColors.primary, VoidColors.secondary],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//           ),
//         ),
//         child: Column(
//           children: [
//             Expanded(
//               child: Obx(() {
//                 return PageView.builder(
//                   controller: pageController,
//                   onPageChanged: (index) {
//                     currentIndex.value = index;
//                   },
//                   physics: currentIndex.value == onBoardingPages.length - 1
//                       ? NeverScrollableScrollPhysics()
//                       : AlwaysScrollableScrollPhysics(),
//                   itemCount: onBoardingPages.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return onBoardingPages[index];
//                   },
//                 );
//               }),
//             ),
//             Padding(
//               padding: EdgeInsets.only(bottom: 40.h, top: 10.h),
//               child: Obx(() {
//                 return Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: List.generate(onBoardingPages.length, (index) {
//                     return  
//                         Container(
//                           margin: EdgeInsets.symmetric(horizontal: 3.w),
//                           width: currentIndex.value == index ? 12.w : 8.w,
//                           height: currentIndex.value == index ? 12.h : 8.h,
//                           decoration: BoxDecoration(
//                             color: currentIndex.value == index
//                                 ? VoidColors.blackColor
//                                 : VoidColors.whiteColor,
//                             shape: BoxShape.circle,
//                           ),
//                         );
                        
                     
                      
                    
//                   }),
//                 );
//               }),
//             ),
            
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/modules/signUp/views/sign_up_view.dart';
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
    PageController pageController = PageController();
    var currentIndex = 0.obs;

    final List<Widget> onBoardingPages = [
      OnBoardingWidget(
        imagePath: VoidImages.firstOnBoarding,
        text: VoidTexts.firstOnBoarding,
        buttonText: 'MeetAround',
        onTap: () {
          
          Get.offAll(()=>SignUpView());
        },
        onButtonPressed: () {
          Get.offAll(()=>SignUpView());
        },
        showNextButton: true,
      ),
      OnBoardingWidget(
        imagePath: VoidImages.thirdOnBoarding,
        text: VoidTexts.thirdOnBoarding,
        buttonText: 'MeetAround',
       // subTitle: VoidTexts.splashTitle,
        titleSize: 26.sp,
        fontWeight: FontWeight.w700,
        fontSize: 20.sp,
        onButtonPressed: () {
          Get.offAll(()=>SignUpView());
        },
        isCenteredText: true,
      ),
      OnBoardingWidget(
        imagePath: VoidImages.secOnBoarding,
        text: VoidTexts.secOnBoarding,
        buttonText: 'Next',
        //subTitle: VoidTexts.splashTitle,
        fontSize: 30.sp,
        onButtonPressed: () {
          Get.offAll(()=>SignUpView());
        },
      ),
    ];

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [VoidColors.primary, VoidColors.secondary],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Obx(() {
                return PageView.builder(
                  controller: pageController,
                  onPageChanged: (index) {
                    currentIndex.value = index;
                  },
                  physics: currentIndex.value == onBoardingPages.length - 1
                      ? NeverScrollableScrollPhysics()
                      : AlwaysScrollableScrollPhysics(),
                  itemCount: onBoardingPages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return onBoardingPages[index];
                  },
                );
              }),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 40.h, top: 10.h),
              child: Obx(() {
                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(onBoardingPages.length, (index) {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 3.w),
                          width: currentIndex.value == index ? 12.w : 8.w,
                          height: currentIndex.value == index ? 12.h : 8.h,
                          decoration: BoxDecoration(
                            color: currentIndex.value == index
                                ? VoidColors.blackColor
                                : VoidColors.whiteColor,
                            shape: BoxShape.circle,
                          ),
                        );
                      }),
                    ),

                    if(currentIndex.value==0)
                    SizedBox(height:40.h ,)
                    else if(currentIndex.value==1)
                    SizedBox(height: 20.h,)
                    else SizedBox(height: 30.h,),
                    //currentIndex.value==2?SizedBox(height: 20.h):SizedBox(height: 30.h), // Space between dots and text
                    if (currentIndex.value == 0)
                      Center(
                        child: Text(
            'MeetAround',
            style: GoogleFonts.poppins(
              fontSize: 15.spMax,
              color: VoidColors.whiteColor,
              fontWeight: FontWeight.w600,
            ),
          ),
                      ),
                       if (currentIndex.value == 1)
                      Center(
                        child: Text(
            'MeetAround',
            style: GoogleFonts.poppins(
              fontSize: 30.spMax,
              color: VoidColors.whiteColor,
              fontWeight: FontWeight.w600,
            ),
          ),
                      ),
                    if (currentIndex.value == 2)
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding:  EdgeInsets.only(right: 20.w),
                          child: SizedBox(
                                       // height: 30.h,
                                        child: CustomButton(
                                          text: "Next",
                                          height: 30.h,
                                          width: 123.w,
                                          onPressed: (){
                                            Get.offAll(()=>SignUpView());
                                          },
                                          textColor: VoidColors.blackColor,
                                          color: VoidColors.whiteColor,
                                          borderRadius: 40.0.r,
                                        ),
                                      ),
                        )
                      ),
                  ],
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
