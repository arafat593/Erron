
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/chat_screen_controller.dart';


class ChatScreenView extends GetView<ChatScreenController> {
  const ChatScreenView({super.key,});


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(
      //   leading: buildButton(
      //     icon: Icons.arrow_back_ios_new,
      //     onTap: () {
      //       Get.back();
      //     },
      //   ),
      //   title: Row(
      //     children: [
      //       Stack(
      //         children: [
      //           SizedBox(height: 56, width: 56, child: CircleAvatar(
      //               backgroundImage: NetworkImage(activeUserModel.profileImage)
      //           ),),
      //           Positioned(
      //             bottom: 4,
      //             right: 6,
      //             child: SizedBox(
      //               height: 10,
      //               width: 10,
      //               child: DecoratedBox(
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(10),
      //                   color: Colors.green,
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      //       SizedBox(width: 7.w),
      //       Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text(
      //             activeUserModel.fullName,
      //             style: AppTextStyles.bold16.copyWith(
      //               color: AppColors.whiteLight,
      //             ),
      //           ),
      //           Text(
      //             "Online",
      //             style: AppTextStyles.regular12.copyWith(
      //               color: AppColors.whiteLight,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      //   actions: [
      //     buildButton(icon: Icons.add_call, onTap: () {}),
      //     SizedBox(width: 4),
      //     buildButton(icon: Icons.videocam, onTap: () {}),
      //   ],
      // ),
      body: Column(
        children: [



        ],
      ),);
  }
}

