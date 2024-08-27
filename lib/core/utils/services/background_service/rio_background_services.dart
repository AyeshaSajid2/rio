import 'package:usama/core/extensions/imports.dart';
import 'package:usama/core/utils/helpers/askey_storage.dart';
import 'package:usama/core/utils/services/api/repository/auth_repository.dart';
import 'package:usama/core/utils/services/fcm/fcm_services.dart';

import '../../../../app/data/models/admin_login/admin_login_model.dart';
import '../../../../app/data/models/device/get_device_list_model.dart';
import '../../../../app/data/params/admin_login/admin_login_param.dart';
import '../../../../app/data/params/device/get_device_list_param.dart';

class RioBackgroundServices {
  static bool notificationShown = false;
  static Future<AdminLoginModel?> putAdminLogin(
      AdminLoginParam adminLoginParam) async {
    Map params = adminLoginParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.adminLoginEndPoint;

    final response = await apiUtils.put(
        url: url, data: jsonEncode(params), isBackGroundService: true);

    response.fold((l) => null, (r) async {
      var adminLoginModel = AdminLoginModel.fromJson(r.data);

      ApiUtilsWithHeader.token = adminLoginModel.token!;

      asKeyStorage.saveAsKeyToken(adminLoginModel.token!);

      await AuthRepo().updateAttributes(AuthRepo()
          .fillUpdateDeviceTokenInAWS(asKeyStorage.getAsKeyDeviceToken()));

      return adminLoginModel;
    });
    return null;
  }

  static GetDeviceListParam fillGetWaitingDevices() {
    return GetDeviceListParam(id: '0', type: 'wait');
  }

  static FutureWithEither<GetDeviceListModel?> getDeviceList(
      GetDeviceListParam getDeviceListParam) async {
    Map params = getDeviceListParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.deviceListGetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url,
        data: jsonEncode(params),
        isBackGroundService: true,
        firstTime: true);

    return response.fold((l) {
      return left(l);
    }, (r) {
      var getWaitingDeviceListModel = GetDeviceListModel.fromJson(r.data);

      if (getWaitingDeviceListModel.listOfDevices != null &&
          getWaitingDeviceListModel.listOfDevices!.isNotEmpty &&
          getWaitingDeviceListModel.listOfDevices!.first.status!
                  .toLowerCase() ==
              'online') {
        FcmServices.showNotifications(
          'Rio Router: Action Needed',
          '${getWaitingDeviceListModel.listOfDevices!.length} ${getWaitingDeviceListModel.listOfDevices!.length == 1 ? 'device is' : 'devices are'} waiting for your approval',
          '${getWaitingDeviceListModel.listOfDevices!.length}',
        );

        notificationShown = true;
      }

      return right(getWaitingDeviceListModel);
    });
  }
}
