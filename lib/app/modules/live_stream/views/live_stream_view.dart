import 'package:errone/app/data/app_colors.dart';
import 'package:errone/app/data/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../data/image_path.dart';
import '../controllers/live_stream_controller.dart';

class LiveStreamView extends GetView<LiveStreamController> {
  LiveStreamView({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(ImagePath.model_1, fit: BoxFit.cover),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              spacing: 10,
                              children: [
                                SizedBox(height: 16),
                                TextFormField(
                                  controller: controller.titleController,
                                  decoration: InputDecoration(
                                    hintText: 'What are your stream today ??',
                                    labelText: 'Stream Title',
                                  ),
                                  validator: (String? value) {
                                    if (value?.isEmpty ?? true) {
                                      return "Enter Stream title";
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  controller: controller.categoryController,
                                  decoration: InputDecoration(
                                    hintText: 'Stream Category',
                                    labelText: 'Fun',
                                  ),
                                  validator: (String? value) {
                                    if (value?.isEmpty ?? true) {
                                      return "Enter Stream category";
                                    }
                                    return null;
                                  },
                                ),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: AppColors.lightBlack,
                                    borderRadius: BorderRadius.circular(28),
                                  ),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 52,
                                    child: Row(
                                      children: [
                                        Obx(
                                          () => Expanded(
                                            child: toggleButton(
                                              onTap: () {
                                                controller.selectLeft();
                                              },
                                              color:
                                                  controller.toggleButton.value
                                                  ? AppColors.primaryColor
                                                  : AppColors.lightBlack,
                                              icon: Icons.public,
                                              title: "Public",
                                            ),
                                          ),
                                        ),

                                        SizedBox(width: 3.w),

                                        Obx(
                                          () => Expanded(
                                            child: toggleButton(
                                              onTap: () {
                                                controller.selectRight();
                                              },
                                              color:
                                                  controller.toggleButton.value
                                                  ? AppColors.lightBlack
                                                  : AppColors.yellowColor,
                                              icon: Icons.lock_outline,
                                              title: "Paid Entry",
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),

                                Obx(() {
                                  if (!controller.toggleButton.value) {
                                    return TextFormField(
                                      controller: controller.tokenFeeController,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: '50',
                                        labelText: 'Entry Fee',
                                        prefixIcon: Icon(
                                          Icons.diamond_outlined,
                                          color: Colors.white,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                      ),
                                      validator: (String? value) {
                                        if (value?.isEmpty ?? true) {
                                          return "Enter entry fee";
                                        }
                                        return null;
                                      },
                                      style: TextStyle(color: Colors.white),
                                    );
                                  } else {
                                    return SizedBox.shrink(); // Empty widget when Public is selected
                                  }
                                }),
                                Obx(() {
                                  if (controller.streamInProgress.value) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: controller.activeColor,
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          controller.getStream();
                                        }
                                      },
                                      child: Text(
                                        "Go Live",
                                        style: AppTextStyles.bold16.copyWith(
                                          color: AppColors.whiteLight,
                                        ),
                                      ),
                                    ),
                                  );
                                }),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  GestureDetector toggleButton({
    required VoidCallback onTap, // action when tapped
    required Color color,
    required IconData icon,
    required String title,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: color, // right active
          borderRadius: BorderRadius.circular(28),
        ),
        child: SizedBox(
          height: 51,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white),
                SizedBox(width: 5),
                Text(
                  title,
                  style: AppTextStyles.bold16.copyWith(
                    color: AppColors.whiteLight,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
