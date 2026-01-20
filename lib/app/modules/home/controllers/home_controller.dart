import 'dart:async';
import 'dart:convert';

import 'package:errone/app/data/api_service/all_streams_service/all_streams_service.dart';
import 'package:errone/app/data/api_service/join_stream_service/join_stream_service.dart';
import 'package:errone/app/data/urls/urls.dart';
import 'package:errone/app/modules/home/model/all_stream_model.dart';
import 'package:errone/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool streamInProgress = false.obs;
  RxBool joinInProgress = false.obs;

  RxList<AllStreamModel> allStreamModel = RxList<AllStreamModel>();

  List<AllStreamModel> get allStreams => allStreamModel;

  List<AllStreamModel> get freeStreams =>
      allStreamModel.where((e) => e.isPremium == false).toList();

  List<AllStreamModel> get paidStreams =>
      allStreamModel.where((e) => e.isPremium == true).toList();

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 3, vsync: this);

    tabController.addListener(() {
      if (!tabController.indexIsChanging) {
        selectedIndex.value = tabController.index;
      }
    });
    getStream();
  }

  Future<void> getStream() async {
    print("Called[][];']']';");
    streamInProgress.value = true;
    try {
      final response = await AllStreamsService.allStreamsRequest(Urls.activeStream);
      streamInProgress.value = false;
      print("response is ok----${response.body}");
      print("statuscose${response.statusCode.toString()}");
      if (response.statusCode == 200) {
        final List<dynamic> decodedResponse = jsonDecode(response.body);
        print("Decoded streams: $decodedResponse"); // ✅
        allStreamModel.value = decodedResponse
            .map((e) => AllStreamModel.fromJson(e))
            .toList();
        print("AllStreamModel count: ${allStreamModel.length}"); // ✅
      } else {
        Get.snackbar("Failed", response.body);
      }
    } catch (e) {
      streamInProgress.value = false;
      print("thower eroorororo$e");
    }
  }

  Future<void> joinStream(String joinId) async {
    joinInProgress.value = true;
    try {
      final response = await JoinStreamService.joinStreamRequest(
        Urls.joinStream(joinId),
      );
      joinInProgress.value = false;
      debugPrint("josinId${Urls.joinStream(joinId)}");
      print("response body-----${response.body}");
      print(response.statusCode);
      if (response.statusCode == 200) {
        debugPrint("Join successfully");
        final data = jsonDecode(response.body);
        final token = data['livekit_token'];
        final roomName = data['room_name'];
        Get.toNamed(
          Routes.VIEWER_LIVE,
          arguments: {
            'token': token,
            'room_name': roomName,},
        );
      } else {
        Get.snackbar("Failed", response.body);
      }
    } catch (e) {
      joinInProgress.value = false;
      Get.snackbar("Error", "$e");
    }
  }

  late TabController tabController;
  final selectedIndex = 0.obs;

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
  void onReady() {
    super.onReady();
    getStream();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }
}
