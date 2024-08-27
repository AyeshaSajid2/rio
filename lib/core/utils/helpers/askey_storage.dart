import 'package:get_storage/get_storage.dart';

import '../../../app/data/models/admin_login/admin_login_model.dart';
import '../../../app/data/models/admin_login/get_admin_password_model.dart';
import '../../../app/data/models/room/get_room_list_model.dart';
import '../../../app/data/models/router_name/get_device_info_model.dart';
import '../../../app/data/models/settings/get_wan_access_model.dart';
import '../../../app/data/models/vpn/get_vpn_server_list_model.dart';
import '../../../app/data/models/wifi/get_wifi_list_model.dart';

AsKeyStorage asKeyStorage = AsKeyStorage();

class AsKeyStorage {
  static final AsKeyStorage _asKeyStorage = AsKeyStorage._i();
  final GetStorage _asKeyBox = GetStorage('AsKey');

  factory AsKeyStorage() {
    return _asKeyStorage;
  }

  AsKeyStorage._i();

  Future<bool> initAsKeyStorage() async {
    return await GetStorage.init('AsKey');
  }

  bool getAsKeyAdminRememberMe() {
    return _asKeyBox.read("AdminRememberMe") ?? true;
  }

  Future<void> saveAsKeyAdminRememberMe(bool value) {
    return _asKeyBox.write("AdminRememberMe", value);
  }

  String getAsKeyAdminUserName() {
    return _asKeyBox.read("AdminUserName") ?? 'admin';
  }

  Future<void> saveAsKeyAdminUserName(String userName) {
    return _asKeyBox.write("AdminUserName", userName);
  }

  String getAsKeyAdminPassword() {
    return _asKeyBox.read("AdminPassword") ?? '';
  }

  Future<void> saveAsKeyAdminPassword(String password) {
    return _asKeyBox.write("AdminPassword", password);
  }

  String getAsKeyDeviceToken() {
    return _asKeyBox.read("DeviceToken") ?? '';
  }

  Future<void> saveAsKeyDeviceToken(String deviceToken) {
    return _asKeyBox.write("DeviceToken", deviceToken);
  }

  bool getAsKeyLoggedIn() {
    return _asKeyBox.read("AsKeyLoggedIn") ?? false;
  }

  Future<void> saveAsKeyLoggedIn(bool value) {
    return _asKeyBox.write("AsKeyLoggedIn", value);
  }

  bool getAsKeyResetStatus() {
    return _asKeyBox.read("AsKeyResetStatus") ?? true;
  }

  Future<void> saveAsKeyResetStatus(bool value) {
    return _asKeyBox.write("AsKeyResetStatus", value);
  }

  AdminLoginModel getAdminLoginModel() {
    return _asKeyBox.read<AdminLoginModel>("AdminLoginModel")!;
  }

  Future<void> saveAdminLoginModel(AdminLoginModel initAuthModel) {
    return _asKeyBox.write("AdminLoginModel", initAuthModel);
  }

  String getAsKeyToken() {
    return _asKeyBox.read("Token") ?? '';
  }

  Future<void> saveAsKeyToken(String token) {
    return _asKeyBox.write("Token", token);
  }

  String getAsKeyRouterSerialNumber() {
    return _asKeyBox.read("RouterSerialNumber") ?? '';
  }

  Future<void> saveAsKeyRouterSerialNumber(String serialNumber) {
    return _asKeyBox.write("RouterSerialNumber", serialNumber);
  }

  GetDeviceInfoModel getAsKeyGetDeviceInfoModel() {
    return getDeviceInfoModelFromJson(_asKeyBox.read('GetDeviceInfoModel')!);
  }

  Future<void> saveAsKeyGetDeviceInfoModel(
      GetDeviceInfoModel getDeviceInfoModel) {
    return _asKeyBox.write(
        "GetDeviceInfoModel", getDeviceInfoModelToJson(getDeviceInfoModel));
  }

  // String getAsKeyLastSpeedTestDate() {
  //   return _asKeyBox.read("LastSpeedTestDate");
  // }

  // Future<void> saveAsKeyLastSpeedTestDate(String lastSpeedTestDate) {
  //   return _asKeyBox.write("LastSpeedTestDate", lastSpeedTestDate);
  // }

  GetAdminPasswordModel getAsKeyGetAdminPasswordModel() {
    return getAdminPasswordModelFromJson(
        _asKeyBox.read('GetAdminPasswordModel')!);
  }

  Future<void> saveAsKeyGetAdminPasswordModel(
      GetAdminPasswordModel getAdminPasswordModel) {
    return _asKeyBox.write("GetAdminPasswordModel",
        getAdminPasswordModelToJson(getAdminPasswordModel));
  }

  GetWifiListModel getAsKeyWifiListModel() {
    return getWifiListModelFromJson(_asKeyBox.read('GetWifiListModel')!);
  }

  Future<void> saveAsKeyWifiListModel(GetWifiListModel wifiListModel) {
    return _asKeyBox.write(
        "GetWifiListModel", getWifiListModelToJson(wifiListModel));
  }

  GetRoomListModel getAsKeyRoomListModel() {
    return getRoomListModelFromJson(_asKeyBox.read('GetRoomListModel')!);
  }

  Future<void> saveAsKeyRoomListModel(GetRoomListModel roomListModel) {
    return _asKeyBox.write(
        "GetRoomListModel", getRoomListModelToJson(roomListModel));
  }

  GetVpnServerListModel? getAsKeyVPNServerListModel() {
    return _asKeyBox.read('GetVpnServerListModel') != null
        ? getVpnServerListModelFromJson(
            _asKeyBox.read('GetVpnServerListModel')!)
        : null;
  }

  Future<void> saveAsKeyVPNServerListModel(
      GetVpnServerListModel vpnServerListModel) {
    return _asKeyBox.write("GetVpnServerListModel",
        getVpnServerListModelToJson(vpnServerListModel));
  }

  GetWanAccessModel? getAsKeyWanAccessModel() {
    return _asKeyBox.read('GetWanAccessModel') != null
        ? getWanAccessModelFromJson(_asKeyBox.read('GetWanAccessModel')!)
        : null;
  }

  Future<void> saveAsKeyWanAccessModel(GetWanAccessModel getWanAccessModel) {
    return _asKeyBox.write(
        "GetWanAccessModel", getWanAccessModelToJson(getWanAccessModel));
  }

  // String getAsKeyAdminPassword() {
  //   return _asKeyBox.read("AdminRememberMe");
  // }

  // Future<void> saveAsKeyAdminPassword(String password) {
  //   return _asKeyBox.write("AdminRememberMe", password);
  // }

  // String getAsKeyAdminPassword() {
  //   return _asKeyBox.read("AdminRememberMe");
  // }

  // Future<void> saveAsKeyAdminPassword(String password) {
  //   return _asKeyBox.write("AdminRememberMe", password);
  // }

  // String getAsKeyAdminPassword() {
  //   return _asKeyBox.read("AdminRememberMe");
  // }

  // Future<void> saveAsKeyAdminPassword(String password) {
  //   return _asKeyBox.write("AdminRememberMe", password);
  // }

  // String getAsKeyAdminPassword() {
  //   return _asKeyBox.read("AdminRememberMe");
  // }

  // Future<void> saveAsKeyAdminPassword(String password) {
  //   return _asKeyBox.write("AdminRememberMe", password);
  // }
}
