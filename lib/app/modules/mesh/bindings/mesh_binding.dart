import 'package:get/get.dart';

import '../controllers/mesh_controller.dart';

class MeshBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MeshController>(
      () => MeshController(),
    );
  }
}
