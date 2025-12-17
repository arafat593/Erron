import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
  const NewPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Center(
                child: Text(
                  "New password",
                  style: AppTextStyles.bold32,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 26.h),
                child: Column(
                  children: [
                    SizedBox(height: 12.h),
                    Obx(
                          () => TextFormField(
                        obscureText: controller.select1.value,
                        decoration: InputDecoration(
                          hintText: 'youExample',
                          labelText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                               controller.changeSelect1();
                              },
                              icon:controller.select1.value ? Icon(
                                Icons.visibility_off,
                                color: AppColors.whiteLight,
                              ):Icon(
                                Icons.visibility,
                                color: AppColors.whiteLight,
                              )
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Obx(
                          () => TextFormField(
                        obscureText: controller.select2.value,
                        decoration: InputDecoration(
                          hintText: 'youExample',
                          labelText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                controller.changeSelect2();
                              },
                              icon:controller.select2.value ? Icon(
                                Icons.visibility_off,
                                color: AppColors.whiteLight,
                              ):Icon(
                                Icons.visibility,
                                color: AppColors.whiteLight,
                              )
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(onPressed: () {}, child: Text("Save & Update")),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
