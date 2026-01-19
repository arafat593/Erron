import 'dart:ui';

import 'package:errone/app/data/app_colors.dart';
import 'package:errone/app/data/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:livekit_client/livekit_client.dart';
import '../controllers/live_room_controller.dart';

class LiveRoomView extends GetView<LiveRoomController> {
  const LiveRoomView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (!controller.isConnected.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        return Stack(
          children: [
            if (controller.localVideoTrack.value != null)
              Positioned.fill(
                child: VideoTrackRenderer(controller.localVideoTrack.value!),
              ),
            Positioned(
              left: 35,
              top: 80,
              right: 25,
              child: Row(
                children: [
                  buildSticker(title: 'Live', color: AppColors.pinkColor),
                  SizedBox(width: 4.w),
                  buildSticker(
                    icon: Icons.visibility_outlined,
                    title: '4k',
                    color: AppColors.primaryColor,
                  ),
                  SizedBox(width: 4.w),
                  buildSticker(
                    icon: Icons.card_giftcard_outlined,
                    title: '50k',
                    color: AppColors.yellowColor,
                  ),
                  Spacer(),
                  buildIconButton(
                      onTap: controller.leaveStream,
                      backgroundColor: AppColors.greyRed,
                      icon: Icons.close,
                    iconColor: AppColors.whiteColor
                  ),
                ],
              ),
            ),

            Positioned(
              bottom:55,
              left: 30,
              right:30,
              child:ClipRRect(
                borderRadius: BorderRadius.circular(40), // rounded container
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2), // blur intensity
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    color: Colors.white.withAlpha(90), // semi-transparent
                    child: Obx((){
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          buildIconButton(
                              backgroundColor:controller.isCameraOn.value
                                  ?AppColors.whiteColor
                                  :AppColors.greyRed,
                              iconColor: controller.isCameraOn.value
                                  ?AppColors.black09
                                  :AppColors.whiteLight,
                              onTap: () {
                                controller.toggleCamera();
                              },
                              icon:controller.isCameraOn.value
                                  ? Icons.camera_alt_outlined
                                  : Icons.videocam_off
                          ),
                          buildIconButton(
                              icon: controller.isMicOn.value
                              ?Icons.mic
                              :Icons.mic_off,
                              iconColor: controller.isMicOn.value
                              ?AppColors.black09
                              :AppColors.whiteLight,
                              onTap: (){
                                controller.toggleMic();
                              },
                              backgroundColor:controller.isMicOn.value
                              ?AppColors.whiteColor
                              :AppColors.greyRed
                          ),
                          buildIconButton(backgroundColor: AppColors.whiteColor,
                              iconColor: AppColors.whiteColor,
                              onTap: () {},
                              icon: Icons.close),

                        ],
                      );
                    })
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  Widget buildIconButton(
      {required Color backgroundColor,
       required Color iconColor,
        required VoidCallback onTap,
        required IconData icon,
        int? height,
        int? width}) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 35,
        width: 35,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: backgroundColor,
            shape: BoxShape.circle,
          ),
          child: Icon(
           icon,
            size: 18,
            color: iconColor,
          ),
        ),
      ),
    );
  }

  Widget buildSticker({
    IconData? icon, // now optional
    required String title,
    required Color color,
  }) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(19),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min, // shrink to content
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: AppColors.whiteLight),
              const SizedBox(width: 3),
            ],
            Text(
              title,
              style: AppTextStyles.regular12.copyWith(
                color: AppColors.whiteLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
