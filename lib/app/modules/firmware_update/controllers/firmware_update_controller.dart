// ignore_for_file: library_prefixes, implementation_imports

import 'package:dio/src/form_data.dart' as dioFormData;
import 'package:dio/src/multipart_file.dart' as dioMultiPart;
import 'package:get/get.dart';

import '../../../../core/extensions/imports.dart';
import '../../../data/models/settings/get_firmware_version.dart';
import '../../../data/models/status_model.dart';
import '../../settings/controllers/settings_controller.dart';

class FirmwareUpdateController extends GetxController {
  SettingsController settingsController = Get.find<SettingsController>();

  GetFirmwareVersionModel getFirmwareVersionModel = GetFirmwareVersionModel();

  RxBool isUpdateAvailable = false.obs;
  RxBool showLoader = false.obs;

  @override
  void onInit() {
    getFirmwareVersion();
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

  FutureWithEither<GetFirmwareVersionModel> getFirmwareVersion() async {
    showLoader.value = true;

    String url =
        AppConstants.baseUrlAsKey + EndPoints.firmwareVersionGetEndPoint;

    final response = await apiUtilsWithHeader.get(url: url, firstTime: true);

    return response.fold((l) {
      showLoader.value = false;
      return left(l);
    }, (r) {
      getFirmwareVersionModel = GetFirmwareVersionModel.fromJson(r.data);

      if (getFirmwareVersionModel.firmwareVersion ==
          settingsController.getSystemSettingModel.firmwareVersion) {
        isUpdateAvailable.value = false;
      } else {
        isUpdateAvailable.value = true;
      }

      showLoader.value = false;

      return right(getFirmwareVersionModel);
    });
  }

  Future<StatusModel?> upgradeFirmware() async {
    showLoader.value = true;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);
      showLoader.value = false;

      return null;
    }

    // Map params = setDeviceBlockParam.toJson();

    // Create FormData object for multipart/form-data
    dioFormData.FormData formData = dioFormData.FormData.fromMap({
      'field1': 'value1', // Other form fields
      'field2': 'value2',
      'file': await dioMultiPart.MultipartFile.fromFile('path/to/your/file.jpg',
          filename: 'file.jpg'),
    });

    String url = AppConstants.baseUrlAsKey + EndPoints.firmwareUpgradeEndPoint;

    final response = await apiUtilsWithHeader.postWithProgress(
      url: url,
      data: formData,
      firstTime: true,
      onSendProgress: (int sent, int total) {
        print('Uploading: ${((sent / total) * 100).toStringAsFixed(2)}%');
      },
      onReceiveProgress: (int received, int total) {
        if (total != -1) {
          print(
              'Downloading: ${((received / total) * 100).toStringAsFixed(2)}%');
        }
      },
    );

    return response.fold((l) {
      showLoader.value = false;
      return null;
    }, (r) async {
      var statusModel = StatusModel.fromJson(r.data);

      showLoader.value = false;

      return statusModel;
    });
  }
}
