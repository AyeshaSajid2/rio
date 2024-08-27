import 'package:get/get.dart';

import '../../../../core/utils/helpers/askey_storage.dart';
import '../../../data/models/room/get_room_list_model.dart';
import '../../../data/models/wifi/get_wifi_list_model.dart';

class PasswordsController extends GetxController {
  List<List<RoomListItem>> allWifiRoomsList = [];

  GetWifiListModel getWifiListModel = asKeyStorage.getAsKeyWifiListModel();
  GetRoomListModel getRoomListModel = asKeyStorage.getAsKeyRoomListModel();

  @override
  void onInit() {
    setRoomList();
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

  setRoomList() {
    for (var i = 0; i < getWifiListModel.listOfWifi!.length; i++) {
      allWifiRoomsList.add([]);
    }
    for (var room in getRoomListModel.listOfRoom!) {
      if (room.ssidId != '') {
        allWifiRoomsList[int.parse(room.ssidId!)].add(room);
      }
    }
  }
}
