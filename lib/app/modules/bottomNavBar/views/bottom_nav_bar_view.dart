import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:scratch_project/app/modules/bottomNavBar/views/home_screen_view.dart';

import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/image_strings.dart';
import '../controllers/bottom_nav_bar_controller.dart';

class BottomNavBarView extends GetView<BottomNavBarController> {
  BottomNavBarView({super.key});
  final BottomNavBarController bottomNavBarController = Get.put(BottomNavBarController());

  final List<Widget> _pages = [
    HomeScreenView(),
    FavouriteScreen(),
    SearchScreen(),
    MessageScreen(),
    PersonScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: VoidColors.whiteColor,
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: Obx(() =>
          AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _pages[bottomNavBarController.selectedIndex.value]),
      ),
      bottomNavigationBar: Container(
        height: 80.h,
        decoration: const BoxDecoration(
          color: VoidColors.bottomNavColor,
        ),
        child: Obx(() =>
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildNavItem(VoidImages.homeIcon, 0, bottomNavBarController),
                _buildNavItem(VoidImages.favouriteIcon, 1, bottomNavBarController),
                _buildNavItem(VoidImages.searchIcon, 2, bottomNavBarController),
                _buildNavItem(VoidImages.msgIcon, 3, bottomNavBarController),
                _buildNavItem(VoidImages.personIcon, 4, bottomNavBarController),
              ],
            ),
        ),
      ),
    );
  }

  Widget _buildNavItem(String asset, int index, BottomNavBarController controller, {double? size}) {
    return GestureDetector(
      onTap: () {
        controller.changeIndex(index);
      },
      child: Container(
        width: 28.w,
        color: Colors.transparent,
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                      asset,
                      width: controller.selectedIndex.value == index ? (size ?? 29.sp) : (size ?? 28.sp),
                      height: controller.selectedIndex.value == index ? (size ?? 29.sp) : (size ?? 28.sp),
                      color: controller.selectedIndex.value == index ?
                      VoidColors.secondary : null
                  ),
                  controller.selectedIndex.value == index
                      ? const SelectBar()
                      : const SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectBar extends StatelessWidget {
  const SelectBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(top: 5),
        height: 2.h,
        // width: isActive ? 6 : 0,
        width: 52.w,
        decoration: const BoxDecoration(
          color: VoidColors.secondary,
        ));
  }
}



// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: Text('Home Screen')),
//     );
//   }
// }

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Favourite Screen')),
    );
  }
}

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Search Screen')),
    );
  }
}

class PersonScreen extends StatelessWidget {
  const PersonScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Person Screen')),
    );
  }
}

class MessageScreen extends StatelessWidget {
  const MessageScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Message Screen')),
    );
  }
}
