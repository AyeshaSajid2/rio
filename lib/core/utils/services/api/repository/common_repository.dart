import '../../../../../app/data/models/device/get_device_list_model.dart';
import '../../../../../app/data/models/room/get_room_list_model.dart';
import '../../../../../app/data/models/settings/get_firmware_version.dart';
import '../../../../../app/data/models/settings/get_system_setting_model.dart';
import '../../../../../app/data/models/settings/get_wan_access_model.dart';
import '../../../../../app/data/models/wifi/get_wifi_list_model.dart';
import '../../../../../app/data/params/device/get_device_list_param.dart';
import '../../../../../app/data/params/error_logs_param.dart';
import '../../../../../app/data/params/rooms/get_room_list_param.dart';
import '../../../../extensions/imports.dart';
import '../../../helpers/askey_storage.dart';

class CommonRepo {
  FutureWithEither<GetWifiListModel> getWifiList() async {
    String url = AppConstants.baseUrlAsKey + EndPoints.wifiListGetEndPoint;
    final response = await apiUtilsWithHeader.get(url: url, firstTime: true);

    return response.fold((l) => left(l), (r) {
      GetWifiListModel getWifiListModel = GetWifiListModel.fromJson(r.data);

      asKeyStorage.saveAsKeyWifiListModel(getWifiListModel);

      return right(getWifiListModel);
    });
  }

  GetRoomListParam fillGetAllRooms() {
    return GetRoomListParam(type: 'none', id: '0');
  }

  GetRoomListParam fillGetAllRoomsOfSSID(String ssid) {
    return GetRoomListParam(type: 'ssid', id: ssid);
  }

  GetRoomListParam fillGetAllowedRoomsOfDevice(int deviceId) {
    return GetRoomListParam(type: 'device', id: '$deviceId');
  }

  Future<GetRoomListModel?> getRoomList(
      GetRoomListParam getRoomListParam) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);

      return null;
    }

    Map params = getRoomListParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.roomListGetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);
    return response.fold((l) {
      return null;
    }, (r) {
      GetRoomListModel getRoomListModel = GetRoomListModel.fromJson(r.data);

      if (getRoomListParam.type == 'none') {
        asKeyStorage.saveAsKeyRoomListModel(getRoomListModel);
      }

      return getRoomListModel;
    });
  }

  GetDeviceListParam fillGetAllDevices() {
    return GetDeviceListParam(id: '0', type: 'all');
  }

  GetDeviceListParam fillGetWaitingDevices() {
    return GetDeviceListParam(id: '0', type: 'wait');
  }

  GetDeviceListParam fillGetDevicesOfRoom(String roomId) {
    return GetDeviceListParam(id: roomId, type: 'room');
  }

  GetDeviceListParam fillGetBlockedDevices() {
    return GetDeviceListParam(id: '0', type: 'block');
  }

  Future<GetDeviceListModel?> getDeviceList(
      GetDeviceListParam getDeviceListParam) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);

      return null;
    }

    Map params = getDeviceListParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.deviceListGetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);
    return response.fold((l) {
      return null;
    }, (r) async {
      var getDevicesListModel = GetDeviceListModel.fromJson(r.data);

      return getDevicesListModel;
    });
  }

  Future<GetWanAccessModel?> getWanAccess() async {
    String url = AppConstants.baseUrlAsKey + EndPoints.wanAccessGetEndPoint;

    final response = await apiUtilsWithHeader.get(url: url, firstTime: true);
    return response.fold((l) {
      return null;
    }, (r) async {
      GetWanAccessModel getWanAccessModel = GetWanAccessModel.fromJson(r.data);

      asKeyStorage.saveAsKeyWanAccessModel(getWanAccessModel);

      return getWanAccessModel;
    });
  }

  FutureWithEither<GetSystemSettingModel> getSystemSettings() async {
    String url =
        AppConstants.baseUrlAsKey + EndPoints.systemSettingsGetEndPoint;

    final response = await apiUtilsWithHeader.get(url: url, firstTime: true);

    return response.fold((l) {
      return left(l);
    }, (r) {
      GetSystemSettingModel getSystemSettingModel =
          GetSystemSettingModel.fromJson(r.data);

      return right(getSystemSettingModel);
    });
  }

  FutureWithEither<GetFirmwareVersionModel> getFirmwareVersion() async {
    String url =
        AppConstants.baseUrlAsKey + EndPoints.firmwareVersionGetEndPoint;

    final response = await apiUtilsWithHeader.get(url: url, firstTime: true);

    return response.fold((l) {
      return left(l);
    }, (r) {
      GetFirmwareVersionModel getFirmwareVersionModel =
          GetFirmwareVersionModel.fromJson(r.data);

      return right(getFirmwareVersionModel);
    });
  }

  Future<void> setErrorLogs(ErrorLogsParam errorLogsParam) async {
    String url = AppConstants.errorBaseURL;

    if (errorLogsParam.appLogs.first.apiRequest.apiEndpoint ==
            'https://cognito-idp.us-east-2.amazonaws.com' &&
        errorLogsParam.appLogs.first.apiRequest.requestBody['AuthFlow'] ==
            'USER_PASSWORD_AUTH') {
      String maskedPassword = errorLogsParam
          .appLogs.first.apiRequest.requestBody['AuthParameters']['PASSWORD']
          .toString()
          .encodeToBase64;

      errorLogsParam.appLogs.first.apiRequest.requestBody['AuthParameters']
          ['PASSWORD'] = maskedPassword;
    } else if (errorLogsParam.appLogs.first.apiRequest.apiEndpoint
        .endsWith('api/login')) {
      String maskedPassword = errorLogsParam
          .appLogs.first.apiRequest.requestBody['password']
          .toString()
          .encodeToBase64;

      errorLogsParam.appLogs.first.apiRequest.requestBody['password'] =
          maskedPassword;
    } else if (errorLogsParam.appLogs.first.apiRequest.apiEndpoint
        .endsWith('api/global_data/system_setting/')) {
      String maskedPassword = errorLogsParam
          .appLogs.first.apiResponse.responseBody['admin_password']
          .toString()
          .encodeToBase64;

      errorLogsParam.appLogs.first.apiResponse.responseBody['admin_password'] =
          maskedPassword;
    }

    Map params = errorLogsParam.toJson();

    final response =
        await apiUtilsWithHeader.post(url: url, data: jsonEncode(params));

    response.fold((l) {
      // print('Error Failed');
    }, (r) {
      // print('Error success');
    });
  }
}
