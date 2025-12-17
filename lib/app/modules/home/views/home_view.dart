import 'package:errone/app/data/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../common_widgets/custom_app_bar.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: Image.asset(ImagePath.instaLive),
        actions: [
          SizedBox(
            height: 45.h,
            width: 45.w,
            child: OutlinedButton(
              onPressed: () {},
              child: Image.asset(ImagePath.search),
            ),
          ),
          SizedBox(width: 10.w),
          SizedBox(
            height: 45.h,
            width: 45.w,
            child: OutlinedButton(
              onPressed: () {},
              child: Image.asset(ImagePath.notification),
            ),
          ),
        ],
      ),
    );
  }
}
