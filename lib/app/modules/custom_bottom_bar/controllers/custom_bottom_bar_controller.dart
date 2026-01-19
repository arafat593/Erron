import 'package:errone/app/modules/explore/views/explore_view.dart';
import 'package:errone/app/modules/home/views/home_view.dart';
import 'package:errone/app/modules/live_stream/views/live_stream_view.dart';
import 'package:errone/app/modules/message/views/message_view.dart';
import 'package:errone/app/modules/profile/views/profile_view.dart';
import 'package:get/get.dart';

class CustomBottomBarController extends GetxController {
  var selectIndex = 0.obs;
  final screens = [
    const HomeView(),
    const ExploreView(),
        LiveStreamView(),
         MessageView(),
    const ProfileView(),
  ];

  void changeIndex(int index) {
    selectIndex.value = index;
  }
}
