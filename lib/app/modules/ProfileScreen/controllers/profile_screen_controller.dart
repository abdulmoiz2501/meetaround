import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfileScreenController extends GetxController {
  var selectedIndex = 0.obs;
  var isOnline=true.obs;
  var selectedMusicGenres = <int>[].obs;
  var pickedImage = Rxn<File>();
  var gender =3.obs;

  void selectIndex(int index) {
    selectedIndex.value = index;
  }

  void toggleMusicGenre(int index) {
    if (selectedMusicGenres.contains(index)) {
      selectedMusicGenres.remove(index);
    } else {
      selectedMusicGenres.add(index);
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      pickedImage.value = File(pickedFile.path);
    }
  }

   toggleOnlline(){
    isOnline.value=!isOnline.value;
   }

     // Initialize selectedGender with a default value (e.g., 0 for the first item)
  var selectedGender = 0.obs;

  // Method to update the selected gender
  void selectGender(int index) {
    selectedGender.value = index;
  }
}
