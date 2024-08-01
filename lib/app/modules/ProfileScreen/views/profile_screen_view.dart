import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scratch_project/app/utils/constants.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';
import '../controllers/profile_screen_controller.dart';

class ProfileScreenView extends GetView<ProfileScreenController> {
  const ProfileScreenView({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    // final ProfileScreenController controller = Get.put(ProfileScreenController()); // Initialize controller
    final ProfileScreenController controller = Get.put(ProfileScreenController());
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          height: 32.h,
          width: 32.w,
          child: Center(
            child: SvgPicture.asset(
              "assets/icons/left_arrow.svg",
              height: 16.h,
              width: 8.w,
              colorFilter: ColorFilter.mode(VoidColors.blackColor, BlendMode.srcIn),
            ),
          ),
        ),
        title: Text(
          'Your Profile',
          style: GoogleFonts.poppins(
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
            color: VoidColors.blackColor,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 40.h,
                child: Row(
                  children: List.generate(2, (index) {
                    return Expanded(
                      child: Obx(() {
                        return GestureDetector(
                          onTap: () {
                            controller.selectIndex(index);
                          },
                          child: Container(
                            height: 20.h,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: controller.selectedIndex.value == index
                                      ? VoidColors.secondary
                                      : VoidColors.grey3,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            child: Text(
                              profileTabs[index],
                              style: GoogleFonts.ibmPlexSans(
                                color: controller.selectedIndex.value == index
                                    ? VoidColors.secondary
                                    : VoidColors.grey3,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  }),
                ),
              ),
             Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Obx((){
                  return  controller.selectedIndex.value == 0
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        Center(
                          child: Container(
                            height: 90.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100.r),
                              child: Image.asset(
                                "assets/images/profile.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/coin.png',
                              height: 20.r,
                              width: 20.r,
                            ),
                            Text(
                              "10",
                              style: GoogleFonts.manrope(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: VoidColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                        
                        SizedBox(height: 10.h,),
                        Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Jessica Sympson",
                                style: GoogleFonts.manrope(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w400,
                                  color: VoidColors.blackColor,
                                ),
                              ),
                              Text(
                                "Coins Earned : 567",
                                style: GoogleFonts.manrope(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: VoidColors.blackColor,
                                ),
                              ),
                              Text(
                                "Popup , Jazz",
                                style: GoogleFonts.manrope(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: VoidColors.blackColor,
                                ),
                              ),
                              Text(
                                "Interactions Completed : 40",
                                style: GoogleFonts.manrope(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: VoidColors.blackColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                       
                       SizedBox(height: 30.h,),
                        Text(
                          "Photos",
                          style: GoogleFonts.manrope(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: VoidColors.blackColor,
                          ),
                        ),
                        
                        SizedBox(height: 20.h,),
                        Center(
                          child: Container(
                            height: 272.h,
                            width: 272.w,
                            child: Image.asset("assets/images/photo.png"),
                          ),
                        ),
                        SizedBox(height: 40.h,),
                        Text(
                          "Music Genres:",
                          style: GoogleFonts.manrope(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: VoidColors.blackColor,
                          ),
                        ),
                        SizedBox(height: 20.h,),
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
                                      color:  VoidColors.blackColor,
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
                      ],
                    )
                 
                  :  Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                      children: [

                         SizedBox(height: 10.h),
                        Center(
                          child: Stack(
                            children: [
                              Obx(() {
                                return Container(
                                  height: 78.h,
                                  width: 78.w,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: VoidColors.grey4,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100.r),
                                    child: controller.pickedImage.value != null
                                        ? Image.file(
                                            controller.pickedImage.value!,
                                            fit: BoxFit.cover,
                                          )
                                        : Container(
                                          color: Colors.transparent,
                                        )
                                  ),
                                );
                              }),

                              Positioned(
                                bottom: 0,
                                right: 8,
                                child: GestureDetector(
                                  onTap: () {
                                    controller.pickImage();
                                  },
                                  child: Container(
                                    height: 20.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: VoidColors.green
                                    ),
                                    child: Center(
                                      child: Icon(
                                        Icons.add,
                                        color: VoidColors.whiteColor,
                                        size: 10.r,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),),
                        SizedBox(height: 10.h,),
                         Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              'assets/icons/coin.png',
                              height: 20.r,
                              width: 20.r,
                            ),


                            Text(
                              "10",
                              style: GoogleFonts.manrope(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: VoidColors.blackColor,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h,),
                                     GestureDetector(
              onTap: (){
                controller.toggleOnlline();
              },
               child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                       height: 44.h,
                       width: 129.w,
                       decoration: BoxDecoration(
                         color: VoidColors.whiteColor,
                         borderRadius: BorderRadius.circular(10.r),
                         boxShadow: [
                           BoxShadow(
                             color: Colors.black.withOpacity(0.1),
                             offset: Offset(0, 4), // Shadow is applied only downward
                             blurRadius: 8.0, // Adjust the blur radius to control the spread of the shadow
                             spreadRadius: 0.0,
                           ),
                         ],
                       ),
                       child: Obx((){
                         return Center(
                           child: Text(
                           "Online",style: GoogleFonts.poppins(
                             fontWeight: FontWeight.w400,
                             fontSize: 20.sp,
                             color: controller.isOnline.value?VoidColors.secondary:VoidColors.grey5
                           ),
                                                ),
                         );
                       })
                     ),
                  
               SizedBox(width: 20.w,),
                Container(
                 height: 44.h,
                 width: 129.w,
                 decoration: BoxDecoration(
                   color: VoidColors.whiteColor,
                   borderRadius: BorderRadius.circular(10.r),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black.withOpacity(0.1),
                       offset: Offset(0, 4), // Shadow is applied only downward
                       blurRadius: 8.0, // Adjust the blur radius to control the spread of the shadow
                       spreadRadius: 0.0,
                     ),
                   ],
                 ),
                  child:  Obx((){
                   return Center(
                     child: Text(
                     "Away",style: GoogleFonts.poppins(
                       fontWeight: FontWeight.w400,
                       fontSize: 20.sp,
                       color: controller.isOnline.value?VoidColors.grey5:VoidColors.secondary
                     ),
                       ),
                   );
                 })
               )
                ],
               ),
             ),
           SizedBox(height: 10.h,),
             Align(
              alignment: Alignment.topLeft,
               child: Text(
                       "Gender (required)",style: GoogleFonts.poppins(
               
                         fontWeight: FontWeight.w700,
                         fontSize: 16.sp,
                         color: VoidColors.blackColor
                       ),
                         ),
             ),

 Text(
                     "Select the gender that best represents who you are. Your choice is an important aspect of your identity, helping others understand and respect your individuality.",style: GoogleFonts.poppins(

                       fontWeight: FontWeight.w400,
                       fontSize: 12.sp,
                     color: VoidColors.lightGrey1
                     ),
                       ),
SizedBox(height: 20.h,),
                      SizedBox(
      height: 210,
      child:ListView.builder(
        itemCount: 3,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
        
          return Obx((){
              bool isSelected = controller.selectedGender.value == index;
            return  GestureDetector(
              onTap: (){
              // controller.selectGender(index); // Update selected gender
              },
              child: Padding(
                padding:  EdgeInsets.only(bottom: 10.h),
                child: Container(
                height: 58.79,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: Colors.grey[200],
                ),
                child: InkWell(
                  onTap: () {
                  controller.selectGender(index); // Update selected ge
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              genderIcon[index],
                              height: 22.05,
                              width: 22.05,
                              colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
                            ),
                            SizedBox(width: 5),
                            Text(
                              gender[index],
                              style: GoogleFonts.poppins(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                        SvgPicture.asset(
                    isSelected
                              ? 'assets/icons/radio.svg' 
                              : 'assets/icons/unselectedR.svg', 
                          height: 22.05,
                          width: 22.05,
                        ),
                      ],
                    ),
                  ),
                ),
                          ),
              ),
            );
      
          });
        },
      ),
                    
                      ),
                      SizedBox(height: 10.h,),
                       Align(
              alignment: Alignment.topLeft,
               child: Text(
                       "Photos",style: GoogleFonts.poppins(
               
                         fontWeight: FontWeight.w700,
                         fontSize: 16.sp,
                         color: VoidColors.blackColor
                       ),
                         ),
             ),
              Text(
                       "Choose a clear, well-lit photos where your face is easily visible. It's your first impression, so make it count!",style: GoogleFonts.poppins(
               
                         fontWeight: FontWeight.w400,
                         fontSize: 12.sp,
                         color: VoidColors.lightGrey1
                       ),
                         ),
SizedBox(height: 30.h,),
                        Container(
                          height: 200.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),

                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.r),
 
                            child: Image.asset("assets/images/girl.png")),
                            
                        ),
                         SizedBox(height: 30.h,),
                       Align(
              alignment: Alignment.topLeft,
               child: Text(
                       "Music Genres:",style: GoogleFonts.poppins(
               
                         fontWeight: FontWeight.w700,
                         fontSize: 16.sp,
                         color: VoidColors.blackColor
                       ),
                         ),
             ),
                        SizedBox(height: 20.h,),
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
                                      color:  VoidColors.blackColor,
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

                      ],
                    );

                
                }),



              ],
             ) , 
                    SizedBox(height: 200.h,),
            ],
          ),
        ),
      ),
    );
  }
}
