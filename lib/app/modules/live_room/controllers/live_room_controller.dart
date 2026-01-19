

import 'package:errone/app/data/api_service/live_stream_service/live_stream_service.dart';
import 'package:errone/app/data/urls/urls.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:livekit_client/livekit_client.dart';

class LiveRoomController extends GetxController {
  final isMicOn = true.obs;
  final isCameraOn = true.obs;
  RxBool disconnectInProgress = false.obs;
  String? sessionId;

  Room? room;
  late EventsListener<RoomEvent> listener;

  final isConnected = false.obs;
  final localVideoTrack = Rxn<LocalVideoTrack>();
  final remoteVideoTracks = <VideoTrack>[].obs;

  final String liveKitUrl = "wss://liveworld-l78cuzu0.livekit.cloud";

  late String token;
  late String roomName;
  late bool isHost;

  @override
  void onInit() {
    super.onInit();

    final args = Get.arguments;
    token = args["token"];
    roomName = args["room_name"];
    isHost = args["is_host"] ?? false;
    sessionId = args["session_id"];
    print("Session ID inside LiveRoomController: $sessionId");
    connectLiveKit();
  }


  Future<void> connectLiveKit() async {
    await [Permission.camera, Permission.microphone].request();

    try {
      room = Room();
      listener = room!.createListener();

      await room!.connect(liveKitUrl, token);
      isConnected.value = true;

      _listenRoomEvents();

      if (isHost) {
        final videoTrack =
        await LocalVideoTrack.createCameraTrack();
        await room!.localParticipant!
            .publishVideoTrack(videoTrack);
        debugPrint("HOST VIDEO PUBLISHED ✅");
        localVideoTrack.value = videoTrack;

        await room!.localParticipant!
            .setMicrophoneEnabled(true);
      }
    } catch (e) {
      Get.snackbar("Live Error", "Connection failed: $e");
    }
  }

  void _listenRoomEvents() {
    listener.on<TrackSubscribedEvent>((event) {
      if (event.track is VideoTrack) {
        remoteVideoTracks.add(event.track as VideoTrack);
      }
    });

    listener.on<TrackUnsubscribedEvent>((event) {
      if (event.track is VideoTrack) {
        remoteVideoTracks.remove(event.track);
      }
    });
  }

  void toggleCamera() async {
    final track = localVideoTrack.value;
    if (track == null) return;

    isCameraOn.value = !isCameraOn.value;

    if (isCameraOn.value) {
      await track.enable(); // ✅ ON
    } else {
      await track.disable(); // ✅ OFF
    }
  }

  void toggleMic() async {
    final participant = room?.localParticipant;
    if (participant == null) return;

    final nextState = !participant.isMicrophoneEnabled();

    try {
      await participant.setMicrophoneEnabled(nextState);
      isMicOn.value = nextState;
    } catch (e) {
      debugPrint('Mic toggle failed: $e');
    }
  }

  Future<void> disconnectBackend(String sessionId) async {
    if (sessionId.isEmpty) return;
    try {
      final response = await LiveStreamService.disConnectStreamRequest(
          Urls.stopStream(sessionId),);
      if (response.statusCode != 200) {
        debugPrint("Backend error: ${response.body}");
        debugPrint("Stopping stream for sessionId: $sessionId");
      }
    } catch (e) {
      debugPrint("Error is $e");
    }
  }


  Future<void> leaveStream() async {
    if (disconnectInProgress.value) return;

    disconnectInProgress.value = true;

    try {
      // 1️⃣ LiveKit disconnect
      await disConnectLiveKit();

      // 2️⃣ Backend update (DB clear)
      if (sessionId != null) {
        await disconnectBackend(sessionId!);
      }

      Get.back(); // page close
    } catch (e) {
      debugPrint("Leave stream failed: $e");
    } finally {
      disconnectInProgress.value = false;
    }
  }


  Future<void> disConnectLiveKit() async {
    if (room == null) return;
    try {
      // Local mic & camera বন্ধ
      await room!.localParticipant?.setMicrophoneEnabled(false);
      final track = localVideoTrack.value;
      if (track != null) {
        await track.disable();
      }
      listener.dispose();
      // LiveKit থেকে disconnect
      await room!.disconnect();

      // Room dispose
      room!.dispose();
      room = null;

      // Controller state reset
      isConnected.value = false;
      isMicOn.value = false;
      isCameraOn.value = false;
      localVideoTrack.value = null;
      remoteVideoTracks.clear();

      debugPrint("Disconnected successfully");
    } catch (e) {
      debugPrint("Disconnect failed: $e");
    }
  }


  @override
  void onClose() {
    if (room != null) {
      room!.dispose();
      room = null;
    }
    super.onClose();
  }
}
