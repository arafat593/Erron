import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../data/app_colors.dart';
import '../../../data/app_text_styles.dart';
import '../controllers/new_password_controller.dart';

class NewPasswordView extends GetView<NewPasswordController> {
   NewPasswordView({super.key});
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
                          controller: controller.passwordController,
                          decoration: InputDecoration(
                            hintText: 'youExample',
                            labelText: 'New Password',
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
                      Obx(
                            () => TextFormField(
                              controller: controller.confirmPasswordController,
                          obscureText: controller.select2.value,
                          decoration: InputDecoration(
                            hintText: 'youExample',
                            labelText: 'Confirm Password',
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
                              validator: (String? value) {
                                if (value?.isEmpty ?? true) {
                                  return 'Enter your password';
                                }
                                if (value!.length != 6) {
                                  return 'Enter six letter or digit';
                                }
                                if (value != controller.passwordController.text) {
                                  return 'password not matching';
                                }
                                return null;
                              },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GetBuilder<NewPasswordController>(
                    builder: (newController) {
                      if(newController.newPasswordInProgress){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(onPressed: () {
                          if(_formKey.currentState!.validate()){
                            newController.getNewPassword();
                          }
                        }, child: Text("Save & Update")),
                      );
                    }
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
