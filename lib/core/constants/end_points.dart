class EndPoints {
//Members APIs
  static String signInEndPoint = '/tokens/2fa';
  static const String signUpEndPoint = '/user';

  //Sign Up New APIs headers not EndPoints

  static const String signUpHeader = 'AWSCognitoIdentityProviderService.SignUp';
  static const String confirmSignUpHeader =
      'AWSCognitoIdentityProviderService.ConfirmSignUp';
  static const String initiateAuthHeader =
      'AWSCognitoIdentityProviderService.InitiateAuth';
  static const String forgotPasswordHeader =
      'AWSCognitoIdentityProviderService.ForgotPassword';
  static const String confirmForgotPasswordHeader =
      'AWSCognitoIdentityProviderService.ConfirmForgotPassword';
  static const String updateUserAttributesHeader =
      'AWSCognitoIdentityProviderService.UpdateUserAttributes';
  static const String getUserHeader =
      'AWSCognitoIdentityProviderService.GetUser';
  static const String getUserAttributeVerificationCode =
      'AWSCognitoIdentityProviderService.GetUserAttributeVerificationCode';
  static const String verifyUserAttribute =
      'AWSCognitoIdentityProviderService.VerifyUserAttribute';

//AsKey APIs
  static String adminLoginEndPoint = '/api/login';
  static String routerNameSetEndPoint = '/api/global_data/router_name/';
  static String routerNameGetEndPoint = '/api/global_data/router_name/';
  static String adminPasswordSetEndPoint = '/api/global_data/admin_password/';
  static String adminPasswordGetEndPoint = '/api/global_data/admin_password/';
  static String wifiListGetEndPoint = '/api/control_data/wifi_list/';
  static String wifiGetEndPoint = '/api/control_data/get_wifi/';
  static String wifiSetEndPoint = '/api/control_data/set_wifi/';
  static String roomListGetEndPoint = '/api/control_data/room_list/';
  static String roomGetEndPoint = '/api/control_data/get_room/';
  static String roomSetEndPoint = '/api/control_data/set_room/';
  static String roomsSetEndPoint = '/api/control_data/set_rooms/';
  static String roomToRoomAccessSetEndPoint = '/api/control_data/set_access/';
  static String allowedUrlListGetEndPoint = '/api/control_data/url_list/';
  static String allowedUrlGetEndPoint = '/api/control_data/get_url/';
  static String allowedUrlSetEndPoint = '/api/control_data/set_url/';
  static String deviceListGetEndPoint = '/api/control_data/device_list/';
  static String moveDeviceEndPoint = '/api/control_data/move_device/';
  static String deleteDeviceEndPoint = '/api/control_data/delete_device/';
  static String deviceBlockSetEndPoint = '/api/control_data/block_device/';
  static String systemSettingsGetEndPoint = '/api/global_data/system_setting/';
  static String timezoneSetEndPoint = '/api/global_data/time_zone/';
  static String activeLogGetEndPoint = '/api/control_data/active_log/';
  static String rebootEndPoint = '/api/reboot';
  static String factoryResetEndPoint = '/api/factory_reset';
  static String vpnGetEndPoint = '/api/current_data/get_vpn/';
  static String vpnSetEndPoint = '/api/current_data/set_vpn/';
  static String meshModeEndPoint = '/api/current_data/mesh_mode/';
  static String meshTopologyGetEndPoint = '/api/current_data/mesh_topology/';
  static String adminSetEndPoint = '/api/control_data/set_admin/';
  static String apiAccountEndPoint = '/api/global_data/api_account/';
  static String logStatusEndPoint = '/api/control_data/log_status/';
  static String setLabelEndPoint = '/api/control_data/set_label/';
  static String deviceInfoEndPoint = '/api/global_data/device_info/';
  static String vpn2GetEndPoint = '/api/current_data/get_vpn2/';
  static String vpnServerListGetEndPoint =
      '/api/current_data/get_vpn_serverlist/';
  static String vpnLoginStatusGetEndPoint =
      '/api/current_data/get_vpn_login_status/';

  static String firmwareVersionGetEndPoint =
      '/api/global_data/firmware_version/';
  static String firmwareUpgradeEndPoint = '/api/upgrade/';
  static String loadConfigEndPoint = '/api/load_config/';
  static String backupConfigEndPoint = '/api/backup_config/';
  static String managementEndPoint = '/management/';
  static String wanAccessGetEndPoint = '/api/control_data/wan_access/';
  static String wanAccessSetEndPoint = '/api/control_data/wan_access/';
}
