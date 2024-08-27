import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:usama/app/data/models/room/set_room_model.dart';
import 'package:usama/app/data/models/status_model.dart';
import 'package:usama/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:usama/core/utils/helpers/askey_storage.dart';

import '../../../../core/extensions/imports.dart';
import '../../../data/models/room/get_room_list_model.dart';
import '../../../data/models/room/get_room_model.dart';
import '../../../data/models/url/get_allowed_url_list_model.dart';
import '../../../data/models/url/get_allowed_url_model.dart';
import '../../../data/models/url/set_allowed_url_model.dart';
import '../../../data/models/vpn/get_vpn_2_model.dart';
import '../../../data/models/vpn/get_vpn_login_status_model.dart';
import '../../../data/models/wifi/get_wifi_list_model.dart';
import '../../../data/params/rooms/get_room_list_param.dart';
import '../../../data/params/rooms/get_room_param.dart';
import '../../../data/params/rooms/set_room_param.dart';
import '../../../data/params/rooms/set_rooms_to_access_param.dart';
import '../../../data/params/url/get_allowed_url_list_param.dart';
import '../../../data/params/url/get_allowed_url_param.dart';
import '../../../data/params/url/set_allowed_url_param.dart';

class SecureRoomTabsController extends GetxController
    with GetTickerProviderStateMixin {
  late final TabController secureRoomTabController;

  final GlobalKey<FormState> settingsKey = GlobalKey<FormState>();
  final GlobalKey<FormState> urlCheckKey = GlobalKey<FormState>();

  GetRoomModel getRoomModel = GetRoomModel();
  GetWifiListModel getWifiListModel = GetWifiListModel();
  GetAllowedUrlListModel getAllowedUrlListModel = GetAllowedUrlListModel();
  GetAllowedUrlModel getAllowedUrlModel = GetAllowedUrlModel();
  SetAllowedUrlModel setAllowedUrlModel = SetAllowedUrlModel();

  //Access Control
  GetRoomListModel getRoomListModelForAllRooms = GetRoomListModel();
  GetRoomListModel getRoomListModelForRoomAccess =
      GetRoomListModel(listOfRoom: []);
  List<RxBool> listOfRoomStatus = <RxBool>[].obs;
  String accessList = '';

  //VPN
  GetVpn2Model getVpn2Model =
      GetVpn2Model(status: "fail", event: "none", time: "0", vpnList: []);
  // Rx<VpnItem> selectedVPN = VpnItem().obs;
  Rx<VpnItem> selectedVPN = VpnItem(
          id: '0',
          server: 'none',
          status: '',
          // status: 'disable',
          protocol: 'wireguard',
          // connection: 'disconnected')
          connection: '')
      .obs;
  List<VpnItem> vpnList = [];

  // GetApiAccountModel getApiAccountModel = GetApiAccountModel();
  GetVpnLoginStatusModel getVpnLoginStatusModel = GetVpnLoginStatusModel();
  // RxBool showSetVpnButton = false.obs;

  //Devices
  // GetDeviceListModel getDeviceListModel = GetDeviceListModel();
  // GetRoomListModel getRoomListModel = GetRoomListModel();

  // Rx<RoomListItem> selectedRoom = RoomListItem().obs;

  // List<RxBool> listOfDeviceStatus = <RxBool>[].obs;

  RxBool showLoader = false.obs;

  TextEditingController urlTEC = TextEditingController(
      // text: 'https://'
      );

  // SecureRoomController secureRoomController = Get.find<SecureRoomController>();
  DashboardController dashboardController = Get.find<DashboardController>();

  TextEditingController roomNameTEC = TextEditingController();
  TextEditingController roomPasswordTEC = TextEditingController();
  TextEditingController roomConfirmPasswordTEC = TextEditingController();

  RxDouble pageHeight = ((Get.height) - Get.statusBarHeight).obs;

  List<bool> didErrorOccurred = [false, false, false];

  RxBool showWiFiPassword = false.obs;
  RxBool showConfirmWiFiPassword = false.obs;

  RxBool enableParentControl = false.obs;
  RxBool enableRoomStatus = true.obs;

  Rx<String> pageTitle = 'Add Room'.obs;
  // Rx<WifiElement> selectedWifiSSID = WifiElement(name: 'Home').obs;

  RxString selectedTimeAllowedTitle = 'Always Allowed'.obs;

  List<RxString> listOfSelectedTimes = [];

  // RxString selectedTime = '00:00-00:00'.obs;
  String fromTimeValue = '00:00';
  String toTimeValue = '00:00';

  Duration initialTimerDuration = const Duration();
  Duration fromTimerDuration = const Duration();
  Duration toTimerDuration = const Duration();

  List<String> tabsList = [
    'Settings',
    'Parental Control',
    // 'VPN',
    'Access Control',
  ];

  List<String> listOfAllowedTimes = [
    'Always Allowed',
    'Allowed from HH:MM to HH:MM',
    // 'Allowed from HH:MM',
    'Always Blocked',
  ];

  RoomListItem roomListItem = RoomListItem();
  SetRoomModel setRoomModel = SetRoomModel();

  bool isFromSecureRoom = true;
  bool? isAllRooms;

  late Map arg;

  @override
  void onInit() {
    clearVPNList();
    arg = Get.arguments;

    isFromSecureRoom = arg['isFromSecureRooms'];
    if (isFromSecureRoom) {
      isAllRooms = arg['isAllRooms'];
    }
    //GetWifiListModel is stored in Router Setup Page
    getWifiListModel = asKeyStorage.getAsKeyWifiListModel();

    roomListItem = arg['RoomListItem'];

    pageTitle.value = roomListItem.name!;
    roomNameTEC.text = roomListItem.name!;
    roomPasswordTEC.text = roomListItem.password!;
    roomConfirmPasswordTEC.text = roomListItem.password!;

    // getWifiList()
    // .then((value) =>
    getRoom(GetRoomParam(id: roomListItem.id!))
        // )
        .then(
            (value) => getUrlList(GetAllowedUrlListParam(id: roomListItem.id!)))
        .then((value) => getRoomList(fillGetAllRooms()))
        .then(
          (value) => getVPNLoginStatus().then(
            (value) => value.fold(
              (l) => null,
              // showSetVpnButton.value = true,
              (r) async {
                if (r.loginStatus == 'success') {
                  // showSetVpnButton.value = false;
                  await getVpnList();
                } else {
                  // showSetVpnButton.value = true;
                  // getVpn2Model.vpnList!.add(VpnItem(
                  //     id: '0',
                  //     server: 'none',
                  //     status: '',
                  //     // status: 'disable',
                  //     protocol: 'wireguard',
                  //     // connection: 'disconnected')
                  //     connection: ''));

                  // selectedVPN.value = getVpn2Model.vpnList!.last;
                  clearVPNList();
                }
              },
            ),
          ),
        );
    // .then((value) => getVpnList());

    secureRoomTabController = TabController(length: 3, vsync: this);

    super.onInit();
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    secureRoomTabController.dispose();
    super.onClose();
  }

  clearVPNList() {
    vpnList.clear();
    vpnList.add(VpnItem(
        id: '0',
        server: 'none',
        status: '',
        // status: 'disable',
        protocol: 'wireguard',
        // connection: 'disconnected')
        connection: ''));
    selectedVPN.value = vpnList.first;
  }

  bool checkRoomNameAlreadyExist(String newRoomName) {
    bool result = false;
    for (var room in getRoomListModelForAllRooms.listOfRoom!) {
      if (room.nameEncode!.decodeBase64 == newRoomName) {
        result = true;
        break;
      } else {
        result = false;
      }
    }
    return result;
  }

  bool checkRoomPasswordAlreadyExist(String newRoomPassword) {
    bool result = false;
    for (var room in getRoomListModelForAllRooms.listOfRoom!) {
      if (room.password! == newRoomPassword) {
        result = true;
        break;
      } else {
        result = false;
      }
    }
    return result;
  }

  Future<GetRoomModel?> getRoom(GetRoomParam getRoomParam) async {
    showLoader.value = true;

    Map params = getRoomParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.roomGetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);

    return response.fold((l) {
      showLoader.value = false;

      return null;
    }, (r) {
      getRoomModel = GetRoomModel.fromJson(r.data);

      pageTitle.value = getRoomModel.name!;

      roomNameTEC.text = getRoomModel.name!;
      roomPasswordTEC.text = getRoomModel.password!;
      roomConfirmPasswordTEC.text = getRoomModel.password!;

      enableParentControl.value =
          getRoomModel.parentalControl == 'disable' ? false : true;
      enableRoomStatus.value =
          getRoomModel.roomStatus == 'disable' ? false : true;

      accessList = '${getRoomModel.accessList!.trimRight()} ';

      showLoader.value = false;

      return getRoomModel;
    });
  }

  SetRoomParam fillSetRoomModify() {
    return SetRoomParam(
      action: 'modify',
      id: getRoomModel.id!,
      nameEncode: roomNameTEC.text.encodeToBase64,
      password: roomPasswordTEC.text,
      ssidId: getRoomModel.ssidId!,
      parentalControl: enableParentControl.value ? 'enable' : 'disable',
      vpnId: selectedVPN.value.id!,
      roomStatus: enableRoomStatus.value ? 'enable' : 'disable',
    );
  }

  SetRoomParam fillSetRoomOnlyModifyParentalControl() {
    return SetRoomParam(
      action: 'modify',
      id: getRoomModel.id!,
      nameEncode: getRoomModel.nameEncode!,
      password: getRoomModel.password!,
      ssidId: getRoomModel.ssidId!,
      parentalControl: enableParentControl.value ? 'enable' : 'disable',
      vpnId: getRoomModel.vpnId!,
      roomStatus: getRoomModel.roomStatus!,
    );
  }

  Future<SetRoomModel?> setRoom(SetRoomParam setRoomParam) async {
    showLoader.value = true;

    Map params = setRoomParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.roomSetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);
    return response.fold((l) {
      showLoader.value = false;

      return null;
    }, (r) {
      setRoomModel = SetRoomModel.fromJson(r.data);

      roomNameTEC.clear();
      roomPasswordTEC.clear();
      roomConfirmPasswordTEC.clear();

      showLoader.value = false;

      return setRoomModel;
    });
  }

  Future<GetAllowedUrlListModel?> getUrlList(
      GetAllowedUrlListParam getAllowedUrlListParam) async {
    showLoader.value = true;

    Map params = getAllowedUrlListParam.toJson();

    String url =
        AppConstants.baseUrlAsKey + EndPoints.allowedUrlListGetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);

    return response.fold((l) {
      showLoader.value = false;

      return null;
    }, (r) {
      getAllowedUrlListModel = GetAllowedUrlListModel.fromJson(r.data);

      listOfSelectedTimes.clear();

      for (var url in getAllowedUrlListModel.listOfAllowedUrls!) {
        listOfSelectedTimes.add(url.accessTime!.obs);
      }

      showLoader.value = false;

      return getAllowedUrlListModel;
    });
  }

  SetAllowedUrlParam fillSetUrlAdd(int urlIndex) {
    return SetAllowedUrlParam(
        action: 'create',
        id: '0',
        url: urlTEC.text,
        accessTime: listOfSelectedTimes[urlIndex].value,
        roomId: roomListItem.id!);
  }

  SetAllowedUrlParam fillSetUrlModify(AllowedUrlItem urlItem, int urlIndex) {
    return SetAllowedUrlParam(
        action: 'modify',
        id: urlItem.id!,
        url: urlItem.url!,
        accessTime: listOfSelectedTimes[urlIndex].value,
        roomId: roomListItem.id!);
  }

  SetAllowedUrlParam fillSetUrlDelete(AllowedUrlItem urlItem, int urlIndex) {
    return SetAllowedUrlParam(
        action: 'delete',
        id: urlItem.id!,
        url: urlItem.url!,
        accessTime: listOfSelectedTimes[urlIndex].value,
        roomId: roomListItem.id!);
  }

  Future<SetAllowedUrlModel?> setUrl(
      SetAllowedUrlParam setAllowedUrlParam) async {
    showLoader.value = true;

    Map params = setAllowedUrlParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.allowedUrlSetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);

    return response.fold((l) {
      showLoader.value = false;

      return null;
    }, (r) {
      setAllowedUrlModel = SetAllowedUrlModel.fromJson(r.data);

      urlTEC.clear();
      // urlTEC.text = 'https://';

      showLoader.value = false;

      return setAllowedUrlModel;
    });
  }

  Future<GetAllowedUrlModel?> getUrl(
      GetAllowedUrlParam getAllowedUrlParam) async {
    showLoader.value = true;

    Map params = getAllowedUrlParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.allowedUrlGetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);

    return response.fold((l) {
      showLoader.value = false;

      return null;
    }, (r) {
      getAllowedUrlModel = GetAllowedUrlModel.fromJson(r.data);

      showLoader.value = false;

      return getAllowedUrlModel;
    });
  }

  GetRoomListParam fillGetAllRooms() {
    return GetRoomListParam(type: 'none', id: '0');
  }

  GetRoomListParam fillGetAllRoomsOfSSID(String ssid) {
    return GetRoomListParam(type: 'ssid', id: ssid);
  }

  GetRoomListParam fillGetAccessRoomsOfRoom(String roomId) {
    return GetRoomListParam(type: 'room', id: roomId);
  }

  GetRoomListParam fillGetAllowedRoomsOfDevice(int deviceId) {
    return GetRoomListParam(type: 'device', id: '$deviceId');
  }

  Future<GetRoomListModel?> getRoomList(
      GetRoomListParam getRoomListParam) async {
    showLoader.value = true;

    Map params = getRoomListParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.roomListGetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);
    return response.fold((l) {
      showLoader.value = false;

      return null;
    }, (r) {
      getRoomListModelForAllRooms = GetRoomListModel.fromJson(r.data);

      getRoomListModelForAllRooms.listOfRoom!
          .removeWhere((element) => element.id == getRoomModel.id);

      for (var room in getRoomListModelForAllRooms.listOfRoom!) {
        if (getRoomModel.accessList!.split(' ').contains(room.id!)) {
          listOfRoomStatus.add(true.obs);
          getRoomListModelForRoomAccess.listOfRoom!.add(room);
        } else {
          listOfRoomStatus.add(false.obs);
        }
      }

      showLoader.value = false;
      return getRoomListModelForAllRooms;
    });
  }

  SetRoomsToRoomAccessParam fillSetRoomsToRoomAccess() {
    return SetRoomsToRoomAccessParam(
        id: getRoomModel.id!, accessList: accessList);
  }

  Future<StatusModel?> setRoomsToAccessRoom(
      SetRoomsToRoomAccessParam setRoomParam) async {
    showLoader.value = true;

    Map params = setRoomParam.toJson();

    String url =
        AppConstants.baseUrlAsKey + EndPoints.roomToRoomAccessSetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);
    return response.fold((l) {
      showLoader.value = false;

      return null;
    }, (r) {
      var statusModel = StatusModel.fromJson(r.data);

      constants.showSnackbar('Status', statusModel.status!, 1);

      showLoader.value = false;

      return statusModel;
    });
  }

  FutureWithEither<GetVpn2Model> getVpnList() async {
    showLoader.value = true;

    String url = AppConstants.baseUrlAsKey + EndPoints.vpn2GetEndPoint;

    final response = await apiUtilsWithHeader.get(url: url, firstTime: true);

    return response.fold((l) {
      showLoader.value = false;
      return left(l);
    }, (r) {
      clearVPNList();
      getVpn2Model = GetVpn2Model.fromJson(r.data);
      vpnList.addAll(getVpn2Model.vpnList!);
      // vpnList.add(
      //   VpnItem(
      //       id: '0',
      //       server: '',
      //       status: '',
      //       protocol: '',
      //       connection: '',
      //       country: '',
      //       city: ''),
      // );
      // getVpn2Model.vpnList!.add(
      //   VpnItem(
      //       id: '0',
      //       server: 'none',
      //       status: '',
      //       // status: 'disable',
      //       protocol: 'wireguard',
      //       connection: ''),
      //   // connection: 'disconnected'),
      // );

      // for (var vpnItem in getVpn2Model.vpnList!) {
      //   if (vpnItem.id! == getRoomModel.vpnId) {
      //     selectedVPN.value = vpnItem;
      //   }
      // }
      for (var vpnItem in vpnList) {
        if (vpnItem.id! == getRoomModel.vpnId) {
          selectedVPN.value = vpnItem;
        }
      }

      showLoader.value = false;

      return right(getVpn2Model);
    });
  }

  FutureWithEither<GetVpnLoginStatusModel> getVPNLoginStatus() async {
    showLoader.value = true;

    String url =
        AppConstants.baseUrlAsKey + EndPoints.vpnLoginStatusGetEndPoint;

    final response = await apiUtilsWithHeader.get(url: url, firstTime: true);

    return response.fold((l) {
      showLoader.value = false;
      return left(l);
    }, (r) {
      getVpnLoginStatusModel = GetVpnLoginStatusModel.fromJson(r.data);

      showLoader.value = false;

      return right(getVpnLoginStatusModel);
    });
  }

  // FutureWithEither<GetApiAccountModel> getApiAccount() async {
  //   showLoader.value = true;
  //   isNetworkError.value = false;
  //   isServerError.value = false;

  //   final connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.none) {
  //     constants.showSnackbar('Network Error', 'No internet access', 0);
  //     showLoader.value = false;
  //     isServerError.value = false;
  //     isNetworkError.value = true;

  //     return left(
  //         ErrorModel(errorCode: '100', errorMessage: 'No Internet Connection'));
  //   }

  //   String url = AppConstants.baseUrlAsKey + EndPoints.apiAccountEndPoint;

  //   try {
  //     final response = await apiUtilsWithHeader.get(url: url);

  //     if (response.statusCode == 200) {
  //       getApiAccountModel = GetApiAccountModel.fromJson(response.data);

  //       showSetVpnButton.value = false;

  //       // clearAll();

  //       showLoader.value = false;

  //       return right(getApiAccountModel);
  //     } else {
  //       showLoader.value = false;

  //       Dialogs.showErrorDialog(
  //         titleText: 'Something went wrong. Please Try Again',
  //       );
  //       return left(ErrorModel(
  //           errorCode: '100', errorMessage: 'No Internet Connection'));
  //     }
  //   } on SocketException {
  //     showLoader.value = false;
  //     isServerError.value = false;
  //     isNetworkError.value = true;
  //     return left(
  //         ErrorModel(errorCode: '100', errorMessage: 'No Internet Connection'));
  //   } on TimeoutException {
  //     showLoader.value = false;
  //     isServerError.value = false;
  //     isNetworkError.value = true;
  //     return left(
  //         ErrorModel(errorCode: '100', errorMessage: 'No Internet Connection'));
  //   } catch (e) {
  //     showLoader.value = false;
  //     isNetworkError.value = false;
  //     isServerError.value = true;

  //     print(e);
  //     if (e.runtimeType == DioException) {
  //       DioException exception = e as DioException;
  //       if (exception.response != null) {
  //         final error = ErrorModel.fromJson(exception.response!.data);

  //         Dialogs.showErrorDialog(
  //           titleText: error.errorMessage!,
  //         );
  //       } else {
  //         Dialogs.showErrorDialog(
  //           titleText: 'Something went wrong. Please Try Again',
  //         );
  //       }
  //     }
  //     return left(
  //         ErrorModel(errorCode: '100', errorMessage: 'No Internet Connection'));
  //   }
  // }
}
