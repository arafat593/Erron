import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/on_boarding_controller.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  const OnBoardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('OnBoardingView'), centerTitle: true),
      body: Center(
        child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(onPressed: () {
              controller.goToNextScreen();
            }, child: Text("Get Started")),
          ),
        ),
      );
  }
}
