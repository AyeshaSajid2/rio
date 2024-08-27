import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../../../core/extensions/imports.dart';

class BackUpController extends GetxController {
  RxBool showLoader = false.obs;
  @override
  void onInit() {
    //
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

  FutureWithEither<void> downloadFile() async {
    showLoader.value = true;

    String url = AppConstants.baseUrlAsKey + EndPoints.backupConfigEndPoint;

    final response = await apiUtilsWithHeader.getForDownloading(
      url: url,
      options: Options(responseType: ResponseType.bytes),
      onReceiveProgress: (received, total) {
        if (total != -1) {
          print('Downloaded ${((received / total) * 100).toStringAsFixed(2)}%');
        }
      },
    );

    return response.fold((l) {
      showLoader.value = false;
      return left(l);
    }, (r) async {
      // Get the app's documents directory
      Directory appDocDir = await getApplicationDocumentsDirectory();
      String savePath = '${appDocDir.path}/${DateTime.now().toUtc()}.cfg';

      File file = File(savePath);
      await file.writeAsBytes(r.data, flush: true);

      print('File downloaded to: $savePath');

      showLoader.value = false;

      return right(null);
    });
  }

  // AdminPasswordParam fillAdminPassword() {
  //   return AdminPasswordParam(password: adminNewPasswordTEC.text);
  // }

  // Future<StatusModel?> uploadFile(AdminPasswordParam adminPasswordParam) async {
  //   showLoader.value = true;

  //   Map params = adminPasswordParam.toJson();

  //   String url = AppConstants.baseUrlAsKey + EndPoints.loadConfigEndPoint;

  //   final response =
  //       await apiUtilsWithHeader.put(url: url, data: jsonEncode(params));

  //   return response.fold((l) {
  //     showLoader.value = false;
  //     return null;
  //   }, (r) {
  //     StatusModel status = StatusModel.fromJson(r.data);

  //     // bool rememberMe = asKeyStorage.getAsKeyAdminRememberMe();

  //     // if (rememberMe) {
  //     asKeyStorage.saveAsKeyAdminPassword(adminPasswordParam.password);
  //     // }

  //     showLoader.value = false;

  //     if (isFirstTimeChange) {
  //       Get.back();
  //     } else {
  //       Get.offAllNamed(Routes.ADMIN_LOGIN, arguments: false);
  //     }

  //     constants.showSnackbar(
  //         'Admin Password', 'Successfully changed admin password', 1);

  //     return status;
  //   });
  // }
}
