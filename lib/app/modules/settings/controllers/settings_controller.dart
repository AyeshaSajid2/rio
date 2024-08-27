import 'package:get/get.dart';
import 'package:usama/app/data/params/settings/set_time_zone_param.dart';
import 'package:usama/app/routes/app_pages.dart';
import 'package:usama/core/utils/helpers/amz_storage.dart';
import 'package:usama/core/utils/helpers/askey_storage.dart';
import 'package:usama/core/utils/services/api/repository/common_repository.dart';

import '../../../../core/extensions/imports.dart';
import '../../../data/models/settings/get_system_setting_model.dart';
import '../../../data/models/settings/get_wan_access_model.dart';
import '../../../data/models/status_model.dart';
import '../../../data/params/settings/set_wan_access_param.dart';
import '../../dashboard/controllers/dashboard_controller.dart';

class SettingsController extends GetxController {
  RxBool showLoader = false.obs;

  DashboardController dashboardController = Get.find<DashboardController>();

  RxString selectedTimeZoneName = 'Atlantic Standard Time (AST)'.obs;
  int selectedTimeZoneIndex = 0;
  RxBool isDayLightSavingOn = true.obs;

  GetSystemSettingModel getSystemSettingModel = GetSystemSettingModel();
  GetWanAccessModel getWanAccessModel = GetWanAccessModel();
  RxBool isWanAccessOn = false.obs;

  List<String> listOfTimeZoneName = [
    'Automatic Time Zone',
    'Atlantic Standard Time (AST)',
    'Eastern Time (ET)',
    'Central Time (CT)',
    'Mountain Time (MT)',
    'Mountain Standard Time (MST)',
    'Pacific Time (PT)',
    'Alaska Time',
    'Hawaii-Aleutian Standard Time (HAST)',
    'Samoa Standard Time (SST)',
    'Chamorro Standard Time (ChST)',
  ];
  List<String> listOfTimeZones = [
    'UTC',
    'AST4',
    'EST5EDT,M3.2.0,M11.1.0',
    'CST6CDT,M3.2.0,M11.1.0',
    'MST7MDT,M3.2.0,M11.1.0',
    'MST7',
    'PST8PDT,M3.2.0,M11.1.0',
    'AKST9AKDT,M3.2.0,M11.1.0',
    'HST10',
    'SST11',
    'ChST-10',
  ];
  List<String> listOfTimeLocations = [
    "Auto",
    "America/Puerto Rico",
    "America/New York",
    "America/Chicago",
    "America/Denver",
    "America/Phoenix",
    "America/Los Angeles",
    "America/Anchorage",
    "Pacific/Honolulu",
    "Pacific/Pago Pago",
    "Pacific/Guam",
  ];
  //Progress
  // RxDouble percentageIndicator = 0.0.obs;
  //Reboot = true & Factory Reset = false when progress is called
  // bool isRebootActivated = false;

  @override
  void onInit() {
    getWanAccessModel =
        asKeyStorage.getAsKeyWanAccessModel() ?? GetWanAccessModel();
    getSystemSettings().then((value) => callGetWanAccess());

    super.onInit();
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    //

    super.onClose();
  }

  FutureWithEither<GetSystemSettingModel> getSystemSettings() async {
    showLoader.value = true;

    String url =
        AppConstants.baseUrlAsKey + EndPoints.systemSettingsGetEndPoint;

    final response = await apiUtilsWithHeader.get(url: url, firstTime: true);

    return response.fold((l) {
      showLoader.value = false;
      return left(l);
    }, (r) {
      getSystemSettingModel = GetSystemSettingModel.fromJson(r.data);

      dashboardController.routerStatus.value =
          getSystemSettingModel.internetStatus!;

      for (var i = 0; i < listOfTimeZones.length; i++) {
        if (listOfTimeZones[i] == getSystemSettingModel.timeZone) {
          selectedTimeZoneIndex = i;
          selectedTimeZoneName.value = listOfTimeZoneName[i];
        }
      }

      showLoader.value = false;

      return right(getSystemSettingModel);
    });
  }

  FutureWithEither<StatusModel> rebootRouter() async {
    showLoader.value = true;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);
      showLoader.value = false;

      return left(
          ErrorModel(errorCode: '100', errorMessage: 'No Internet Connection'));
    }

    String url = AppConstants.baseUrlAsKey + EndPoints.rebootEndPoint;

    final response = await apiUtilsWithHeader.get(url: url, firstTime: true);

    return response.fold((l) {
      showLoader.value = false;
      return left(l);
    }, (r) {
      StatusModel status = StatusModel.fromJson(r.data);

      showLoader.value = false;

      constants.showSnackbar('Reboot', 'Reboot started successfully', 1);

      Get.offAllNamed(Routes.PROGRESS,
          arguments: {'isReboot': true, 'Minutes': 3});

      return right(status);
    });
  }

  FutureWithEither<StatusModel> factoryReset() async {
    showLoader.value = true;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);
      showLoader.value = false;

      return left(
          ErrorModel(errorCode: '100', errorMessage: 'No Internet Connection'));
    }

    String url = AppConstants.baseUrlAsKey + EndPoints.factoryResetEndPoint;

    final response = await apiUtilsWithHeader.get(url: url, firstTime: true);

    return response.fold((l) {
      showLoader.value = false;
      return left(l);
    }, (r) {
      StatusModel status = StatusModel.fromJson(r.data);

      showLoader.value = false;

      constants.showSnackbar(
          'Factory Reset', 'Factory reset started successfully', 1);

      amzStorage.saveAMZLoggedIn(false);

      // amzStorage.saveAMZUserEmail('');
      // amzStorage.saveAMZUserPassword('');

      asKeyStorage.saveAsKeyLoggedIn(false);
      asKeyStorage.saveAsKeyResetStatus(false);
      asKeyStorage.saveAsKeyAdminPassword('');
      asKeyStorage.saveAsKeyAdminRememberMe(true);

      // isRebootActivated = false;
      // startTimer(8);
      // Get.to(() => const ProgressView());
      Get.offAllNamed(Routes.PROGRESS,
          arguments: {'isReboot': false, 'Minutes': 8});

      // Get.offAllNamed(Routes.SPLASH);

      return right(status);
    });
  }

  SetTimeZoneParam fillSetTimeZone() {
    return SetTimeZoneParam(
        timeZone: listOfTimeZones[selectedTimeZoneIndex],
        timeLocation: listOfTimeLocations[selectedTimeZoneIndex]);
  }

  Future<StatusModel?> setTimeZone(SetTimeZoneParam setTimeZoneParam) async {
    showLoader.value = true;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);
      showLoader.value = false;

      return null;
    }

    Map params = setTimeZoneParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.timezoneSetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);

    return response.fold((l) {
      showLoader.value = false;

      return null;
    }, (r) {
      StatusModel status = StatusModel.fromJson(r.data);

      showLoader.value = false;

      Get.back();

      constants.showSnackbar('Time Zone', 'Successfully changed time zone', 1);

      return status;
    });
  }

  Future<void> callGetWanAccess() async {
    showLoader.value = true;
    await CommonRepo().getWanAccess().then((value) {
      if (value != null) {
        getWanAccessModel = value;

        asKeyStorage.saveAsKeyWanAccessModel(getWanAccessModel);

        isWanAccessOn.value =
            getWanAccessModel.wanAccess == 'enable' ? true : false;

        showLoader.value = false;

        return right(getWanAccessModel);
      } else {
        showLoader.value = false;
      }
    });
  }

  Future<StatusModel?> setWanAccessStatus(
      SetWanAccessStatusParam setWanAccessStatusParam) async {
    showLoader.value = true;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);
      showLoader.value = false;

      return null;
    }

    Map params = setWanAccessStatusParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.wanAccessSetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);

    return response.fold((l) {
      showLoader.value = false;

      return null;
    }, (r) async {
      StatusModel status = StatusModel.fromJson(r.data);

      await callGetWanAccess();

      showLoader.value = false;

      constants.showSnackbar(
          'WAN Access', 'Successfully changed WAN access status', 1);

      return status;
    });
  }
}
