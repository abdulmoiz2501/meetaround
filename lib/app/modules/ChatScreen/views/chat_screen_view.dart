import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../utils/constraints/colors.dart';
import '../../../widgets/chat_list.dart';

class ChatScreenView extends StatelessWidget {
  final bool hasMessages = true; // Local boolean to toggle between views

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:VoidColors.secondary ,
      appBar: hasMessages ? _buildChatAppBar() : _buildNoMessagesAppBar(),
      body: hasMessages ? _buildChatBody() : _buildNoMessagesBody(),
    );
  }

  // AppBar for when there are no messages
  AppBar _buildNoMessagesAppBar() {
    return AppBar(
      toolbarHeight: 80.h,
      leading: IconButton(
        splashRadius: 20.r,
        icon: Icon(
          Icons.arrow_back,
          size: 20.r,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      title: Text(
        'No Messages',
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),

      ),
      actions: [
        IconButton(
          icon: Image.asset(
            'assets/icons/msgTimerIcon.png',
            height: 20.r,
            width: 20.r,
          ),
          onPressed: () {
            print("Appbar icon pressed");
          },
        ),
      ],
    );
  }

  // AppBar for when there are messages
  AppBar _buildChatAppBar() {
    return AppBar(
      toolbarHeight: 80.h,
      leading: IconButton(
        splashRadius: 20.r,
        icon: Icon(
          Icons.arrow_back,
          size: 20.r,
          color: Colors.white,
        ),
        onPressed: () {
          Get.back();
        },
      ),
      title: Text(
        'Chat',
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      actions: [
        IconButton(
          icon: Image.asset(
            'assets/icons/msgTimerIconInvert.png',
            height: 20.r,
            width: 20.r,
          ),
          onPressed: () {
            print("Appbar icon pressed");
          },
        ),
      ],
      flexibleSpace: Container(
        decoration: BoxDecoration(
          color: VoidColors.primary,
          /*gradient: LinearGradient(
            colors: [VoidColors.primary, VoidColors.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),*/
        ),
      ),
    );
 
 
  }

  // Body for when there are no messages
  Widget _buildNoMessagesBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Messages right now',
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Check back later',
            style: GoogleFonts.poppins(
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 150.h,
          )
        ],
      ),
    );
  }

  // Placeholder body for when there are messages
  Widget _buildChatBody() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [VoidColors.primary, VoidColors.secondary],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12.h),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 14.sp,
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12.h),
              itemCount: 5, // Placeholder item count
              itemBuilder: (context, index) {
                return ChatListItem(
                  imageUrl: 'assets/icons/chat.png', // Placeholder image
                  name: 'User Name',
                  lastMessage: 'Last message preview',
                  time: '11:20am',
                  coinIcon: 'assets/icons/coin.png',
                  coins: 10,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
