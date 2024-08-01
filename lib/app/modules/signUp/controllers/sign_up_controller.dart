import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:scratch_project/app/routes/app_pages.dart';
import 'package:scratch_project/app/utils/constraints/api_constants.dart';
import '../../../utils/constraints/colors.dart';

class SignUpController extends GetxController {
  var accept = false.obs;
  Rx<XFile?> imgFile = Rx<XFile?>(null);
  var isImgPicked = false.obs;
  var selectedMusicGenres = <String>[].obs;

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPassController = TextEditingController();
  final dateOfBirthController = TextEditingController();

  void toggleAccept() {
    accept.value = !accept.value;
  }

  void pickPicture() async {
    try {
      final ImagePicker picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
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

  Future<void> emailVerify() async {
    if (passwordController.text != confirmPassController.text) {
      Get.snackbar('Error', 'Passwords do not match',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final apiUrl = "$baseUrl/emailValidation";
    final headers = {'Content-Type': 'application/json'};
    final body = json.encode({
      'name': nameController.text,
      'email': emailController.text,
      'password': passwordController.text,
    });

    try {
      final response = await http.post(Uri.parse(apiUrl), headers: headers, body: body);
      final responseData = json.decode(response.body);

      if (responseData['responseCode'] == '4001') {
        Get.snackbar('Success', 'Operation Successful',
            backgroundColor: VoidColors.primary,
            colorText: VoidColors.whiteColor,
            snackPosition: SnackPosition.BOTTOM);
        Get.toNamed(Routes.DATE_OF_BIRTH);
      } else {
        Get.snackbar('Error', responseData['responseDesc'],
            backgroundColor: VoidColors.primary,
            colorText: VoidColors.whiteColor,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  var selectedGender = 'Male'.obs;

  void selectGender(String gender) {
    selectedGender.value = gender;
  }

  void toggleMusicGenre(String genre) {
    if (selectedMusicGenres.contains(genre)) {
      selectedMusicGenres.remove(genre);
    } else {
      selectedMusicGenres.add(genre);
    }
  }

  Future<void> signUp() async {
  

  if (passwordController.text != confirmPassController.text) {
    Get.snackbar('Error', 'Passwords do not match',
        backgroundColor: VoidColors.primary,
        colorText: VoidColors.whiteColor,
        snackPosition: SnackPosition.BOTTOM);
    return;
  }

  final apiUrl = "$baseUrl/signUp";
  final headers = {'Content-Type': 'application/json'};

  var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
  request.fields['name'] = nameController.text;
  request.fields['email'] = emailController.text;
  request.fields['password'] = passwordController.text;
  request.fields['re_password'] = confirmPassController.text;
  request.fields['birthdate'] = dateOfBirthController.text.isEmpty ? 'N/A' : dateOfBirthController.text;
  request.fields['gender'] = selectedGender.value.isEmpty ? 'N/A' : selectedGender.value;
  request.fields['interests'] = selectedMusicGenres.isEmpty ? 'N/A' : selectedMusicGenres.join(', ');
  request.fields['latitude'] = latitude.value.toString();
  request.fields['longitude'] = longitude.value.toString();

  if (imgFile.value != null) {
    var file = await http.MultipartFile.fromPath('profilePicture', imgFile.value!.path);
    request.files.add(file);
  }

  try {
    print('Sending request to $apiUrl with fields: ${request.fields}');
    if (imgFile.value != null) {
      print('Sending file: ${imgFile.value!.path}');
    }

    final response = await request.send();
    final responseData = await response.stream.bytesToString();

    print('Response status: ${response.statusCode}');
    print('Response body: $responseData');

    final parsedResponse = json.decode(responseData);
    if (parsedResponse['responseCode'] == '4000') {
      Get.snackbar('Success', 'Signup successful',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
      Get.toNamed(Routes.SIGN_IN);
    } else {
      Get.snackbar('Error', parsedResponse['responseDesc'],
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    }
  } catch (e) {
    Get.snackbar('Error', 'An error occurred: $e',
        backgroundColor: VoidColors.primary,
        colorText: VoidColors.whiteColor,
        snackPosition: SnackPosition.BOTTOM);
    print('Exception: $e');
  }
}

  ///Location Part
 var latitude = 0.0.obs;
  var longitude = 0.0.obs;

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar('Error', 'Location services are disabled.',
           backgroundColor: VoidColors.primary, colorText: VoidColors.secondary);
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar('Error', 'Location permissions are denied.',
             backgroundColor: VoidColors.primary, colorText: VoidColors.secondary);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Get.snackbar('Error',
          'Location permissions are permanently denied, we cannot request permissions.',
          backgroundColor: VoidColors.primary, colorText: VoidColors.secondary);
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    latitude.value = position.latitude;
    longitude.value = position.longitude;
  }
}
