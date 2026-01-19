import 'dart:convert';
import 'package:errone/app/data/urls/urls.dart';
import 'package:errone/app/modules/chat/models/chat_message.dart';
import 'package:errone/app/shared_pref_service/shared_pref_service.dart';
import 'package:http/http.dart' as http;

import '../../../modules/chat/models/conversation.dart';
import '../../../modules/message/models/user_model.dart';


class ChatService {



  Future<List<UserModel>> getActiveUsers() async {
    final token = await SharedPrefService.getUserToken();
    if (token == null) return [];

    try {
      final url = Uri.parse(Urls.chatActiveUser);
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => UserModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      print("Error fetching active users: $e");
      return [];
    }
  }

  Future<List<ChatMessage>> getChatHistory(String receiverId, {int skip = 0, int limit = 50}) async {
    final token = await SharedPrefService.getUserToken();
    if (token == null) return [];

    try {
      final url = Uri.parse("https://erronliveapp.mtscorporate.com/api/v1/chat/history/$receiverId?skip=$skip&limit=$limit");
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => ChatMessage.fromJson(e)).toList();
      } else {
        return [];
      }
    } catch (e) {
      print("Error fetching chat history: $e");
      return [];
    }
  }

  Future<String?> uploadImage(String filePath) async {
    final token = await SharedPrefService.getUserToken();
    if (token == null) return null;

    try {
      final url = Uri.parse(Urls.uploadImage);
      var request = http.MultipartRequest('POST', url);
      request.headers['Authorization'] = 'Bearer $token';
      request.files.add(await http.MultipartFile.fromPath('file', filePath));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['image_url'];
      }
      return null;
    } catch (e) {
      print("Error uploading chat image: $e");
      return null;
    }
  }

  Future<List<Conversation>> getConversations() async {
    final token = await SharedPrefService.getUserToken();
    if (token == null) return [];

    try {
      final url = Uri.parse(Urls.conversation);
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => Conversation.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      print("Error fetching conversations: $e");
      return [];
    }
  }

  Future<List<UserModel>> searchUsers(String query) async {
    final token = await SharedPrefService.getUserToken();
    if (token == null) return [];

    try {
      final url = Uri.parse(Urls.search(query));
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => UserModel.fromJson(e)).toList();
      }
      return [];
    } catch (e) {
      print("Error searching users: $e");
      return [];
    }
  }

  Future<void> markAsRead(String senderId) async {
    final token = await SharedPrefService.getUserToken();
    if (token == null) return;

    try {
      final url = Uri.parse(Urls.readMessage(senderId));
      await http.put(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'accept': 'application/json'
        },
      );
    } catch (e) {
      print("Error marking messages as read: $e");
    }
  }
}