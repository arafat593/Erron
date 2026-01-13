// lib/app/modules/chat/controllers/chat_controller.dart
import 'dart:convert';
import 'package:errone/app/modules/message/models/active_user_model.dart';
import 'package:errone/app/modules/message/models/chat_message.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../data/api_service/chat_provider/chat_provider.dart';
import '../../../data/service/socket_service.dart';

class ChatController extends GetxController {
  final SocketService socketService = Get.find();
  final ChatProvider provider = ChatProvider();

  final messages = <ChatMessage>[].obs;
  final ActiveUser selectedUser;
  String currentUserId = '';

  final messageController = TextEditingController();

  // Callback reference রাখব
  MessageCallback? _messageCallback;

  ChatController(this.selectedUser);

  @override
  Future<void> onInit() async {
    super.onInit();

    await fetchMyProfile();
    await fetchChatHistory();

    // Callback define করব
    _messageCallback = (String message) {
      _handleIncomingMessage(message);
    };

    // Callback register করব
    socketService.addMessageListener(_messageCallback!);
  }

  void _handleIncomingMessage(String message) {
    if (message.isNotEmpty) {
      try {
        final data = jsonDecode(message);
        final senderId = data['sender_id'];

        if (senderId == selectedUser.userId) {
          final newMessage = ChatMessage(
            id: data['_id'] ?? 'socket_${DateTime.now().millisecondsSinceEpoch}',
            senderId: senderId,
            receiverId: currentUserId,
            message: data['message'],
            timestamp: DateTime.tryParse(data['timestamp'] ?? '') ?? DateTime.now(),
            isMe: false,
          );
          messages.add(newMessage);

          // Optional: Scroll to bottom after new message
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // এখানে আপনি ListView scroll করতে পারেন যদি প্রয়োজন হয়
          });
        }
      } catch(e) {
        print("Error parsing message: $e");
      }
    }
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

  Future<void> fetchChatHistory() async {
    try {
      if (currentUserId.isNotEmpty) {
        final history = await provider.getChatHistory(selectedUser.userId, currentUserId);
        messages.assignAll(history);
      } else {
        await fetchMyProfile();
        if (currentUserId.isNotEmpty) {
          final history = await provider.getChatHistory(selectedUser.userId, currentUserId);
          messages.assignAll(history);
        }
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load chat history");
    }
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    final msgObj = {
      "receiver_id": selectedUser.userId,
      "message": text
    };

    socketService.sendMessage(jsonEncode(msgObj));

    // Optimistic UI update
    messages.add(ChatMessage(
      id: 'local_${DateTime.now().millisecondsSinceEpoch}',
      senderId: currentUserId,
      receiverId: selectedUser.userId,
      message: text,
      timestamp: DateTime.now(),
      isMe: true,
    ));

    messageController.clear();
  }

  @override
  void onClose() {
    // Callback unregister করব
    if (_messageCallback != null) {
      socketService.removeMessageListener(_messageCallback!);
    }

    messageController.dispose();
    super.onClose();
  }
}