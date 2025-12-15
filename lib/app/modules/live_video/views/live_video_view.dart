import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/live_video_controller.dart';

class LiveVideoView extends GetView<LiveVideoController> {
  const LiveVideoView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LiveVideoView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LiveVideoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
