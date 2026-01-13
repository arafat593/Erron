import 'package:errone/app/modules/live/models/live_stream_model.dart';
import 'package:errone/app/modules/profile/models/profile_model.dart';
import 'package:get/get.dart';

import '../../../data/api_service/live_stream_provider/live_stream_provider.dart';
import '../../../data/api_service/profile_provider/profile_provider.dart';


class ProfileController extends GetxController {
  var selectedTabIndex = 0.obs;

  var selectedActionIndex = 0.obs;
  final ProfileProvider profileProvider = Get.find<ProfileProvider>();
  final LiveStreamProvider liveStreamProvider = Get.find<LiveStreamProvider>();

  final isLoading = true.obs;
  final user = Rxn<ProfileModel>();
  final pastStreams = <LiveStreamModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
    fetchPastStreams();
  }

  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      final result = await profileProvider.getMyProfile();
      if (result != null) {
        user.value = result;
      }
    } catch (e) {
      print("Profile Error: $e");
      Get.snackbar("Error", "Failed to load profile");
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchPastStreams() async {
    try {
      final streams = await liveStreamProvider.getUserLiveStreams();
      pastStreams.assignAll(streams);
    } catch (e) {
      print("Past Streams Error: $e");
    }
  }
}