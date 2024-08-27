import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usama/core/utils/helpers/askey_storage.dart';

import '../../../../core/extensions/imports.dart';
import '../../../data/models/admin_login/get_admin_password_model.dart';
import '../../../data/models/status_model.dart';
import '../../../data/params/admin_login/admin_password_param.dart';
import '../../../routes/app_pages.dart';

class ChangeAdminPasswordController extends GetxController {
  final GlobalKey<FormState> changeAdminPasswordKey = GlobalKey<FormState>();

  RxBool showLoader = false.obs;

  RxBool showWiFiPassword = false.obs;
  RxBool showAdminPassword = false.obs;
  RxBool showConfirmAdminPassword = false.obs;

  TextEditingController oldPasswordTEC = TextEditingController();
  TextEditingController adminNewPasswordTEC = TextEditingController();
  TextEditingController adminConfirmPasswordTEC = TextEditingController();

  GetAdminPasswordModel getAdminPasswordModel = GetAdminPasswordModel();

  // final box = GetStorage('AsKey');

  String oldPassword = '';

  bool isFirstTimeChange = false;

  @override
  void onInit() {
    isFirstTimeChange = Get.arguments;
    bool rememberMe = asKeyStorage.getAsKeyAdminRememberMe();

    if (rememberMe) {
      oldPassword = asKeyStorage.getAsKeyAdminPassword();
      oldPasswordTEC.text = oldPassword;
    }
    super.onInit();
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    oldPasswordTEC.dispose();
    adminNewPasswordTEC.dispose();
    adminConfirmPasswordTEC.dispose();
    super.onClose();
  }

  FutureWithEither<GetAdminPasswordModel> getAdminPassword() async {
    showLoader.value = true;

    String url = AppConstants.baseUrlAsKey + EndPoints.adminPasswordGetEndPoint;

    final response = await apiUtilsWithHeader.get(url: url, firstTime: true);

    return response.fold((l) {
      showLoader.value = false;
      return left(l);
    }, (r) {
      getAdminPasswordModel = GetAdminPasswordModel.fromJson(r.data);

      showLoader.value = false;

      return right(getAdminPasswordModel);
    });
  }

  AdminPasswordParam fillAdminPassword() {
    return AdminPasswordParam(password: adminNewPasswordTEC.text);
  }

  Future<StatusModel?> changeAdminPassword(
      AdminPasswordParam adminPasswordParam) async {
    showLoader.value = true;

    Map params = adminPasswordParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.adminPasswordSetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);

    return response.fold((l) {
      showLoader.value = false;
      return null;
    }, (r) {
      StatusModel status = StatusModel.fromJson(r.data);

      // bool rememberMe = asKeyStorage.getAsKeyAdminRememberMe();

      // if (rememberMe) {
      asKeyStorage.saveAsKeyAdminPassword(adminPasswordParam.password);
      // }

      showLoader.value = false;

      if (isFirstTimeChange) {
        Get.back();
      } else {
        Get.offAllNamed(Routes.ADMIN_LOGIN, arguments: false);
      }

      constants.showSnackbar(
          'Admin Password', 'Successfully changed admin password', 1);

      return status;
    });
  }
}
