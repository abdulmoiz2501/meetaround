import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:scratch_project/app/routes/app_pages.dart';
import 'package:scratch_project/app/utils/constants.dart';
import 'package:scratch_project/app/utils/constraints/api_constants.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';

class SignInController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String _url = "$baseUrl/login";
  final RxMap<String, dynamic> responseData = <String, dynamic>{}.obs;
  var loading = false.obs;
  var token = ''.obs;
  var id = ''.obs;

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/userinfo.profile',
    ],
  );

  Future<void> signIn(String email, String password) async {
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
      loading.value = true;
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
      loading.value = false;

      final data = jsonDecode(response.body);

      if (data['responseCode'] == '4000') {
        responseData.value = data;
        token.value = data['token'];
        id.value = data['data']['id'].toString();
        Get.toNamed(Routes.BOTTOM_NAV_BAR);
      } else {
        Get.snackbar('Error', data['responseDesc'] ?? 'An error occurred',
            backgroundColor: VoidColors.primary,
            colorText: VoidColors.whiteColor,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar('Error', 'An error occurred. Please try again.',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final response = await http.post(
          Uri.parse('YOUR_BACKEND_ENDPOINT'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'idToken': googleAuth.idToken}),
        );

        final data = jsonDecode(response.body);

        if (data['responseCode'] == '4000') {
          responseData.value = data;
          token.value = data['token'];
          id.value = data['data']['id'].toString();
          Get.toNamed(Routes.BOTTOM_NAV_BAR);
        } else {
          Get.snackbar('Error', data['responseDesc'] ?? 'An error occurred',
              backgroundColor: VoidColors.primary,
              colorText: VoidColors.whiteColor,
              snackPosition: SnackPosition.BOTTOM);
        }
      } else {
        Get.snackbar('Error', 'Google Sign-In failed',
            backgroundColor: VoidColors.primary,
            colorText: VoidColors.whiteColor,
            snackPosition: SnackPosition.BOTTOM);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred. Please try again.',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  String get userId => responseData['id']?.toString() ?? '';
}
