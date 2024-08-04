import 'package:get/get.dart';
import 'package:scratch_project/app/controllers/user_controller.dart';

import '../controllers/sign_in_controller.dart';

class SignInBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SignInController>(
      SignInController(),
    );
    Get.put(UserController(), permanent: true);
  }
}
