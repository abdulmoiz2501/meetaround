import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';
import 'package:scratch_project/app/utils/constraints/image_strings.dart';
import 'package:scratch_project/app/utils/constraints/text_strings.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/homeHeaderWidget.dart';


class HomeScreenView extends GetView {
   HomeScreenView({super.key});

   final List<Map<String, String>> itemsList = List.generate(
     10,
         (index) => {
       'image': VoidImages.testImg,
       'name': 'David $index',
     },
   );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: VoidColors.whiteColor,
        child: Column(
          children: [
            homeHeaderWidget(itemsList, 100.0,
           () {
              Get.toNamed(Routes.SUGGESTED_PEOPLE);
            }, VoidTexts.suggestPeople),

            SizedBox(
             height:20.h,),
      //        Stack(
      //   children: [
      //     Obx(
      //       () => GoogleMap(
      //         myLocationButtonEnabled: false,
      //         onMapCreated: _onMapCreated,
      //         initialCameraPosition: CameraPosition(target: locationController.currentPosition.value, zoom: 10),
      //         myLocationEnabled: true,
      //       ),
      //     ),
      //     Positioned(
      //       bottom: 220,
      //       right: 20,
      //       child: FloatingActionButton(
      //         backgroundColor: Colors.white,
      //         onPressed: _goToCurrentLocation,
      //         child: const Icon(Icons.my_location),
      //       ),
      //     ),
      //     Positioned(
      //       bottom: 0,
      //       left: 0,
      //       right: 0,
      //       child: Container(
      //         height: 249.h,
      //         decoration: BoxDecoration(
      //           color: AppColors.white,
      //           borderRadius: BorderRadius.only(
      //             topRight: Radius.circular(40.r),
      //             topLeft: Radius.circular(40.r),
      //           ),
      //         ),
      //         padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: <Widget>[
      //             Padding(
      //               padding: EdgeInsets.only(bottom: 20.h),
      //               child: Container(
      //                 width: 38.w,
      //                 height: 3.h,
      //                 decoration: BoxDecoration(
      //                   color: AppColors.navBarContainer,
      //                   borderRadius: BorderRadius.circular(25.r),
      //                 ),
      //               ),
      //             ),
      //             Obx(
      //               () => CustomTextField(
      //                 hintText: "Your location",
      //                 controller: TextEditingController(text: locationController.currentAddress.value),
      //               ),
      //             ),
      //             SizedBox(height: 20.h),
      //             const Divider(),
      //             Container(
      //               height: 90.h,
      //               width: Get.width,
      //               decoration: BoxDecoration(
      //                 color: AppColors.white,
      //               ),
      //               child: Center(
      //                 child: GestureDetector(
      //                   onTap: () {
      //                     // Navigate back with the current address
      //                     Navigator.of(context).pop(locationController.currentAddress.value);
      //                   },
      //                   child: Container(
      //                     height: 58.h,
      //                     width: 380.w,
      //                     margin: EdgeInsets.symmetric(horizontal: 18.w, vertical: 0.h),
      //                     decoration: BoxDecoration(
      //                       color: AppColors.darkPurple,
      //                       borderRadius: BorderRadius.circular(16.r),
      //                     ),
      //                     child: Center(
      //                       child: Text(
      //                         "Finish",
      //                         style: GoogleFonts.urbanist(
      //                           fontSize: 16.sp,
      //                           fontWeight: FontWeight.w700,
      //                           color: AppColors.white,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
   
   

          ],
        ),
      ),
    );
  }


}
