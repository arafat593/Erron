import 'package:errone/app/data/app_colors.dart';
import 'package:errone/app/data/app_text_styles.dart';
import 'package:errone/app/data/image_path.dart';
import 'package:errone/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Text("Welcome Back", style: AppTextStyles.bold32),
                  Text(
                    "Sign in to access your channels",
                    style: AppTextStyles.regular16,
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 26.h),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'John Doe',
                        labelText: 'Full Name',
                      ),
                    ),
                    SizedBox(height: 12.h),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'you@example.com',
                        labelText: 'Email',
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Obx(
                          () => TextFormField(
                        obscureText: controller.obSecure.value,
                        decoration: InputDecoration(
                          hintText: 'youExample',
                          labelText: 'Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                controller.changeObSecure();
                              },
                              icon:controller.obSecure.value ? Icon(
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
                        obscureText: controller.isObSecure.value,
                        decoration: InputDecoration(
                          hintText: 'youExample',
                          labelText: 'Confirm Password',
                          suffixIcon: IconButton(
                              onPressed: () {
                                controller.changeIsObSecure();
                              },
                              icon:controller.isObSecure.value ? Icon(
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
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed(Routes.SIGN_UP_VERIFICATION_CODE);
                        },
                        child: Text("Register"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 35,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(color: AppColors.whiteLight, thickness: 1),
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "Or Continue with",
                      style: TextStyle(color: AppColors.whiteLight),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Divider(color: AppColors.whiteLight, thickness: 1),
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
                  child: OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 8),
                    ),
                    child: Image.asset(ImagePath.googleImage, scale: 5),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 35,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account?",
                      style: AppTextStyles.regular12,
                    ),
                    SizedBox(width: 4.w),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.LOGIN);
                      },
                      child: Text("Login", style: AppTextStyles.regular12),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
