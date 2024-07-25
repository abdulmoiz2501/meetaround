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
            homeHeaderWidget(itemsList, 100.0, () {
              Get.toNamed(Routes.SUGGESTED_PEOPLE);
            }, VoidTexts.suggestPeople),
          ],
        ),
      ),
    );
  }


}
