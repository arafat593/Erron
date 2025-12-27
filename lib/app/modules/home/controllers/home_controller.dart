
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {

  late TabController tabController;
  final selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        selectedIndex.value = tabController.index;
      }
    });
  }

  void changeTab(int index) {
    if (selectedIndex.value == index) return;

    selectedIndex.value = index;
    tabController.animateTo(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
