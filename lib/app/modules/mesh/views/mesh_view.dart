import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/components/widgets/rio_app_bar.dart';
import '../../../../core/components/widgets/app_pop_up_menu.dart';
import '../../../../core/extensions/imports.dart';
import '../../../../core/theme/colors.dart';
import '../../../../gen/assets.gen.dart';
import '../controllers/mesh_controller.dart';

class MeshView extends GetView<MeshController> {
  const MeshView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.background,
      appBar: const RioAppBar(
        titleText: 'Mesh Topology',
      ),
      body: SingleChildScrollView(
        child: Obx(() {
          return Stack(
            children: [
              if (controller.getMeshTopologyModel.listOfConnectors != null &&
                  !controller.showLoader.value)
                Column(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(
                            left: 24, top: 24, right: 24, bottom: 8),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Controller',
                              style: TextStyle(fontSize: 18),
                            ),
                            Row(
                              children: [
                                const Text(
                                  'Mesh Mode: ',
                                  style: TextStyle(
                                      fontSize: 14, color: AppColors.appGrey),
                                ),
                                AppPopUpMenu(
                                  listOfPopupMenuItems: [
                                    AppPopupMenuItem.item(
                                        menuText: 'Router', svgPath: ''),
                                    AppPopupMenuItem.item(
                                        menuText: 'Controller', svgPath: ''),
                                    AppPopupMenuItem.item(
                                        menuText: 'Extender', svgPath: ''),
                                  ],
                                  onSelected: (typeName) {
                                    if (controller.getMeshModeModel.mode!
                                            .capitalizeFirst ==
                                        typeName) {
                                      constants.showSnackbar(
                                          'Same Mesh Mode',
                                          'Same mesh mode is already selected',
                                          0);
                                    } else {
                                      if (typeName == 'Extender') {
                                        Dialogs.showDialogWithTwoButtonsMsg(
                                            context: context,
                                            title: 'Changing Mesh Mode',
                                            subtitle:
                                                'By performing this operation: \n- The router will function as an extender \n- Router will be working in bridge mode and sync WiFi SSIDs from the Mesh Router\n- You will not be able to manage the router using Rio Mobile App \n- Router will be automatically reset to factory default settings and all the existing configurations will be erased. \n- We recommend you to take a configuration backup using router Web UI. \n\n- To return Wireless Mesh settings  back to Router mode, you will need to manually perform Factory Reset of the router by pressing and holding the reset button on the router for 10 sec and release. To restore previous configurations, load the backup configuration using router Web UI.',
                                            button1Func: () {
                                              Get.back();
                                            },
                                            button2Func: () {
                                              Get.back();
                                              controller.setMeshMode(controller
                                                  .fillSetMeshMode(typeName));
                                            });
                                      } else {
                                        controller.setMeshMode(controller
                                            .fillSetMeshMode(typeName));
                                      }
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        controller.getMeshModeModel.mode!
                                            .capitalizeFirst!,
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      const Icon(Icons.arrow_drop_down),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     const Text(
                            //       'Mesh Mode: ',
                            //       style: TextStyle(fontSize: 14),
                            //     ),
                            //     Text(
                            //       controller
                            //           .getMeshModeModel.mode!.capitalizeFirst!,
                            //       style: const TextStyle(fontSize: 14),
                            //     ),
                            //   ],
                            // ),
                          ],
                        )),
                    Container(
                      padding:
                          const EdgeInsets.only(left: 24, right: 24, bottom: 8),
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        children: [
                          ListRowItem(
                            titleText: 'Layer',
                            valueText: controller
                                .getMeshTopologyModel.controller!.layer!,
                          ),
                          const Divider(thickness: 1, height: 10),
                          ListRowItem(
                            titleText: 'Name',
                            valueText: controller
                                .getMeshTopologyModel.controller!.name!,
                          ),
                          const Divider(thickness: 1, height: 10),
                          ListRowItem(
                            titleText: 'IP Address',
                            valueText:
                                controller.getMeshTopologyModel.controller!.ip!,
                          ),
                          const Divider(thickness: 1, height: 10),
                          ListRowItem(
                            titleText: 'Mac Address',
                            valueText: controller
                                .getMeshTopologyModel.controller!.mac!,
                          ),
                        ],
                      ),
                    ),
                    ListView.builder(
                        itemCount: controller
                            .getMeshTopologyModel.listOfConnectors!.length,
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration:
                                const BoxDecoration(color: AppColors.white),
                            padding: const EdgeInsets.only(
                                left: 24, top: 24, right: 24, bottom: 8),
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Column(
                              children: [
                                ListRowItem(
                                  titleText: 'Layer',
                                  valueText: controller.getMeshTopologyModel
                                      .listOfConnectors![index].layer!,
                                ),
                                const Divider(thickness: 1, height: 10),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: ListRowItem(
                                    titleText: 'Name',
                                    valueText: controller.getMeshTopologyModel
                                        .listOfConnectors![index].name!,
                                  ),
                                ),
                                const Divider(thickness: 1, height: 10),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: ListRowItem(
                                    titleText: 'IP Address',
                                    valueText: controller.getMeshTopologyModel
                                        .listOfConnectors![index].ip!,
                                  ),
                                ),
                                const Divider(thickness: 1, height: 10),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: ListRowItem(
                                    titleText: 'Mac Address',
                                    valueText: controller.getMeshTopologyModel
                                        .listOfConnectors![index].mac!,
                                  ),
                                ),
                                const Divider(thickness: 1, height: 10),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: ListRowItem(
                                    titleText: 'Type',
                                    valueText: controller
                                        .getMeshTopologyModel
                                        .listOfConnectors![index]
                                        .type!
                                        .capitalizeFirst!,
                                  ),
                                ),
                                const Divider(thickness: 1, height: 10),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: ListRowItem(
                                    titleText: 'Link',
                                    valueText: controller
                                        .getMeshTopologyModel
                                        .listOfConnectors![index]
                                        .link!
                                        .capitalizeFirst!,
                                  ),
                                ),
                                const Divider(thickness: 1, height: 10),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: ListRowItem(
                                    titleText: 'Upstream',
                                    valueText: controller.getMeshTopologyModel
                                        .listOfConnectors![index].upstream!,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    SizedBox(height: Get.height * 0.08),
                  ],
                ),
              if (controller.showLoader.value)
                Positioned(
                  child: SizedBox(
                    height: Get.height,
                    width: Get.width,
                    child: ColoredBox(
                      color: Colors.white12,
                      child: Lottie.asset(Assets.animations.loading),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}

class ListRowItem extends StatelessWidget {
  const ListRowItem({
    super.key,
    required this.titleText,
    required this.valueText,
  });

  final String titleText;
  final String valueText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TitleText(
          title: titleText,
        ),
        SizedBox(
          width: ((Get.width - 64) / 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                valueText,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: ((Get.width - 64) / 2),
      height: 20,
      child: FittedBox(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            color: AppColors.appGrey,
            fontWeight: FontWeight.w400,
          ),
          maxLines: 1,
        ),
      ),
    );
  }
}
