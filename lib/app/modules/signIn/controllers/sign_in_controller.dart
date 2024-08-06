import 'dart:convert'; // For jsonEncode and jsonDecode
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:scratch_project/app/controllers/user_controller.dart';
import 'package:scratch_project/app/models/user_model.dart';
import 'package:scratch_project/app/routes/app_pages.dart';
import 'package:scratch_project/app/utils/constraints/api_constants.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';

class SignInController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String _url = "$baseUrl/login";
  final RxMap<String, dynamic> responseData = <String, dynamic>{}.obs;
  var loading = false.obs;
  var lattitude=0.0.obs;
  var longitude=0.0.obs;
 var token = ''.obs; // Store token here
  var id = ''.obs; // Store id here

Future<void> signIn(String email, String password) async {
  // Validate if any fields are empty
  if (email.isEmpty) {
    Get.snackbar('Error', 'Email cannot be empty',
        backgroundColor: VoidColors.primary,
        colorText: VoidColors.whiteColor,
        snackPosition: SnackPosition.BOTTOM);
    return;
  }
  if (password.isEmpty) {
    Get.snackbar('Error', 'Password cannot be empty',
        backgroundColor: VoidColors.primary,
        colorText: VoidColors.whiteColor,
        snackPosition: SnackPosition.BOTTOM);
    return;
  }

  // Validate email format
  String emailPattern = r'^[^@]+@[^@]+\.[^@]+';
  RegExp emailRegExp = RegExp(emailPattern);
  if (!emailRegExp.hasMatch(email)) {
    Get.snackbar('Error', 'Invalid email format',
        backgroundColor: VoidColors.primary,
        colorText: VoidColors.whiteColor,
        snackPosition: SnackPosition.BOTTOM);
    return;
  }

  try {
    loading.value = true; // Set loading to true
    final response = await http.post(
      Uri.parse(_url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );
    loading.value = false; // Set loading to false

    final data = jsonDecode(response.body);
    print('This is the response of the login api: $data');

    if (data['responseCode'] == '4000') {
      responseData.value = data;
      lattitude.value = data['data']['latitude'];// Corrected here
      longitude.value = data['data']['longitude'];// Corrected here
      token.value = data['token']; // Store token here
      id.value = data['data']['id'].toString();
      final UserController userController = Get.find();
      print('///done with the user controller');
      userController.token.value = token.value;
      userController.latitude.value = lattitude.value;
      userController.longitude.value = longitude.value;
      print('///done with the token');
      userController.user.value = UserModel.fromJson(data['data']);
      print('///done with the user model');
      print("***********************");
      print(responseData);
      // Navigate to the next screen
      Get.toNamed(Routes.BOTTOM_NAV_BAR);
    } else {
      // Handle unexpected response codes
      Get.snackbar('Error', data['responseDesc'] ?? 'An error occurred',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    }
  } catch (e) {
    loading.value = false; // Set loading to false in case of an error
    // Handle network or other errors
    print('This is the error: $e');
    Get.snackbar('Error', 'An error occurred. Please try again.',
        backgroundColor: VoidColors.primary,
        colorText: VoidColors.whiteColor,
        snackPosition: SnackPosition.BOTTOM);
  }
}

  String get userId => responseData['id']?.toString() ?? '';
}
