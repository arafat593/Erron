import 'dart:io';

import 'package:errone/app/data/api_service/profile_provider/edit_profile_service.dart';
import 'package:errone/app/data/urls/urls.dart';
import 'package:errone/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../routes/app_pages.dart';
import '../../profile/models/profile_model.dart';

class EditProfileController extends GetxController {
  RxBool editProfileInProgress =false.obs;
  final TextEditingController bioTEController=TextEditingController();
  final TextEditingController firstNameTEController=TextEditingController();
  final TextEditingController lastNameTEController=TextEditingController();
  final TextEditingController birthTEController=TextEditingController();
  final TextEditingController genderTEController=TextEditingController();
  final TextEditingController countryTEController=TextEditingController();
  final TextEditingController contactTEController=TextEditingController();
  final TextEditingController emailTEController=TextEditingController();
  final ImagePicker _picker = ImagePicker();
  var profileImagePath = ''.obs;
  var coverImagePath = ''.obs;

  Future<void> pickProfileImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImagePath.value = image.path;
    }
  }

  Future<void> pickCoverImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      coverImagePath.value = image.path;
    }
  }

  void fillData(ProfileModel? profile) {
    if (profile == null) return;

    firstNameTEController.text = profile.firstName ?? '';
    lastNameTEController.text = profile.lastName ?? '';
    bioTEController.text = profile.bio ?? '';
    birthTEController.text = profile.dateOfBirth ?? '';
    genderTEController.text = profile.gender ?? '';
    countryTEController.text = profile.country ?? '';
    contactTEController.text = profile.phoneNumber ?? '';
    emailTEController.text = profile.email ?? '';

    if(profile.profileImage != null && profile.profileImage!.isNotEmpty){
      profileImagePath.value = profile.profileImage!;
    }

    if(profile.coverImage != null && profile.coverImage!.isNotEmpty){
      coverImagePath.value = profile.coverImage!;
    }
  }

  Future<void> getEditData()async{
    editProfileInProgress.value=true;
    try{
      final response=await EditProfileService.editProfileRequest(Urls.updateProfile, <String,dynamic>{
        "first_name": firstNameTEController.text.trim(),
        "last_name": lastNameTEController.text.trim(),
        "bio": bioTEController.text.trim(),
        "profile_image": "string",
        "cover_image": "string",
        "country": countryTEController.text.trim(),
        "gender": genderTEController.text.trim(),
        "date_of_birth": birthTEController.text.trim() ,
        "phone_number": contactTEController.text.trim()
      });
      editProfileInProgress.value=false;
      print("update body${response.body}");
      print("statusCode${response.statusCode}");
      if(response.statusCode == 200){
        Get.snackbar("Success", "update Successfully");
        Get.find<ProfileController>().fetchProfile();
        Get.offAllNamed(
          Routes.CUSTOM_BOTTOM_BAR,
          arguments: {"index": 4},
        );
      }else{
        Get.snackbar("Failed", response.body);
      }
    }catch(e){
      editProfileInProgress.value=false;
      print("Error is $e");
    }
  }




  Rx<XFile?> pickedImage = Rx<XFile?>(null);

  Future<void> pickImage(ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      pickedImage.value = image;
      await uploadProfileImage();
    }
  }

  void chooseImageFrom() {
    showModalBottomSheet(
      context: Get.context!,
      builder: (_) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () {
                pickImage(ImageSource.camera);
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () {
                pickImage(ImageSource.gallery);
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> uploadProfileImage() async {
    if (pickedImage.value == null) return;

    final response = await EditProfileService.uploadProfileImageRequest(
      Urls.uploadProfileImage,
      pickedImage.value!,
    );

    if (response.statusCode == 200) {
      Get.snackbar("Success", "Profile image updated");
      Get.find<ProfileController>().fetchProfile(); // auto refresh profile
    } else {
      Get.snackbar("Failed", response.body);
    }
  }


}
