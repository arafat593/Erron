import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:livekit_client/livekit_client.dart';

import '../controllers/viewer_live_controller.dart';

class ViewerLiveView extends GetView<ViewerLiveController> {
  const ViewerLiveView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (!controller.isConnected.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.white),
          );
        }

        return Stack(
          children: [

            if (controller.remoteVideoTracks.isNotEmpty)
        Positioned.fill(
          child: VideoTrackRenderer(
            controller.remoteVideoTracks.first,
          ),
        )
        else
        const Center(
        child: Text(
        "Waiting for host...",
        style: TextStyle(color: Colors.white),
        ),
        ),

            Positioned(
              top: 50,
              right: 20,
              child: GestureDetector(
                onTap: controller.leaveLive,
                child: const CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.red,
                  child: Icon(Icons.close, color: Colors.white),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
