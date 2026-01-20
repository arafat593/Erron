import 'package:get/get.dart';

import '../modules/chat/bindings/chat_screen_binding.dart';
import '../modules/chat/views/chat_screen_view.dart';
import '../modules/custom_bottom_bar/bindings/custom_bottom_bar_binding.dart';
import '../modules/custom_bottom_bar/views/custom_bottom_bar_view.dart';
import '../modules/edit_profile/bindings/edit_profile_binding.dart';
import '../modules/edit_profile/views/edit_profile_view.dart';
import '../modules/email_verification/bindings/email_verification_binding.dart';
import '../modules/email_verification/views/email_verification_view.dart';
import '../modules/email_verification_code/bindings/email_verification_code_binding.dart';
import '../modules/email_verification_code/views/email_verification_code_view.dart';
import '../modules/explore/bindings/explore_binding.dart';
import '../modules/explore/views/explore_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/live_room/bindings/live_room_binding.dart';
import '../modules/live_room/views/live_room_view.dart';
import '../modules/live_stream/bindings/live_stream_binding.dart';
import '../modules/live_stream/views/live_stream_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/message/bindings/message_binding.dart';
import '../modules/message/views/message_view.dart';
import '../modules/new_password/bindings/new_password_binding.dart';
import '../modules/new_password/views/new_password_view.dart';
import '../modules/onBoarding/bindings/on_boarding_binding.dart';
import '../modules/onBoarding/views/on_boarding_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/signUp_verification_code/bindings/sign_up_verification_code_binding.dart';
import '../modules/signUp_verification_code/views/sign_up_verification_code_view.dart';
import '../modules/viewer_live/bindings/viewer_live_binding.dart';
import '../modules/viewer_live/views/viewer_live_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ON_BOARDING;

  static final routes = <GetPage>[
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP_VERIFICATION_CODE,
      page: () => SignUpVerificationCodeView(),
      binding: SignUpVerificationCodeBinding(),
    ),
    GetPage(
      name: _Paths.EMAIL_VERIFICATION,
      page: () => EmailVerificationView(),
      binding: EmailVerificationBinding(),
    ),
    GetPage(
      name: _Paths.EMAIL_VERIFICATION_CODE,
      page: () => EmailVerificationCodeView(),
      binding: EmailVerificationCodeBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOM_BOTTOM_BAR,
      page: () => const CustomBottomBarView(),
      binding: CustomBottomBarBinding(),
    ),
    GetPage(
      name: _Paths.EXPLORE,
      page: () => const ExploreView(),
      binding: ExploreBinding(),
    ),
    GetPage(
      name: _Paths.MESSAGE,
      page: () => const MessageView(),
      binding: MessageBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_SCREEN,
      page: () => const ChatScreenView(),
      binding: ChatScreenBinding(),
    ),
    GetPage(
      name: _Paths.ON_BOARDING,
      page: () => const OnBoardingView(),
      binding: OnBoardingBinding(),
    ),
    GetPage(
      name: _Paths.LIVE_STREAM,
      page: () => LiveStreamView(),
      binding: LiveStreamBinding(),
    ),
    GetPage(
      name: _Paths.LIVE_ROOM,
      page: () => const LiveRoomView(),
      binding: LiveRoomBinding(),
    ),
    GetPage(
      name: _Paths.VIEWER_LIVE,
      page: () => const ViewerLiveView(),
      binding: ViewerLiveBinding(),
    ),
    GetPage(
      name: _Paths.EDIT_PROFILE,
      page: () => const EditProfileView(),
      binding: EditProfileBinding(),
    ),
  ];
}
