import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../core/extensions/imports.dart';
import '../../../data/models/mesh/get_mesh_mode_model.dart';
import '../../../data/models/mesh/get_mesh_topology_model.dart';
import '../../../data/models/status_model.dart';
import '../../../data/params/mesh/set_mesh_mode_param.dart';

class MeshController extends GetxController {
  RxBool showLoader = false.obs;

  final box = GetStorage('AsKey');

  GetMeshTopologyModel getMeshTopologyModel = GetMeshTopologyModel();
  GetMeshModeModel getMeshModeModel = GetMeshModeModel();

  @override
  void onInit() {
    //
    getMeshTopology().then((value) => getMeshMode());

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

  FutureWithEither<GetMeshTopologyModel> getMeshTopology() async {
    showLoader.value = true;

    String url = AppConstants.baseUrlAsKey + EndPoints.meshTopologyGetEndPoint;

    final response = await apiUtilsWithHeader.get(url: url, firstTime: true);

    return response.fold((l) {
      showLoader.value = false;
      return left(l);
    }, (r) {
      getMeshTopologyModel = GetMeshTopologyModel.fromJson(r.data);

      showLoader.value = false;

      return right(getMeshTopologyModel);
    });
  }

  FutureWithEither<GetMeshModeModel> getMeshMode() async {
    showLoader.value = true;

    String url = AppConstants.baseUrlAsKey + EndPoints.meshModeEndPoint;

    final response = await apiUtilsWithHeader.get(url: url, firstTime: true);

    return response.fold((l) {
      showLoader.value = false;
      return left(l);
    }, (r) {
      getMeshModeModel = GetMeshModeModel.fromJson(r.data);

      showLoader.value = false;

      return right(getMeshModeModel);
    });
  }

  SetMeshModeParam fillSetMeshMode(String meshMode) {
    return SetMeshModeParam(
      mode: meshMode.toLowerCase(),
    );
  }

  Future<StatusModel?> setMeshMode(SetMeshModeParam setMeshModeParam) async {
    showLoader.value = true;

    Map params = setMeshModeParam.toJson();

    String url = AppConstants.baseUrlAsKey + EndPoints.meshModeEndPoint;

    final response = await apiUtilsWithHeader.put(
        url: url, data: jsonEncode(params), firstTime: true);

    return response.fold((l) {
      showLoader.value = false;

      return null;
    }, (r) async {
      StatusModel status = StatusModel.fromJson(r.data);

      showLoader.value = false;

      constants.showSnackbar('Mesh Mode', 'Successfully changed mesh mode', 1);

      await getMeshTopology().then((value) => getMeshMode());

      return status;
    });
  }
}
