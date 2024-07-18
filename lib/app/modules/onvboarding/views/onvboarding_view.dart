import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/onvboarding_controller.dart';

class OnvboardingView extends GetView<OnvboardingController> {
  const OnvboardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OnvboardingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'OnvboardingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
