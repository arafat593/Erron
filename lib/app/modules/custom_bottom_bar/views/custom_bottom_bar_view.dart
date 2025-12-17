import 'package:errone/app/data/app_colors.dart';
import 'package:errone/app/data/image_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/custom_bottom_bar_controller.dart';

class CustomBottomBarView extends GetView<CustomBottomBarController> {
  const CustomBottomBarView({super.key});

  @override
  Widget build(BuildContext context) {
    // final args=Get.arguments;
    // final index=args["index"];
    // if(index!=null){
    //   controller.changeIndex(index);
    // }
     return Scaffold(
      body: Obx(() => controller.screens[controller.selectIndex.value]),

      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Obx(
          () => BottomNavigationBar(
            backgroundColor: AppColors.backgroundColor,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.green,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            unselectedItemColor: Colors.grey,
            currentIndex: controller.selectIndex.value,
            onTap: controller.changeIndex,
            items: [
              BottomNavigationBarItem(
                icon: bottomBarItem(
                  index: 0,
                  controller: controller,
                  child: Image.asset(ImagePath.home, scale: 3),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: bottomBarItem(
                  index: 1,
                  controller: controller,
                  child: Image.asset(ImagePath.explore, scale: 3),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: bottomBarItem(
                  index: 2,
                  controller: controller,
                  child: Image.asset(ImagePath.video, scale: 3),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: bottomBarItem(
                  index: 3,
                  controller: controller,
                  child: Image.asset(ImagePath.message, scale: 3),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: bottomBarItem(
                  index: 4,
                  controller: controller,
                  child: Image.asset(ImagePath.person, scale: 3),
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomBarItem({
    required int index,
    required Widget child,
    required CustomBottomBarController controller,
  }) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        controller.changeIndex(index);
      },
      child: Container(
        decoration: BoxDecoration(
          color: controller.selectIndex.value == index
              ? AppColors.primaryColor
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(padding: const EdgeInsets.all(18), child: child),
      ),
    );
  }
}
