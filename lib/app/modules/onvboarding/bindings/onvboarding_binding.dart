import 'package:get/get.dart';

import '../controllers/onvboarding_controller.dart';

class OnvboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnvboardingController>(
      () => OnvboardingController(),
    );
  }
}
