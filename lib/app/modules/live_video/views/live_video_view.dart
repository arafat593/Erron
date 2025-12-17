import 'dart:ui';

import 'package:errone/app/data/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../common_widgets/custom_blur_button.dart';
import '../controllers/live_video_controller.dart';

class LiveVideoView extends GetView<LiveVideoController> {
  const LiveVideoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SafeArea(
        child: Column(children: [
          Stack(children: [
           // Image.asset(ImagePath.livePageImage),
            Row(
              children: [
              Container(
                height: 500,
                width: 50,
                color: Colors.red,
              ), Container(
                height: 500,
                width: 30,
                color: Colors.green,
              ), Container(
                height: 500,
                width: 30,
                color: Colors.blue,
              ),Container(
                height: 500,
                width: 30,
                color: Colors.yellow,
              ),
              ],
            ),
            Row(children: [
              Container(
                height: 30.h,
                width: 30.w,
                decoration: BoxDecoration(shape: BoxShape.circle,color: AppColors.CrossButtonColor),
                child: Icon(Icons.close),
              ),
              CustomBlurButton()


            ],)
          ],)


        ],),
      )
    );
  }
}
