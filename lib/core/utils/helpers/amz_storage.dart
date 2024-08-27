import 'package:get_storage/get_storage.dart';

import '../../../app/data/models/sign_up_apis/init_auth_model.dart';

AMZStorage amzStorage = AMZStorage();

class AMZStorage {
  static final AMZStorage _amzStorage = AMZStorage._i();
  final GetStorage _amzBox = GetStorage('AMZ');

  factory AMZStorage() {
    return _amzStorage;
  }

  AMZStorage._i();

  Future<bool> initAMZStorage() async {
    return await GetStorage.init('AMZ');
  }

  String getAMZUserEmail() {
    return _amzBox.read("AMZUserEmail") ?? '';
  }

  Future<void> saveAMZUserEmail(String email) {
    return _amzBox.write("AMZUserEmail", email);
  }

  String getAMZUserMobileNo() {
    return _amzBox.read("AMZUserMobileNo") ?? '';
  }

  Future<void> saveAMZUserMobileNo(String mobileNo) {
    return _amzBox.write("AMZUserMobileNo", mobileNo);
  }

  String getAMZUserPassword() {
    return _amzBox.read("AMZUserPassword") ?? '';
  }

  Future<void> saveAMZUserPassword(String password) {
    return _amzBox.write("AMZUserPassword", password);
  }

  bool getAMZLoggedIn() {
    return _amzBox.read("AMZLoggedIn") ?? false;
  }

  Future<void> saveAMZLoggedIn(bool value) {
    return _amzBox.write("AMZLoggedIn", value);
  }

  InitAuthModel getInitAuthModel() {
    return initAuthModelFromJson(_amzBox.read("InitAuthModel")!);
  }

  Future<void> saveInitAuthModel(InitAuthModel initAuthModel) {
    return _amzBox.write("InitAuthModel", initAuthModelToJson(initAuthModel));
  }

  bool getAMZFirstTimeUser() {
    return _amzBox.read("FirstTimeUser") ?? true;
  }

  Future<void> saveAMZFirstTimeUser(bool value) {
    return _amzBox.write("FirstTimeUser", value);
  }
}
