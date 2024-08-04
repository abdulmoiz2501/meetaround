import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:scratch_project/app/modules/signIn/controllers/sign_in_controller.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';

class SearchScreenController extends GetxController {
  final SignInController signInController = Get.put(SignInController());
  var users = [].obs;
  var isLoading = false.obs;
  var userid = SignInController().userId;
  @override
  void onInit() {
    super.onInit();
  }

  void fetchUsers() async {
    print(signInController.userId);
    print("*****************************");
    final url =
        'https://meet-around-apis-production.up.railway.app/api/user/getUsers?userId=32';
    var token = signInController.token;

    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        users.value =
            jsonResponse.map((user) => user as Map<String, dynamic>).toList();
      } else {
        Get.snackbar('Error', 'Failed to fetch users');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred',
          backgroundColor: VoidColors.primary,
          colorText: VoidColors.whiteColor,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}
