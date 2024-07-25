import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scratch_project/app/utils/constraints/text_strings.dart';
import '../../../utils/constraints/colors.dart';
import '../../../utils/constraints/image_strings.dart';
import '../../../widgets/homeHeaderWidget.dart';

class SuggestedPeopleView extends GetView {
  SuggestedPeopleView({super.key});

  final List<Map<String, String>> itemsList = List.generate(
    10,
        (index) => {
      'image': VoidImages.testImg,
      'name': 'David $index',
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: VoidColors.whiteColor,
        child: Column(
          children: [
            homeHeaderWidget(itemsList, 100.0, () {}, VoidTexts.topPicks, suggested: true),
          ],
        ),
      ),
    );
  }
}
