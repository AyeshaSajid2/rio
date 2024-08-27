import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/extensions/imports.dart';
import '../../../../core/utils/helpers/askey_storage.dart';
import '../../../data/models/room/get_room_list_model.dart';
import '../../../data/models/room/set_room_model.dart';
import '../../../data/models/vpn/get_vpn_2_model.dart';
import '../../../data/models/vpn/get_vpn_login_status_model.dart';
import '../../../data/models/wifi/get_wifi_list_model.dart';
import '../../../data/params/rooms/set_room_param.dart';
import '../../dashboard/controllers/dashboard_controller.dart';

class AddRoomController extends GetxController {
  final GlobalKey<FormState> settingsKey = GlobalKey<FormState>();

  GetWifiListModel getWifiListModel = GetWifiListModel();
  GetRoomListModel getRoomListModelForAllRooms =
      asKeyStorage.getAsKeyRoomListModel();

  //VPN
  GetVpn2Model getVpn2Model =
      GetVpn2Model(status: "fail", event: "none", time: "0", vpnList: []);
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

  RxBool showLoader = false.obs;

  DashboardController dashboardController = Get.find<DashboardController>();

  TextEditingController roomNameTEC = TextEditingController();
  TextEditingController roomPasswordTEC = TextEditingController();
  TextEditingController roomConfirmPasswordTEC = TextEditingController();

  RxBool showWiFiPassword = false.obs;
  RxBool showConfirmWiFiPassword = false.obs;

  RxBool enableParentControl = false.obs;
  RxBool enableRoomStatus = true.obs;

  Rx<WifiElement> selectedWifiSSID = WifiElement(name: 'Home').obs;

  RoomListItem roomListItem = RoomListItem();
  SetRoomModel setRoomModel = SetRoomModel();

  late Map arg;
  bool isFromSecureRooms = true;
  bool? isAllRooms;
  String wifiSSID = '';
  String wifiSSIDName = '';

  @override
  void onInit() {
    clearVPNList();
    arg = Get.arguments;
    //GetWifiListModel is stored in Router Setup Page
    getWifiListModel = asKeyStorage.getAsKeyWifiListModel();
    getWifiListModel.listOfWifi!.removeAt(0);

    wifiSSID = arg['ssid'];
    isFromSecureRooms = arg['isFromSecureRooms'];
    if (isFromSecureRooms) {
      isAllRooms = arg['isAllRooms'];
    }

    for (var wifi in getWifiListModel.listOfWifi!) {
      if (wifi.id == wifiSSID) {
        selectedWifiSSID.value = wifi;
      }
    }

    // getWifiList().then((value) => getVpnList());
    // getVpnList();
    getVPNLoginStatus().then(
      (value) => value.fold(
        (l) => null,
        // showSetVpnButton.value = true,
        (r) async {
          if (r.loginStatus == 'success') {
            // showSetVpnButton.value = false;
            await getVpnList();
          } else {
            // showSetVpnButton.value = true;
            clearVPNList();
            // getVpn2Model.vpnList!.add(VpnItem(
            //     id: '0',
            //     server: 'none',
            //     status: '',
            //     // status: 'disable',
            //     protocol: 'wireguard',
            //     // connection: 'disconnected')
            //     connection: ''));

            // selectedVPN.value = getVpn2Model.vpnList!.last;
          }
        },
      ),
    );

    super.onInit();
  }

  @override
  void onReady() {
    //
    super.onReady();
  }

  @override
  void onClose() {
    roomNameTEC.dispose();
    roomPasswordTEC.dispose();
    roomConfirmPasswordTEC.dispose();
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

  // FutureWithEither<GetWifiListModel> getWifiList() async {
  //   showLoader.value = true;

  //   final connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.none) {
  //     constants.showSnackbar('Network Error', 'No internet access', 0);
  //     showLoader.value = false;

  //     return left(
  //         ErrorModel(errorCode: '100', errorMessage: 'No Internet Connection'));
  //   }

  //   String url = AppConstants.baseUrlAsKey + EndPoints.wifiListGetEndPoint;

  //   try {
  //     final response = await apiUtilsWithHeader.get(url: url);

  //     if (response.statusCode == 200) {
  //       getWifiListModel = GetWifiListModel.fromJson(response.data);

  //       if (wifiSSID.isEmpty) {
  //         selectedWifiSSID.value = getWifiListModel.listOfWifi!.first;
  //       } else {
  //         for (var element in getWifiListModel.listOfWifi!) {
  //           if (element.id! == wifiSSID) {
  //             selectedWifiSSID.value = element;
  //             break;
  //           }
  //         }
  //       }

  //       showLoader.value = false;

  //       return right(getWifiListModel);
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

  SetRoomParam fillSetRoomAdd() {
    return SetRoomParam(
      action: 'create',
      id: '0',
      nameEncode: base64Encode(utf8.encode(roomNameTEC.text)),
      password: roomPasswordTEC.text,
      ssidId: selectedWifiSSID.value.id!,
      parentalControl: enableParentControl.value ? 'enable' : 'disable',
      vpnId: selectedVPN.value.id!,
      roomStatus: enableRoomStatus.value ? 'enable' : 'disable',
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

      // getVpn2Model = GetVpn2Model.fromJson(r.data);
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

      // vpnDetails.clear();

      // selectedVPN.value = getVpn2Model.vpnList!.last;
      // for (var vpnItem in getVpnModel.vpnList!) {
      //   for (var server in getVpnModel.serverList!) {
      //     if (server.name! == vpnItem.server!) {
      //       vpnDetails.add(server);
      //       break;
      //     }
      //   }
      // }

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

  //   String url = AppConstants.baseUrlAsKey + EndPoints.apiAccountEndPoint;

  //   final response = await apiUtilsWithHeader.get(url: url);

  //   return response.fold((l) {
  //     showLoader.value = false;
  //     return left(l);
  //   }, (r) {
  //     getApiAccountModel = GetApiAccountModel.fromJson(r.data);

  //     showSetVpnButton.value = false;

  //     // clearAll();

  //     showLoader.value = false;

  //     return right(getApiAccountModel);
  //   });
  // }
}
