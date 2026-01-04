import 'package:errone/app/routes/app_pages.dart';
import 'package:errone/app/shared_pref_service/shared_pref_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../modules/message/models/active_user_model.dart';
import '../../../modules/message/models/chat_message.dart';



class ChatProvider extends GetConnect {
  ChatProvider() {
    httpClient.baseUrl = 'https://eron.mtscorporate.com/api/v1';

    httpClient.addRequestModifier<dynamic>((request) async {
     // final token = GetStorage().read('token');
      final token = await SharedPrefService.getUserToken();

      if (token != null && token.toString().isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }

      return request;
    }


    // httpClient.addRequestModifier<dynamic>((request) {
    //   final token = GetStorage().read('token');
    //   if (token == null) {
    //
    //     Get.toNamed(Routes.LOGIN); // Assuming Bearer token
    //   }
    //   if (token != null) {
    //     request.headers['Authorization'] = 'Bearer $token'; // Assuming Bearer token
    //   }
    //   return request;
    // }

    );
  }

  Future<List<ActiveUser>> getActiveUsers() async {
    final response = await get('/chat/active-users');

    if (response.status.hasError) {
      return Future.error(response.statusText ?? 'Error');
    }

    final List data = response.body;
    return data.map((e) => ActiveUser.fromJson(e)).toList();
  }

  // Future<List<ActiveUser>> getActiveUsers() async {
  //   final response = await get('/chat/active-users');
  //   if (response.status.hasError) {
  //     return Future.error(response.statusText ?? 'Error fetching users');
  //   } else {
  //     List<dynamic> data = response.body;
  //     return data.map((json) => ActiveUser.fromJson(json)).toList();
  //   }
  // }

  Future<List<ChatMessage>> getChatHistory(String otherUserId, String currentUserId) async {
    final response = await get('/chat/history/$otherUserId');
    if (response.status.hasError) {
      return Future.error(response.statusText ?? 'Error fetching history');
    } else {
      List<dynamic> data = response.body;
      return data.map((json) => ChatMessage.fromJson(json, currentUserId)).toList();
    }
  }

  // Helper to get profile for ID
  Future<ActiveUser?> getMyProfile() async {
    final response = await get('/users/users/my_profile');
    if (response.status.hasError) {
      return null;
    } else {
      // Assuming response body is UserModel structure. ActiveUser requires specific fields.
      // Mapping UserModel to ActiveUser temporarily for ID or returning a lightweight object.
      // Actually I just need the ID.
      final data = response.body;
      return ActiveUser(
          userId: data['_id'],
          fullName: "${data['first_name']} ${data['last_name']}",
          profileImage: data['profile_image'] ?? '',
          isFollowing: false
      );
    }
  }
}