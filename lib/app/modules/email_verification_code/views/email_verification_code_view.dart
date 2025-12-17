import 'package:errone/app/data/app_text_styles.dart';
import 'package:errone/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/email_verification_code_controller.dart';

class EmailVerificationCodeView
    extends GetView<EmailVerificationCodeController> {
  const EmailVerificationCodeView({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Center(
                  child: Text(
                    "Enter Verification Code",
                    style: AppTextStyles.bold32,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 15.h),
                child: Column(
                  children: [
                    SizedBox(height: 12.h),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: "*****",
                        labelText: 'Code',
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
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "If you didn't receive a code",
                      style: AppTextStyles.regular12,
                    ),
                    SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {},
                      child: Text("Resend", style: AppTextStyles.regular14),
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
                          Get.toNamed(Routes.NEW_PASSWORD);
                        },
                        child: Text("Verify"),
                      ),
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
