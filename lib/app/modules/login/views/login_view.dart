import 'package:errone/app/data/app_colors.dart';
import 'package:errone/app/data/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Text(
                    "Welcome Back",
                    style: AppTextStyles.bold32
                  ),
                  Text(
                    "Login to access your channels",
                    style: AppTextStyles.regular16
                  ),
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w,vertical: 22.h),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'you@example.com',
                        labelText: 'Email',

                      ),
                    ),
                    SizedBox(height: 12.h,),
                    TextFormField(

                      decoration: InputDecoration(
                        hintText: 'youExample',
                        labelText: 'Password',
                      ),
                    )
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
