import 'dart:convert';
import 'package:errone/app/data/api_service/live_stream_service/live_stream_service.dart';
import 'package:errone/app/data/app_colors.dart';
import 'package:errone/app/data/urls/urls.dart';
import 'package:errone/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LiveStreamController extends GetxController {
  var toggleButton = true.obs;
  RxBool streamInProgress= false.obs;
  final TextEditingController titleController=TextEditingController();
  final TextEditingController categoryController=TextEditingController();
  final TextEditingController tokenFeeController=TextEditingController();

  void selectLeft() {
    toggleButton.value = true;
    tokenFeeController.clear();
  }

  void selectRight() {
    toggleButton.value = false;
  }
  Map<String, dynamic> get streamPayload {
    return {
      "is_premium": !toggleButton.value,
      "entry_fee": toggleButton.value
          ? 0
          : int.tryParse(tokenFeeController.text.trim()) ?? 0,
      "title": titleController.text.trim(),
      "category": categoryController.text.trim(),
    };
  }

  Color get activeColor =>
      toggleButton.value ?
      AppColors.primaryColor :
      AppColors.yellowColor;

  Future<void> getStream()async{
    streamInProgress.value=true;
    try{
      final response= await LiveStreamService.liveStreamRequest(Urls.liveStream, streamPayload);
      streamInProgress.value =false;
      print("body------${response.body.toString()}");
      print("sta------${response.statusCode.toString()}");
      print("REQUEST BODY: ${jsonEncode(streamPayload)}");
      if(response.statusCode == 201){
        final decodedResponse =jsonDecode(response.body);
        final String liveKiToken=decodedResponse["livekit_token"];
        final String roomName=decodedResponse["channel_name"];
        final String session_id=decodedResponse["live_id"];
        print("livekitT $liveKiToken\n roomName $roomName sessionid: $session_id");
        Get.toNamed(Routes.LIVE_ROOM,arguments: {
          "token": liveKiToken,
          "room_name": roomName,
          "is_host": true,
          "session_id": session_id,
        });

      }else{
      Get.snackbar("Failed", response.body);
      }
    }catch(e){
      streamInProgress.value=false;
      Get.snackbar("Error","$e");
    }
  }
}
