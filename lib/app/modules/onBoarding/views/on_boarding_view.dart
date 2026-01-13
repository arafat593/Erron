
import 'package:errone/app/data/app_colors.dart';
import 'package:errone/app/data/app_text_styles.dart';
import 'package:errone/app/data/image_path.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/on_boarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050B18), // Deep dark blue background
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 4),
           Image.asset(ImagePath.splashImage,scale: 4,),



            const Spacer(flex: 1),


            Expanded(flex: 5, child: _buildImageComposition()),

            const Spacer(flex: 1),

            // Text Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  Text(
                    "Go Live, Your Way",
                    textAlign: TextAlign.center,
                    style:AppTextStyles.bold36.copyWith(color: AppColors.whiteLight),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Stream publicly for everyone or host exclusive paid rooms for your top fans.",
                    textAlign: TextAlign.center,
                    style: AppTextStyles.regular16.copyWith(color: AppColors.whiteLight),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Button
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24.0,
                vertical: 24.0,
              ),
              child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(onPressed: () {
                          controller.goToNextScreen();
                        }, child: Text("Get Started")),
                      ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
  Widget _buildImageComposition() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 420,
        child: Stack(
          alignment: Alignment.center,
          children: [
            // TOP
            Positioned(
              top: 0,
              child: _buildImageContainer(
                imageUrl:
                'https://images.unsplash.com/photo-1524504388940-b1c1722653e1',
              ),
            ),

            // LEFT (vertical pill, just moved left)
            Positioned(
              left: 0,
              child: _buildImageContainer(
                imageUrl:
                'https://images.unsplash.com/photo-1534528741775-53994a69daeb',
              ),
            ),

            // RIGHT (vertical pill, just moved right)
            Positioned(
              right: 0,
              child: _buildImageContainer(
                imageUrl:
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330',
              ),
            ),

            // BOTTOM
            Positioned(
              bottom: 0,
              child: _buildImageContainer(
                imageUrl:
                'https://images.unsplash.com/photo-1517841905240-472988babdf9',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageContainer({
    required String imageUrl,
  }) {
    return Container(
      width: 120,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(90),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.35),
            blurRadius: 16,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
    );
  }
}
