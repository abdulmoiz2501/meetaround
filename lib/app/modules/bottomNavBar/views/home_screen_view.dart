import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scratch_project/app/modules/bottomNavBar/controllers/location_controller.dart';
import 'package:scratch_project/app/modules/signUp/controllers/sign_up_controller.dart';
import 'package:scratch_project/app/utils/constraints/colors.dart';
import 'package:scratch_project/app/utils/constraints/image_strings.dart';
import 'package:scratch_project/app/utils/constraints/text_strings.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/homeHeaderWidget.dart';

class HomeScreenView extends StatefulWidget {
  HomeScreenView({super.key});

  @override
  _HomeScreenViewState createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
 GoogleMapController? _controller;
  final LocationController locationController = Get.put(LocationController());
//final SignUpController signUpController = Get.put(SignUpController());
  void _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _goToCurrentLocation();
  }

  Future<void> _goToCurrentLocation() async {
    await locationController.goToCurrentLocation();
    final currentPosition = locationController.currentPosition.value;
    _controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: currentPosition, zoom: 15),
      ),
    );
  }
   final List<Map<String, String>> itemsList = List.generate(
     10,
         (index) => {
       'image': VoidImages.testImg,
       'name': 'David $index',
     },
   );

  @override
  void initState() {
    super.initState();
   // signUpController.connectWebSocket();
    locationController.addListener(() {
      final currentPosition = locationController.currentPosition.value;
      _controller?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: currentPosition, zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: VoidColors.whiteColor,
        child: Column(
          children: [
            homeHeaderWidget(
              itemsList,
              100.0,
              () {
                Get.toNamed(Routes.SUGGESTED_PEOPLE);
              },
              VoidTexts.suggestPeople,
            ),
            SizedBox(
              height: 20.h,
            ),
            Obx(
              () => Expanded(
                child: GoogleMap(
                  compassEnabled: false,
                  myLocationButtonEnabled: false,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: locationController.currentPosition.value,
                    zoom: 10,
                  ),
                  myLocationEnabled: true,
                  circles: Set.from([
                    Circle(
                      circleId: CircleId('currentLocation'),
                      center: locationController.currentPosition.value,
                      radius: 300.r, // Set your desired radius
                      fillColor: Colors.black.withOpacity(0.2), // Black color with opacity
                      strokeColor: Colors.black.withOpacity(0.2), // Border color
                      strokeWidth: 0, // Border width
                    ),
                  ]),
                )
                 // markers: _markers,
                ),
         ) ],
        ),
      ),
    );
  }
}
