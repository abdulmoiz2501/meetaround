import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
   await GetStorage.init();
  runApp(
    ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          title: "Application",
          debugShowCheckedModeBanner: false,
          initialRoute: AppPages.SPLASH_SCREEN,
        //  initialRoute: AppPages.BOTTOM_NAV_BAR,
          getPages: AppPages.routes,
        );
      },
    ),
  );
}
