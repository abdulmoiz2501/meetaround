import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/constraints/colors.dart';

class SignUpController extends GetxController {
  //TODO: Implement SignUpController

  var accept = false.obs;
  Rx<XFile?> imgFile = Rx<XFile?>(null);
  var isImgPicked = false.obs;

  void toggleAccept() {
    accept.value = !accept.value;
  }


  void pickPicture() async {
    try {
      final ImagePicker picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        // invoiceFile.value = pickedFile; // Set the observable variable
        imgFile.value = XFile(pickedFile.path);
        isImgPicked(true);
      } else {
        imgFile.value = null;
        isImgPicked(false);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred while picking an image: $e',
          backgroundColor: VoidColors.secondary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    }
  }


  // void increment() => count.value++;
}
