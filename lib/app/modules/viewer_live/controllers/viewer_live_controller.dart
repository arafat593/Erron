import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:livekit_client/livekit_client.dart';

class ViewerLiveController extends GetxController {
  Room? room;
  late EventsListener<RoomEvent> listener;

  final isConnected = false.obs;
  final remoteVideoTracks = <RemoteVideoTrack>[].obs;

  final String liveKitUrl = "wss://liveworld-l78cuzu0.livekit.cloud";

  late String token;
  late String roomName;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    token = args['token'];
    roomName = args['room_name'];
    connectAsViewer();
  }

  Future<void> connectAsViewer() async {
    try {
      room = Room();
      listener = room!.createListener();

      await room!.connect(liveKitUrl, token);
      isConnected.value = true;

      _loadExistingTracks();
      _listenRoomEvents();
    } catch (e) {
      Get.snackbar("Live Error", "Viewer connection failed: $e");
    }
  }

  void _loadExistingTracks() {
    if (room == null) return;

    for (final participant in room!.remoteParticipants.values) {
      for (final pub in participant.videoTrackPublications) {
        final track = pub.track;
        if (track is RemoteVideoTrack &&
            !remoteVideoTracks.contains(track)) {
          remoteVideoTracks.add(track);
          debugPrint("EXISTING VIDEO TRACK ADDED ✅");
        }
      }
    }
  }



  void _listenRoomEvents() {
    listener.on<TrackSubscribedEvent>((event) {
      final track = event.track;

      if (track is RemoteVideoTrack) {
        if (!remoteVideoTracks.contains(track)) {
          remoteVideoTracks.add(track);
          debugPrint("REMOTE VIDEO SUBSCRIBED ✅");
        }
      }
    });

    listener.on<TrackUnsubscribedEvent>((event) {
      final track = event.track;

      if (track is RemoteVideoTrack) {
        remoteVideoTracks.remove(track);
        debugPrint("REMOTE VIDEO REMOVED ❌");
      }
    });
  }


  void leaveLive() {
    room?.disconnect();
    Get.back();
  }

  @override
  void onClose() {
    room?.dispose();
    super.onClose();
  }
}
