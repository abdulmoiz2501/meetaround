import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as loc;
import 'package:scratch_project/app/utils/constraints/colors.dart';

class LocationController extends GetxController {
  var currentAddress = 'Fetching location...'.obs;
  var currentPosition = LatLng(37.7749, -122.4194).obs; // Default to San Francisco
  loc.Location location = loc.Location();

  @override
  void onInit() {
    super.onInit();
    goToCurrentLocation();
  }

  Future<void> goToCurrentLocation() async {
    try {
      final locationData = await location.getLocation();
      final position = LatLng(locationData.latitude!, locationData.longitude!);
      currentPosition.value = position;
      //await getAddressFromLatLng(position);
    } catch (e) {
    Get.snackbar('Error', 'An error occurred, Plz try again',
        backgroundColor: VoidColors.primary,
        colorText: VoidColors.whiteColor,
        snackPosition: SnackPosition.BOTTOM);
    print('Exception: $e');
  }
  }

  // Future<void> getAddressFromLatLng(LatLng position) async {
  //   try {
  //     List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
  //     Placemark place = placemarks[0];
  //     currentAddress.value = "${place.street}, ${place.locality}, ${place.country}";
  //   } catch (e) {
  //     print(e);
  //   }
  // }


  ///Web Sockets implementation

}
