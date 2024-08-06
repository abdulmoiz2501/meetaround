import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:http/http.dart' as http;
import 'package:scratch_project/app/Models/user_model.dart';
import 'package:scratch_project/app/controllers/user_controller.dart';
import 'package:scratch_project/app/models/user_model2.dart';
import 'dart:convert';
import 'package:scratch_project/app/modules/signIn/controllers/sign_in_controller.dart';
import 'package:scratch_project/app/modules/signUp/controllers/sign_up_controller.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';
import 'dart:math';

class SearchScreenController extends GetxController {
  final SignInController signInController = Get.put(SignInController());
  final SignUpController signUpController = Get.put(SignUpController());
  final UserController userController = Get.find();
  var isLoading = false.obs;
  var isChat = false.obs;
  var userStatus = true.obs;
  var users = <User>[].obs;
  var distances = <int, double>{}.obs; // Map to store distances for each user by their id
  var addresses = <int, String>{}.obs; // Map to store addresses for each user by their id
  var isDistanceLoading = false.obs; // New observable for distance loading state
  var isAddressLoading = false.obs; // New observable for address loading state
  var comeFromChat = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUsers();
  }

  Future<void> fetchUsers() async {
    final userId = signInController.id.value;
    final token = signInController.token.value;
    ;
    final url = 'https://meet-around-apis-production.up.railway.app/api/user/getUsers?userId=$userId';

    print('Fetching users with URL: $url');
    print('Token: $token');

    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse(url),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print("Response status: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var userList = jsonResponse['data'] as List;
        users.value = userList.map((userJson) {
          return User.fromJson(userJson);
        }).toList();

        // Calculate distances and addresses for each user after fetching them
        calculateDistancesAndAddressesForUsers();
      } else {
        Get.snackbar('Error', 'Failed to fetch users: ${response.reasonPhrase}');
      }
    } catch (e) {
      print("Error occurred: $e");
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: VoidColors.primary,
        colorText: VoidColors.whiteColor,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  void calculateDistancesAndAddressesForUsers() async {
    isDistanceLoading(true);
    isAddressLoading(true);
final lattitude= userController.user.value.latitude;
    final longitude=userController.user.value.longitude;
    print("********************");
    double myLat = lattitude;
    double myLong =longitude;
    print(myLat);
    print(myLong);

    for (var user in users) {
      if (user.latitude != 0.0 && user.longitude != 0.0) {
        double calculatedDistance = calculateDistance(myLat, myLong, double.parse(user.latitude.toString()), double.parse(user.longitude.toString()));
        distances[user.id] = calculatedDistance; // Store the calculated distance for each user by their id
        print('Calculated distance to user ${user.id}: ${calculatedDistance} km');

        String address = await getAddressFromLatLng(double.parse(user.latitude.toString()), double.parse(user.longitude.toString()));
        addresses[user.id] = address; // Store the calculated address for each user by their id
        print('Calculated address for user ${user.id}: $address');
      }
    }

    isDistanceLoading(false);
    isAddressLoading(false);
  }

  double calculateDistance(double myLat, double myLong, double userLat, double userLong) {
    const double earthRadius = 6371.0; // Earth's radius in kilometers

    double dLat = _toRadians(userLat - myLat);
    double dLong = _toRadians(userLong - myLong);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(myLat)) * cos(_toRadians(userLat)) *
        sin(dLong / 2) * sin(dLong / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    double calculatedDistance = earthRadius * c;
    return calculatedDistance;
  }

  // Helper function to convert degrees to radians
  double _toRadians(double degree) {
    return degree * pi / 180;
  }

  Future<String> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      Placemark place = placemarks[0];
      return "${place.country}, ${place.locality}}";
    } catch (e) {
      print(e);
      return "Unknown location";
    }
  }

  void toggleChatMusic() {
    isChat.value = !isChat.value;
  }
}

