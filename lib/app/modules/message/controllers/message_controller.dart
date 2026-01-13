// lib/app/modules/message/controllers/message_controller.dart
import 'package:get/get.dart';
import '../../../data/service/socket_service.dart';
import '../../../data/api_service/chat_provider/chat_provider.dart';
import '../models/active_user_model.dart';
import '../../../routes/app_pages.dart'; // Routes import করুন

class MessageController extends GetxController {
  final SocketService socketService = Get.find();
  final ChatProvider provider = ChatProvider();
  final activeUsers = <ActiveUser>[].obs;
  final isLoadingUsers = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await socketService.connect();
    await fetchActiveUsers();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchActiveUsers() async {
    isLoadingUsers.value = true;
    try {
      final users = await provider.getActiveUsers();
      activeUsers.assignAll(users);
      print("ACTIVE USERS COUNT: ${users.length}");
    } catch (e) {
      print("Active user error: $e");
      Get.snackbar('Error', 'Failed to load active users: $e');
    } finally {
      isLoadingUsers.value = false;
    }
  }

  void selectUser(ActiveUser user) {
    // সঠিক route name ব্যবহার করুন
    Get.toNamed(Routes.CHAT_SCREEN, arguments: user);

    // Debugging এর জন্য
    print('Navigating to: ${Routes.CHAT_SCREEN}');
    print('User: ${user.fullName}');
  }

  Future<void> refreshActiveUsers() async {
    await fetchActiveUsers();
  }
}

/*
import 'dart:convert';
import 'package:errone/app/data/service/socket_service.dart';
import 'package:errone/app/modules/message/models/active_user_model.dart';
import 'package:errone/app/modules/message/models/chat_message.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../data/api_service/chat_provider/chat_provider.dart';

class MessageController extends GetxController {

  final SocketService socketService = Get.find();
  final ChatProvider provider = ChatProvider();
  final messages = <ChatMessage>[].obs;
  final activeUsers = <ActiveUser>[].obs;

  final isLoadingUsers = true.obs;
  String currentUserId = '';

  // Selected user to chat with
  final selectedUser = Rxn<ActiveUser>();

  final messageController = TextEditingController();

  @override
  Future<void> onInit() async {
    super.onInit();

    await socketService.connect();

   await fetchActiveUsers();
   await fetchMyProfile();

    // Listen to incoming messages
    ever(socketService.incomingMessages, (String message) {
      if (message.isNotEmpty && selectedUser.value != null) {
        try {
          final data = jsonDecode(message);
          // Incoming: { "sender_id": ..., "message": ..., "timestamp": ... }
          final senderId = data['sender_id'];
          final currentChatId = selectedUser.value!.userId;

          if (senderId == currentChatId) {
            final newMessage = ChatMessage(
              id: data['_id'] ?? 'socket_${DateTime.now().millisecondsSinceEpoch}',
              senderId: senderId,
              receiverId: currentUserId,
              message: data['message'],
              timestamp: DateTime.tryParse(data['timestamp'] ?? '') ?? DateTime.now(),
              isMe: false,
            );
            messages.add(newMessage);
          }
        } catch(e){
          print("Error parsing message: $e");
        }
      }
    });
  }

  Future<void> fetchMyProfile() async {
    try {
      final profile = await provider.getMyProfile();
      if (profile != null) {
        currentUserId = profile.userId;
      }
    } catch (e) {
      print("Error fetching profile: $e");
    }
  }

  Future<void> fetchActiveUsers() async {
    isLoadingUsers.value = true;
    try {
      final users = await provider.getActiveUsers();
      activeUsers.assignAll(users);
      print("ACTIVE USERS COUNT: ${users.length}");
    } catch (e) {
      print("Active user error: $e");
      Get.snackbar('Error', 'Failed to load active users: $e');
    } finally {
      isLoadingUsers.value = false;
    }
  }

  void selectUser(ActiveUser user) async {
    selectedUser.value = user;
    messages.clear();

    // Fetch History
    try {
      if (currentUserId.isNotEmpty) {
        final history = await provider.getChatHistory(user.userId, currentUserId);
        messages.assignAll(history);
      } else {
        await fetchMyProfile();
        if (currentUserId.isNotEmpty) {
          final history = await provider.getChatHistory(user.userId, currentUserId);
          messages.assignAll(history);
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load history");
    }
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty || selectedUser.value == null) return;

    final receiverId = selectedUser.value!.userId;

    final msgObj = {
      "receiver_id": receiverId,
      "message": text
    };


    print("msgObj: $msgObj");
    print("called 1");

    socketService.sendMessage(jsonEncode(msgObj));
    print("called 2");

    // Optimistic UI update
    messages.add(ChatMessage(
      id: 'local_${DateTime.now().millisecondsSinceEpoch}',
      senderId: currentUserId,
      receiverId: receiverId,
      message: text,
      timestamp: DateTime.now(),
      isMe: true,
    ));

    messageController.clear();
  }

  @override
  void onClose() {
    socketService.disconnect();
    messageController.dispose();
    super.onClose();
  }
}

*/
