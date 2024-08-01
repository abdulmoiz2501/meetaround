import 'dart:convert'; // For jsonEncode and jsonDecode
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:scratch_project/app/routes/app_pages.dart';
import 'package:scratch_project/app/utils/constants.dart';
import 'package:scratch_project/app/utils/constraints/api_constants.dart';

class SignInController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final String _url =
      "$baseUrl/login";

  Future<void> signIn(String email, String password) async {
    try {
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

      final responseData = jsonDecode(response.body);

      if (responseData['responseCode'] == '4000') {
        final String token = responseData['token'];
        final storage = GetStorage();
        storage.write('token', token);

        // Optionally, you can access user data if needed

        // Navigate to the next screen
        Get.toNamed(Routes.BOTTOM_NAV_BAR);
      } else {
        // Handle unexpected response codes
        Get.snackbar(
            'Error', responseData['responseDesc'] ?? 'An error occurred');
      }
    } catch (e) {
      // Handle network or other errors
      Get.snackbar('Error', 'An error occurred. Please try again.');
    }
  }
}
