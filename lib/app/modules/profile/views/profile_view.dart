import 'package:errone/app/routes/app_pages.dart';
import 'package:errone/app/shared_pref_service/shared_pref_service.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ProfileView'), centerTitle: true),
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(onPressed: ()async{
           await SharedPrefService.clear();
           Get.offAllNamed(Routes.LOGIN);
          }, child: Text("Log Out")),
        ),
      ),
    );
  }
}
