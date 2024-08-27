import 'package:get/get.dart';
import 'package:usama/app/data/models/room/get_room_list_model.dart';
import 'package:usama/core/utils/helpers/askey_storage.dart';
import 'package:usama/core/utils/services/api/repository/common_repository.dart';

import '../../../../core/extensions/imports.dart';
import '../../../data/models/room/set_room_model.dart';
import '../../../data/params/rooms/get_room_list_param.dart';
import '../../../data/params/rooms/set_room_param.dart';
import '../../dashboard/controllers/dashboard_controller.dart';

class SecureRoomController extends GetxController {
  GetRoomListModel getRoomListModel = GetRoomListModel();
  // List<RxBool> listOfRoomStatus = <RxBool>[].obs;
  DashboardController dashboardController = Get.find<DashboardController>();

  RxBool showLoader = false.obs;
  RxBool isNetworkError = false.obs;
  RxBool isServerError = false.obs;

  RxBool isAllRooms = true.obs;
  RxBool isRoomsLimitReached = true.obs;
  Rx<String> pageTitle = 'My Rio SecureRooms™'.obs;
  String ssid = '';
  String ssidName = '';

  @override
  void onInit() {
    Map<String, dynamic> arg = Get.arguments;

    isAllRooms.value = arg['isAllRooms'];

    if (isAllRooms.value) {
      getRoomListModel = asKeyStorage.getAsKeyRoomListModel();
      // getRoomList(fillGetAllRooms());
      callGetAllRooms();
    } else {
      ssid = arg['SSID'];
      ssidName = arg['SSID_Name'];
      pageTitle.value = '$ssidName\'s Rooms';
      // getRoomList(fillGetAllRoomsOfSSID(ssid));
      callGetRoomsOfSSID(ssid);
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
    //
    super.onClose();
  }

  callGetAllRooms() async {
    showLoader.value = true;

    await CommonRepo()
        .getRoomList(CommonRepo().fillGetAllRooms())
        .then((value) async {
      if (value != null) {
        getRoomListModel = value;
        dashboardController.getRoomListModel = value;
        dashboardController.addAllRoomInLists();

        if (getRoomListModel.listOfRoom!.length < 16) {
          isRoomsLimitReached.value = false;
        } else {
          isRoomsLimitReached.value = true;
        }
      }
      showLoader.value = false;
    });
  }

  callGetRoomsOfSSID(String ssid) async {
    showLoader.value = true;
    await CommonRepo()
        .getRoomList(CommonRepo().fillGetAllRoomsOfSSID(ssid))
        .then((value) async {
      if (value != null) {
        getRoomListModel = value;
      }
      showLoader.value = false;
    });
  }

  GetRoomListParam fillGetAllRooms() {
    return GetRoomListParam(type: 'none', id: '0');
  }

  GetRoomListParam fillGetAllRoomsOfSSID(String ssid) {
    return GetRoomListParam(type: 'ssid', id: ssid);
  }

  GetRoomListParam fillGetAccessRoomsOfRoom(int roomId) {
    return GetRoomListParam(type: 'room', id: '$roomId');
  }

  GetRoomListParam fillGetAllowedRoomsOfDevice(int deviceId) {
    return GetRoomListParam(type: 'device', id: '$deviceId');
  }

  Future<GetRoomListModel?> getRoomList(
      GetRoomListParam getRoomListParam) async {
    showLoader.value = true;
    isNetworkError.value = false;
    isServerError.value = false;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);
      showLoader.value = false;
      isServerError.value = false;
      isNetworkError.value = true;

      return null;
    }

    Map params = getRoomListParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.roomListGetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);
    return response.fold((l) {
      showLoader.value = false;

      return null;
    }, (r) {
      getRoomListModel = GetRoomListModel.fromJson(r.data);

      // for (var i = 0; i < getRoomListModel.listOfRoom!.length; i++) {
      //   listOfRoomStatus.add(false.obs);
      // }

      if (isAllRooms.value) {
        if (getRoomListModel.listOfRoom!.length < 16) {
          isRoomsLimitReached.value = false;
        } else {
          isRoomsLimitReached.value = true;
        }
      }

      showLoader.value = false;

      return getRoomListModel;
    });
  }

  SetRoomParam fillSetRoomDelete(RoomListItem roomListItem) {
    return SetRoomParam(
        action: 'delete',
        id: roomListItem.id!,
        nameEncode: roomListItem.nameEncode!,
        password: roomListItem.password!,
        ssidId: '',
        parentalControl: '',
        vpnId: '',
        roomStatus: '');
  }

  Future<SetRoomModel?> setRoom(SetRoomParam setRoomParam) async {
    showLoader.value = true;
    isNetworkError.value = false;
    isServerError.value = false;

    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      constants.showSnackbar('Network Error', 'No internet access', 0);
      showLoader.value = false;
      isServerError.value = false;
      isNetworkError.value = true;

      return null;
    }

    Map params = setRoomParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.roomSetEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);

    return response.fold((l) {
      showLoader.value = false;

      return null;
    }, (r) {
      var setRoomModel = SetRoomModel.fromJson(r.data);

      constants.showSnackbar('Room Status', 'Deleted successfully', 1);

      showLoader.value = false;

      return setRoomModel;
    });
  }
}
