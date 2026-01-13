import 'package:errone/app/modules/profile/models/profile_model.dart';
import 'package:errone/app/shared_pref_service/shared_pref_service.dart';
import 'package:get/get.dart';


class ProfileProvider extends GetConnect {
  @override
  void onInit() {

    httpClient.baseUrl = 'https://eron.mtscorporate.com/api/v1';

    httpClient.addRequestModifier<dynamic>((request) async {
      final token = await SharedPrefService.getUserToken();
      if (token != null) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });
  }

  Future<ProfileModel?> getMyProfile() async {
    final response = await get('/users/users/my_profile');
    if (response.status.hasError) {
      print("Error getting profile: ${response.statusText}");
      return null;
    } else {
      return ProfileModel.fromJson(response.body);
    }
  }
}