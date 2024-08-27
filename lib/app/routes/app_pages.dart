import 'package:get/get.dart';
import 'package:usama/app/modules/ssid_check/bindings/ssid_check_binding.dart';
import 'package:usama/app/modules/ssid_check/views/exting_router_inquiry_view.dart';
import 'package:usama/app/modules/wifi_onboarding/bindings/wifi_onboarding_binding.dart';
import 'package:usama/app/modules/wifi_onboarding/views/wifi_onboarding_view.dart';

import '../modules/activity_log/bindings/activity_log_binding.dart';
import '../modules/activity_log/views/activity_log_view.dart';
import '../modules/add_room/bindings/add_room_binding.dart';
import '../modules/add_room/views/add_room_view.dart';
import '../modules/add_wireless_network/bindings/add_wireless_network_binding.dart';
import '../modules/add_wireless_network/views/add_wireless_network_view.dart';
import '../modules/admin_login/bindings/admin_login_binding.dart';
import '../modules/admin_login/views/admin_login_view.dart';
import '../modules/back_up/bindings/back_up_binding.dart';
import '../modules/back_up/views/back_up_view.dart';
import '../modules/change_admin_password/bindings/change_admin_password_binding.dart';
import '../modules/change_admin_password/views/change_admin_password_view.dart';
import '../modules/customer_support/bindings/customer_support_binding.dart';
import '../modules/customer_support/views/customer_support_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/device_details/bindings/device_details_binding.dart';
import '../modules/device_details/views/device_details_view.dart';
import '../modules/devices/bindings/devices_binding.dart';
import '../modules/devices/views/devices_view.dart';
import '../modules/firmware_update/bindings/firmware_update_binding.dart';
import '../modules/firmware_update/views/firmware_update_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/forgot_router_password/bindings/forgot_router_password_binding.dart';
import '../modules/forgot_router_password/views/forgot_router_password_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/mesh/bindings/mesh_binding.dart';
import '../modules/mesh/views/mesh_view.dart';
import '../modules/mobile_no_verify/bindings/mobile_no_verify_binding.dart';
import '../modules/mobile_no_verify/views/mobile_no_verify_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view_0.dart';
import '../modules/passwords/bindings/passwords_binding.dart';
import '../modules/passwords/views/passwords_view.dart';
import '../modules/progress/bindings/progress_binding.dart';
import '../modules/progress/views/progress_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/router_password_change/bindings/router_password_change_binding.dart';
import '../modules/router_password_change/views/router_password_change_view.dart';
import '../modules/router_setup/bindings/router_setup_binding.dart';
import '../modules/router_setup/views/router_setup_info_view.dart';
import '../modules/scanner/bindings/scanner_binding.dart';
import '../modules/scanner/views/scanner_view.dart';
import '../modules/secure_room/bindings/secure_room_binding.dart';
import '../modules/secure_room/views/secure_room_view.dart';
import '../modules/secure_room_tabs/bindings/secure_room_tabs_binding.dart';
import '../modules/secure_room_tabs/views/secure_room_tabs_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/share_password/bindings/share_password_binding.dart';
import '../modules/share_password/views/share_password_view.dart';
import '../modules/sign_in/bindings/sign_in_binding.dart';
import '../modules/sign_in/views/sign_in_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';
import '../modules/speed_test/bindings/speed_test_binding.dart';
import '../modules/speed_test/views/speed_test_web_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/welcome_view.dart';
import '../modules/verify/bindings/verify_binding.dart';
import '../modules/verify/views/verify_view.dart';
import '../modules/vpn/bindings/vpn_binding.dart';
import '../modules/vpn/views/vpn_view.dart';
import '../modules/wireless_network/bindings/wireless_network_binding.dart';
import '../modules/wireless_network/views/wireless_network_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  // ignore: constant_identifier_names
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const WelcomeView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_IN,
      page: () => const SignInView(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.VERIFY,
      page: () => const VerifyView(),
      binding: VerifyBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARDING,
      page: () => const OnboardingView0(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.ROUTER_SETUP,
      page: () => const RouterSetupInfoView(),
      binding: RouterSetupBinding(),
    ),
    GetPage(
      name: _Paths.SSID_CHECK,
      page: () => const ExistingRouterInquiryView(),
      binding: SsidCheckBinding(),
    ),
    GetPage(
      name: _Paths.WIFI_ONBOARDING,
      page: () => const WifiOnboardingView(),
      binding: WifiOnboardingBinding(),
    ),
    // GetPage(
    //   name: _Paths.CONNECTION_TIMER,
    //   page: () => const ConnectionTimerView(),
    //   binding: ConnectionTimerBinding(),
    // ),
    // GetPage(
    //   name: _Paths.ENABLE_ROUTER,
    //   page: () => const EnableRouterView(),
    //   binding: EnableRouterBinding(),
    // ),
    GetPage(
      name: _Paths.SECURE_ROOM,
      page: () => const SecureRoomView(),
      binding: SecureRoomBinding(),
    ),
    GetPage(
      name: _Paths.SPEED_TEST,
      // page: () => const SpeedTestView(),
      page: () => const SpeedTestWebView(),
      binding: SpeedTestBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.SHARE_PASSWORD,
      page: () => const SharePasswordView(),
      binding: SharePasswordBinding(),
    ),
    GetPage(
      name: _Paths.VPN,
      page: () => const VpnView(),
      binding: VpnBinding(),
    ),
    GetPage(
      name: _Paths.WIRELESS_NETWORK,
      page: () => const WirelessNetworkView(),
      binding: WirelessNetworkBinding(),
    ),
    GetPage(
      name: _Paths.SECURE_ROOM_TABS,
      page: () => const SecureRoomTabsView(),
      binding: SecureRoomTabsBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_LOGIN,
      page: () => const AdminLoginView(),
      binding: AdminLoginBinding(),
    ),
    GetPage(
      name: _Paths.ADD_WIRELESS_NETWORK,
      page: () => const AddWirelessNetworkView(),
      binding: AddWirelessNetworkBinding(),
    ),
    GetPage(
      name: _Paths.ACTIVITY_LOG,
      page: () => const ActivityLogView(),
      binding: ActivityLogBinding(),
    ),
    // GetPage(
    //   name: _Paths.SET_API_ACCOUNT,
    //   page: () => const SetApiAccountView(),
    //   binding: SetApiAccountBinding(),
    // ),
    GetPage(
      name: _Paths.MESH,
      page: () => const MeshView(),
      binding: MeshBinding(),
    ),
    GetPage(
      name: _Paths.CHANGE_ADMIN_PASSWORD,
      page: () => const ChangeAdminPasswordView(),
      binding: ChangeAdminPasswordBinding(),
    ),
    GetPage(
      name: _Paths.SCANNER,
      page: () => const ScannerView(),
      binding: ScannerBinding(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ADD_ROOM,
      page: () => const AddRoomView(),
      binding: AddRoomBinding(),
    ),
    GetPage(
      name: _Paths.DEVICE_DETAILS,
      page: () => const DeviceDetailsView(),
      binding: DeviceDetailsBinding(),
    ),
    GetPage(
      name: _Paths.DEVICES,
      page: () => const DevicesView(),
      binding: DevicesBinding(),
    ),
    GetPage(
      name: _Paths.PASSWORDS,
      page: () => const PasswordsView(),
      binding: PasswordsBinding(),
    ),
    GetPage(
      name: _Paths.MOBILE_NO_VERIFY,
      page: () => const MobileNoVerifyView(),
      binding: MobileNoVerifyBinding(),
    ),
    GetPage(
      name: _Paths.PROGRESS,
      page: () => const ProgressView(),
      binding: ProgressBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_ROUTER_PASSWORD,
      page: () => const ForgotRouterPasswordView(),
      binding: ForgotRouterPasswordBinding(),
    ),
    GetPage(
      name: _Paths.ROUTER_PASSWORD_CHANGE,
      page: () => const RouterPasswordChangeView(),
      binding: RouterPasswordChangeBinding(),
    ),
    GetPage(
      name: _Paths.FIRMWARE_UPDATE,
      page: () => const FirmwareUpdateView(),
      binding: FirmwareUpdateBinding(),
    ),
    GetPage(
      name: _Paths.BACK_UP,
      page: () => const BackUpView(),
      binding: BackUpBinding(),
    ),
    GetPage(
      name: _Paths.CUSTOMER_SUPPORT,
      page: () => const CustomerSupportView(),
      binding: CustomerSupportBinding(),
    ),
  ];
}
