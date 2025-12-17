import 'dart:ui';

import 'package:errone/app/data/app_text_styles.dart';
import 'package:errone/app/data/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import '../../../data/app_colors.dart';
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

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            // buttons
            Padding(
              padding: EdgeInsets.symmetric(vertical: 22.h),
              child: Row(
                children: [
                  ElevatedButton(onPressed: () {}, child: Text('All')),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: OutlinedButton(
                      onPressed: () {},
                      child: Text('Free'),
                    ),
                  ),
                  OutlinedButton(onPressed: () {}, child: Text('Paid')),
                ],
              ),
            ),

            // GridView
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                primary: false,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: 20,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // childAspectRatio: .9,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  mainAxisExtent: 300,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    // height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(24.sp),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.sp),
                      child: Column(
                        children: [
                          // top button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                height: 20.h,
                                width: 35.w,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    textStyle: AppTextStyles.regular10,
                                    backgroundColor: AppColors.pink,
                                    foregroundColor: AppColors.whiteLight,
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        64.sp,
                                      ),
                                    ),
                                  ),
                                  child: Text("Live"),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                                width: 35.w,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    textStyle: AppTextStyles.regular10,
                                    backgroundColor: AppColors.primaryColor,
                                    foregroundColor: AppColors.whiteLight,
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        64.sp,
                                      ),
                                    ),
                                  ),
                                  child: Text("4k"),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                                width: 35.w,
                                child: ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    textStyle: AppTextStyles.regular10,
                                    backgroundColor: AppColors.yellow,
                                    foregroundColor: AppColors.whiteLight,
                                    padding: EdgeInsets.symmetric(vertical: 0),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        64.sp,
                                      ),
                                    ),
                                  ),
                                  child: Text("50"),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
