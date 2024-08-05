import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:scratch_project/app/controllers/user_controller.dart';
import 'package:scratch_project/app/utils/constants.dart';

class ProfileScreenController extends GetxController {
  var selectedIndex = 0.obs;
  var isOnline = true.obs;
  var selectedMusicGenres = <String>[].obs;
  var pickedImage = Rxn<File>();
  var gender = 3.obs;
  final UserController userController = Get.find<UserController>();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    userController.user.value.interests.forEach((element) {
      selectedMusicGenres.add(element);
    });
  }

  void selectIndex(int index) {
    selectedIndex.value = index;
  }

  void toggleMusicGenre(int index) {
    if (selectedMusicGenres.contains(musicGeneres[index])) {
      selectedMusicGenres.remove(musicGeneres[index]);
    } else {
      selectedMusicGenres.add(musicGeneres[index]);
    }
  }

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage.value = File(pickedFile.path);
    }
  }

  toggleOnlline() {
    isOnline.value = !isOnline.value;
  }

  // Initialize selectedGender with a default value (e.g., 0 for the first item)
  var selectedGender = 0.obs;

  // Method to update the selected gender
  void selectGender(int index) {
    selectedGender.value = index;
  }
}
