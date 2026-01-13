import 'package:errone/app/modules/live/models/live_stream_model.dart';
import 'package:errone/app/shared_pref_service/shared_pref_service.dart';
import 'package:get/get.dart';


class LiveStreamProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'https://eron.mtscorporate.com/api/v1';

    httpClient.addRequestModifier<dynamic>((request) async {
      final token = await SharedPrefService.getUserToken();
      if (token == null) {
        // Optionally redirect to login, but handle gracefully
      }
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });
  }

  // Placeholder for fetching active lives via HTTP if available
  Future<List<LiveStreamModel>> getActiveLiveStreams() async {
    final response = await get('/live/active');
    if (response.status.hasError) {
      return [];
    } else {
      List<dynamic> data = response.body;
      return data.map((json) => LiveStreamModel.fromJson(json)).toList();
    }
  }

  Future<List<LiveStreamModel>> getUserLiveStreams({int skip = 0, int limit = 10}) async {
    final response = await get('/live/all_livestream/user?skip=$skip&limit=$limit');
    if (response.status.hasError) {
      return [];
    } else {
      List<dynamic> data = response.body;
      return data.map((json) => LiveStreamModel.fromJson(json)).toList();
    }
  }
}