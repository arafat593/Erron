import 'package:errone/app/data/app_text_styles.dart';
import 'package:errone/app/data/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../common_widgets/custom_app_bar.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar
      appBar: buildCustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            // buttons
            buildTopButton(),
            // GridView
            buildGridView(),
          ],
        ),
      ),
    );
  }

  Widget buildGridView() {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        primary: false,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 14.h),
        itemCount: 20,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          // childAspectRatio: .9,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          mainAxisExtent: 300,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(14.sp),
              image: DecorationImage(
                image: AssetImage(ImagePath.model_1),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(6.sp),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            backgroundColor: AppColors.pinkColor,
                            foregroundColor: AppColors.whiteLight,
                            padding: EdgeInsets.symmetric(vertical: 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(64.sp),
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
                              borderRadius: BorderRadius.circular(64.sp),
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
                            backgroundColor: AppColors.yellowColor,
                            foregroundColor: AppColors.whiteLight,
                            padding: EdgeInsets.symmetric(vertical: 0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(64.sp),
                            ),
                          ),
                          child: Text("50"),
                        ),
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 6.h),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 18.r,
                              backgroundColor: AppColors.pinkColor,
                              child: CircleAvatar(
                                radius: 16.r,
                                backgroundImage: AssetImage(ImagePath.model_1),
                              ),
                            ),
                            SizedBox(width: 6.w),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Ana Fox",
                                    style: AppTextStyles.semiBold12,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    "Evening Hangout",
                                    style: AppTextStyles.regular10,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.blackColor.withAlpha(170),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              LinearProgressIndicator(
                                value: .80,
                                minHeight: 8,
                                backgroundColor: AppColors.pinkColor,
                                color: AppColors.greenAccentColor,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppColors.greenAccentColor,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                semanticsLabel: 'Download progress',
                                semanticsValue: '85%',
                              ),
                              SizedBox(height: 4.h),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 1,
                                    child: Row(
                                      children: [
                                        Text(
                                          "Legit: ",
                                          style: AppTextStyles.regular10,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "98%",
                                          style: AppTextStyles.regular10,
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Flexible(
                                    flex: 1,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "Shady: ",
                                          style: AppTextStyles.regular10
                                              .copyWith(
                                                color: AppColors.readColor,
                                              ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Text(
                                          "2%",
                                          style: AppTextStyles.regular10
                                              .copyWith(
                                                color: AppColors.readColor,
                                              ),
                                          maxLines: 1,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
    );
  }

  Widget buildTopButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              textStyle: AppTextStyles.regular16,
              backgroundColor: AppColors.primaryColor,
              foregroundColor: AppColors.whiteLight,
              padding: EdgeInsets.symmetric(vertical: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(64),
              ),
            ),
            child: Text('All'),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: OutlinedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                textStyle: AppTextStyles.regular16,
                padding: EdgeInsets.symmetric(vertical: 0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(64),
                ),
              ),
              child: Text('Free'),
            ),
          ),
          OutlinedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              textStyle: AppTextStyles.regular16,
              padding: EdgeInsets.symmetric(vertical: 0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(64),
              ),
            ),
            child: Text('Paid'),
          ),
        ],
      ),
    );
  }

  CustomAppBar buildCustomAppBar() {
    return CustomAppBar(
      leading: Image.asset(ImagePath.instaLive),
      actions: [
        SizedBox(
          height: 42.h,
          width: 42.w,
          child: OutlinedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(12.sp),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Image.asset(ImagePath.search),
          ),
        ),
        SizedBox(width: 10.w),
        SizedBox(
          height: 42.h,
          width: 42.w,
          child: OutlinedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(12.sp),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            child: Image.asset(ImagePath.notification),
          ),
        ),
      ],
    );
  }
}
