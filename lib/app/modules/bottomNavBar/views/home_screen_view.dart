import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scratch_project/app/modules/bottomNavBar/controllers/location_controller.dart';
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

  Future<Set<Marker>> _createMarkers() async {
    Set<Marker> markers = {};
    for (var user in locationController.currentUsers) {
      ImageConfiguration imageConfiguration =
          // ignore: use_build_context_synchronously
          createLocalImageConfiguration(context, size: const Size(10.0, 10.0));
      final BitmapDescriptor icon = await BitmapDescriptor.fromAssetImage(
          imageConfiguration, "assets/icons/markercoin.png");
      markers.add(
        Marker(
          markerId: MarkerId(user.id.toString()),
          position: LatLng(user.latitude ?? 0, user.longitude ?? 0),
          icon: icon,
          infoWindow: InfoWindow(
            title: user.name,
            snippet: user.interests?.join(', '),
          ),
        ),
      );
    }
    return markers;
  }

  @override
  void initState() {
    super.initState();
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
                child: FutureBuilder<Set<Marker>>(
                  future: _createMarkers(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }
                    return GoogleMap(
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
                          fillColor: Colors.black
                              .withOpacity(0.2), // Black color with opacity
                          strokeColor:
                              Colors.black.withOpacity(0.2), // Border color
                          strokeWidth: 0, // Border width
                        ),
                      ]),
                      markers: snapshot.data!,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}