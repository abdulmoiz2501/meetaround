import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constraints/colors.dart';
import '../../../widgets/custom_button.dart';

class TermsAndConditionsView extends StatelessWidget {
  final VoidCallback onAccept;

  const TermsAndConditionsView({super.key, required this.onAccept});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Terms and Conditions',
          style: GoogleFonts.poppins(
            color: VoidColors.blackColor,
            fontSize: 20.spMax,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: VoidColors.whiteColor,
        iconTheme: IconThemeData(color: VoidColors.blackColor),
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0.w, vertical: 20.0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  'This is the dummy text for the terms and conditions. '
                      'Please read it carefully. By accepting these terms, you agree to our policies and conditions.',
                  style: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: VoidColors.blackColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            CustomButton(
              text: 'Accept',
              onPressed: onAccept,
              borderRadius: 24.r,
              color: VoidColors.primary,
              textColor: VoidColors.whiteColor,
            ),
          ],
        ),
      ),
    );
  }
}
