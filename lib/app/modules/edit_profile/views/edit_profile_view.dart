import 'dart:io';
import 'package:errone/app/data/app_colors.dart';
import 'package:errone/app/data/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../profile/models/profile_model.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    final profile = Get.arguments as ProfileModel?;
    controller.fillData(profile);
    return Scaffold(
    backgroundColor: AppColors.backgroundColor,
    appBar: AppBar(
      backgroundColor: AppColors.backgroundColor,
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white24),
            color: Colors.white.withOpacity(0.05),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            size: 16,
            color: Colors.white,
          ),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        'Edit Profile',
        style: AppTextStyles.bold24.copyWith(color: AppColors.whiteLight),
      ),
      centerTitle: true,
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
         spacing: 12,
        children: [
          _buildSectionTitle('Profile Picture'),
          const SizedBox(height: 12),
          Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Obx(() => CircleAvatar(
                  radius: 70.r,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: controller.pickedImage.value != null
                      ? FileImage(File(controller.pickedImage.value!.path))
                      : null,
                )),
                Positioned(
                  bottom: 0,
                  right: 0,
                  top: 0,
                  left: 0,
                  child: InkWell(
                    onTap: controller.chooseImageFrom,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(Icons.camera_alt_outlined),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _buildSectionTitle('Cover Photo'),
          const SizedBox(height: 12),
          Stack(
            alignment: Alignment.center,
            children: [
              Obx(() {
                return Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: controller.coverImagePath.value.isNotEmpty
                          ? FileImage(File(controller.coverImagePath.value))
                      as ImageProvider
                          : const NetworkImage(
                        'https://images.unsplash.com/photo-1557683316-973673baf926?q=80&w=2029&auto=format&fit=crop',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
              GestureDetector(
                onTap: controller.pickCoverImage,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt_outlined,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildSectionTitle('Bio'),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller.bioTEController,
            style: const TextStyle(color: Colors.white),
            maxLines: 5,
            decoration: const InputDecoration(
              hintText: 'bio........',
              labelText: 'Bio',
              hintStyle: TextStyle(color: Colors.white38),
              labelStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 12),
          _buildSectionTitle('Personal Info'),
          const SizedBox(height: 4),

          TextFormField(
            controller: controller.firstNameTEController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'John',
              labelText: 'First Name',
              hintStyle: TextStyle(color: Colors.white38),
              labelStyle: TextStyle(color: Colors.white70),
            ),
          ),
          TextFormField(
            controller: controller.lastNameTEController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Doe',
              labelText: 'Last Name',
              hintStyle: TextStyle(color: Colors.white38),
              labelStyle: TextStyle(color: Colors.white70),
            ),
          ),
          TextFormField(
            controller: controller.birthTEController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'John Doe',
              labelText: 'Date of birth',
              hintStyle: TextStyle(color: Colors.white38),
              labelStyle: TextStyle(color: Colors.white70),
            ),
          ),
          TextFormField(
            controller: controller.genderTEController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'Female',
              labelText: 'Gender',
              hintStyle: TextStyle(color: Colors.white38),
              labelStyle: TextStyle(color: Colors.white70),
            ),
          ),
          TextFormField(
            controller: controller.countryTEController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'country',
              labelText: 'Country',
              hintStyle: TextStyle(color: Colors.white38),
              labelStyle: TextStyle(color: Colors.white70),
            ),
          ),
          TextFormField(
            controller: controller.contactTEController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: '555-0120',
              labelText: 'Phone Number',
              hintStyle: TextStyle(color: Colors.white38),
              labelStyle: TextStyle(color: Colors.white70),
            ),
          ),
          TextFormField(
            controller: controller.emailTEController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              hintText: 'you@example.com',
              labelText: 'Email',
              hintStyle: TextStyle(color: Colors.white38),
              labelStyle: TextStyle(color: Colors.white70),
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                controller.getEditData();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3D4BFB),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTextStyles.bold18.copyWith(color: AppColors.whiteLight),
    );
  }
}
