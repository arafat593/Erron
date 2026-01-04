import 'package:errone/app/data/app_colors.dart';
import 'package:errone/app/data/app_text_styles.dart';
import 'package:errone/app/data/image_path.dart';
import 'package:errone/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
   LoginView({super.key});
final GlobalKey<FormState> _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Text("Welcome Back", style: AppTextStyles.bold32),
                    Text(
                      "Login to access your channels",
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
                        controller: controller.emailTEController,
                        decoration: InputDecoration(
                          hintText: 'you@example.com',
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Enter email address';
                          }
                          if (!value.trim().isEmail) {
                            return 'Enter valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 12.h),
                      Obx(
                        () => TextFormField(
                          controller: controller.passTEController,
                          obscureText: controller.obSecure.value,
                          decoration: InputDecoration(
                            hintText: 'youExample',
                            labelText: 'Password',
                            suffixIcon: IconButton(
                              onPressed: () {
                                controller.changeObSecure();
                              },
                              icon: controller.obSecure.value
                                  ? Icon(
                                      Icons.visibility_off,
                                      color: AppColors.whiteLight,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: AppColors.whiteLight,
                                    ),
                            ),
                          ),
                          validator: (String? value) {
                            if (value?.isEmpty ?? true) {
                              return 'Enter your password';
                            }
                            if (value!.length != 6) {
                              return 'Enter six letter or digit';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 12.h),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.EMAIL_VERIFICATION);
                          },
                          child: Text(
                            'Forgot Password?',
                            style: AppTextStyles.regular14,
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
                  child: GetBuilder<LoginController>(
                    builder: (loginController) {
                      if(loginController.signInProgress){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      return Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                               if(_formKey.currentState!.validate()){
                                 loginController.getSignIn();
                               }
                              },
                              child: Text("Login"),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {},
                              child: Text("Browse as Guest"),
                            ),
                          ),
                        ],
                      );
                    }
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
                        "Don't have an account?",
                        style: AppTextStyles.regular12,
                      ),
                      SizedBox(width: 4.w),
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(Routes.REGISTER);
                        },
                        child: Text("Sign Up", style: AppTextStyles.regular12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
