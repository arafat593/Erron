// import 'package:errone/app/routes/app_pages.dart';
// import 'package:errone/app/shared_pref_service/shared_pref_service.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
//
// class ActiveUserGetService {
//   static Future<dynamic> activeUserRequest(String url) async {
//     String? token =await SharedPrefService.getUserToken();
//     if(token == null){
//       Get.toNamed(Routes.LOGIN);
//     }
//     try {
//       final response = await http.get(
//         Uri.parse(url),
//         headers: {
//           "Content-Type": "application/json",
//           "Authorization": "Bearer $token",
//         },
//       );
//       return response;
//     } catch (e) {
//       throw "Request failed $e";
//     }
//   }
// }