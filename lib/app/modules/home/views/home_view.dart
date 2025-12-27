import 'package:errone/app/data/app_text_styles.dart';
import 'package:errone/app/data/image_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/app_colors.dart';
import '../../common_widgets/custom_app_bar.dart';
import '../controllers/home_controller.dart';
import '../widgets/home_grid_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  // final HomeController controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    return Scaffold(
      // appBar
      appBar: buildCustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            // buttons
            buildTopButton(controller),

            // GridView
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                // physics: BouncingScrollPhysics(),
                children: [HomeGridView(), HomeGridView(), HomeGridView()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // all free paid button's
  Obx buildTopButton(HomeController controller) {
    return Obx(() {
      return Row(
        children: List.generate(3, (index) {
          final titles = ['All', 'Free', 'Paid'];
          final isSelected = controller.selectedIndex.value == index;
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: ElevatedButton(
              onPressed: () {
                controller.tabController.animateTo(index);
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                backgroundColor: isSelected
                    ? AppColors.primaryColor
                    : AppColors.outlineButtonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(64.r),
                ),
                side: BorderSide(
                  color: isSelected ? Colors.transparent : AppColors.whiteLight,
                  width: 1,
                ),
              ),
              child: Text(titles[index], style: AppTextStyles.regular16),
            ),
          );
        }),
      );
    });
  }

  // app bar
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
