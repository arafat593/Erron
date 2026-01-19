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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            buildTopButton(controller),
            Expanded(
              child:Obx(() {
                if(controller.streamInProgress.value){
                  return const Center(child: CircularProgressIndicator(),);
                }
                return RefreshIndicator(
                  onRefresh: controller.getStream,
                  child: TabBarView(
                    controller: controller.tabController,
                    physics: const BouncingScrollPhysics(),
                    children:  [
                      HomeGridView(streams: controller.allStreamModel.toList(),
                      onTap: (stream){
                        controller.joinStream(stream.id);
                      },),
                      HomeGridView(streams: controller.freeStreams,
                        onTap: (stream){
                          controller.joinStream(stream.id);
                        },
                      ),
                      HomeGridView(streams: controller.paidStreams,
                        onTap: (stream){
                          controller.joinStream(stream.id);
                        },
                      ),
                    ],
                  ),
                );
              },)
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTopButton(HomeController controller) {
    final titles = ['All', 'Free', 'Paid'];

   return Obx(() =>  Row(
   children: List.generate(titles.length, (index) {
     final isSelected = controller.selectedIndex.value == index;

     return Expanded(
       child: GestureDetector(
         onTap: () => controller.changeTab(index),
         child: AnimatedContainer(
           duration: const Duration(milliseconds: 280),
           curve: Curves.easeOutCubic,
           margin: EdgeInsets.symmetric(horizontal: 4.w),
           padding: EdgeInsets.symmetric(vertical: 10.h),
           decoration: BoxDecoration(
             color: isSelected
                 ? AppColors.primaryColor
                 : AppColors.outlineButtonColor,
             borderRadius: BorderRadius.circular(64.r),
             border: Border.all(
               color: isSelected
                   ? Colors.transparent
                   : AppColors.whiteLight,
             ),
             boxShadow: isSelected
                 ? [
               BoxShadow(
                 color: AppColors.primaryColor.withOpacity(.35),
                 blurRadius: 12,
                 offset: const Offset(0, 4),
               ),
             ]
                 : [],
           ),
           child: Center(
             child: AnimatedDefaultTextStyle(
               duration: const Duration(milliseconds: 200),
               style: AppTextStyles.regular16.copyWith(
                 color: isSelected ? Colors.white : Colors.grey,
                 fontWeight:
                 isSelected ? FontWeight.w600 : FontWeight.w400,
               ),
               child: Text(titles[index]),
             ),
           ),
         ),
       ),
     );
   }),
    ));
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
