import 'package:errone/app/data/app_text_styles.dart';
import 'package:errone/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/email_verification_controller.dart';

class EmailVerificationView extends GetView<EmailVerificationController> {
  EmailVerificationView({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(22),
                  child: Center(
                    child: Text(
                      "Enter Email address",
                      style: AppTextStyles.bold32,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 15.h,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 12.h),
                      TextFormField(
                        controller: controller.emailTEController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "you@example.com",
                          labelText: 'Email',
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email is required';
                          }

                          final emailRegex = RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          );

                          if (!emailRegex.hasMatch(value.trim())) {
                            return 'Enter a valid email address';
                          }

                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.LOGIN);
                      },
                      child: Text(
                        "Back to sign in",
                        style: AppTextStyles.regular14,
                      ),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: GetBuilder<EmailVerificationController>(
                    builder: (emailController) {
                      if(emailController.emailInProgress){
                        return Center(child: CircularProgressIndicator());
                      }
                      return Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  emailController.getEmailVerification();
                                }
                              },
                              child: Text("Send"),
                            ),
                          ),
                        ],
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
