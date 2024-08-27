import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:usama/core/components/widgets/outlined_app_button.dart';
import 'package:usama/core/theme/colors.dart';

import '../../../../core/components/widgets/filled_round_button.dart';
import '../../../../core/extensions/imports.dart';
import '../../../../gen/assets.gen.dart';
import '../../../routes/app_pages.dart';
import '../controllers/router_setup_controller.dart';
import 'router_ready_view.dart';

class RouterSetupSettingView extends GetView<RouterSetupController> {
  const RouterSetupSettingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: true,
      floatingActionButton: Obx(() {
        return controller.isKeyboardOpened.value
            ? Container()
            : FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  Get.toNamed(Routes.CUSTOMER_SUPPORT);
                },
                child: const Icon(Icons.support_agent, color: AppColors.white),
              );
      }),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            // height: Get.height,
            child: Form(
              key: controller.routerSettingsKey,
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: SvgPicture.asset(
                          Assets.svgs.logo,
                          width: Get.width * 0.15,
                          height: Get.width * 0.15,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          'Wireless Networks &\n SecureRooms',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.listOfSSIDSetting.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ColoredTile(
                            title:
                                controller.listOfSSIDSetting[index].keys.first,
                            stepInstruction: controller
                                .listOfSSIDSetting[index].values.first,
                            showBackgroundColor: index % 2 == 0 ? true : false);
                      }),
                  const Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                    child: Text(
                      'Your Rio comes with the following SSIDs and SecureRooms in each SSID. You can edit the names and add new SecureRooms as per your needs.',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.background,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8.0),
                          child: Text('SecureRooms AND SSIDs UTILIZATION',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              )),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16),
                            ),
                          ),
                          child: ListTile(
                            tileColor: AppColors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            title: Text(
                              'SecureRooms',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            trailing: Obx(() {
                              return Text(
                                '${controller.roomCount.value}/16',
                                style: TextStyle(
                                  color: Colors.black.withOpacity(0.7),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                ),
                              );
                            }),
                          ),
                        ),
                        const Divider(
                          height: 0,
                          indent: 16,
                          thickness: 1,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(16),
                              bottomRight: Radius.circular(16),
                            ),
                          ),
                          child: ListTile(
                            tileColor: AppColors.white,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16),
                              ),
                            ),
                            title: Text(
                              'SSIDs',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            trailing: Text(
                              '${controller.getWifiListModel.listOfWifi!.length}/4',
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (controller.getWifiListModel.listOfWifi != null &&
                      !controller.showLoader.value)
                    ListView.builder(
                        itemCount:
                            controller.getWifiListModel.listOfWifi!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Obx(() {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(16.0),
                                    decoration: const BoxDecoration(
                                      color: AppColors.ssidBackground,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Text(
                                                'SSID',
                                                style: TextStyle(
                                                  color: AppColors.black,
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () {
                                                  controller
                                                          .listOfExpandedRooms[
                                                              index]
                                                          .value =
                                                      !controller
                                                          .listOfExpandedRooms[
                                                              index]
                                                          .value;
                                                },
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color:
                                                              AppColors.blue),
                                                  child: Icon(
                                                    controller
                                                            .listOfExpandedRooms[
                                                                index]
                                                            .value
                                                        ? Icons.remove
                                                        : Icons.add,
                                                    color: AppColors.white,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),

                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: ((Get.width - 32)),
                                              child: TextFormField(
                                                controller: controller
                                                    .listOfWifiNameTEC[index],
                                                enabled: controller
                                                            .getWifiListModel
                                                            .listOfWifi![index]
                                                            .id ==
                                                        '0'
                                                    ? false
                                                    : true,
                                                onTapOutside: (event) {
                                                  constants
                                                      .dismissKeyboard(context);
                                                },
                                                validator: (p0) {
                                                  if (p0 == null ||
                                                      p0.isEmpty) {
                                                    return 'Please Enter a WiFi name';
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8),
                                                  suffixText: (index == 1 ||
                                                          index == 2 ||
                                                          index == 3)
                                                      ? controller
                                                              .listOfSuffixText[
                                                          index]
                                                      : null,
                                                  hintText: 'WiFi Name',
                                                  border:
                                                      const OutlineInputBorder(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                              width: ((Get.width - 32)),
                                              child: TextFormField(
                                                controller: controller
                                                        .listOfWifiPasswordsTEC[
                                                    index],
                                                onTapOutside: (event) {
                                                  constants
                                                      .dismissKeyboard(context);
                                                },
                                                validator: (p0) {
                                                  if (p0 == null ||
                                                      p0.isEmpty) {
                                                    return 'Please Enter a WiFi password';
                                                  } else if (p0.length < 8) {
                                                    return 'WiFi password must have 8 characters';
                                                  }
                                                  return null;
                                                },
                                                obscureText: !controller
                                                    .listOfShowPassword[index]
                                                    .value,
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 8),
                                                  hintText: 'WiFi Password',
                                                  suffixIcon: InkWell(
                                                    onTap: () {
                                                      controller
                                                              .listOfShowPassword[
                                                                  index]
                                                              .value =
                                                          !controller
                                                              .listOfShowPassword[
                                                                  index]
                                                              .value;
                                                    },
                                                    child: Icon(controller
                                                            .listOfShowPassword[
                                                                index]
                                                            .value
                                                        ? Icons
                                                            .visibility_off_outlined
                                                        : Icons
                                                            .remove_red_eye_outlined),
                                                  ),
                                                  border:
                                                      const OutlineInputBorder(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        //
                                        if (((controller.getWifiListModel
                                                    .listOfWifi!.length) >
                                                index) &&
                                            controller
                                                .listOfExpandedRooms[index]
                                                .value)
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 16),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  const Text(
                                                    'SecureRooms',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      color: AppColors.black,
                                                      fontWeight:
                                                          FontWeight.w700,
                                                    ),
                                                  ),
                                                  if (index != 0)
                                                    InkWell(
                                                      onTap: () {
                                                        if (controller.roomCount
                                                                .value <=
                                                            16) {
                                                          // controller.addNewRoom(
                                                          //     index);

                                                          Dialogs
                                                              .showAddEditRoomBottomSheet(
                                                            roomParam:
                                                                controller
                                                                    .newRoom(
                                                                        index),
                                                            isNewRoom: true,
                                                            index: index,
                                                            i: 0,
                                                          );
                                                        } else {
                                                          constants.showSnackbar(
                                                              'Room Limit reached',
                                                              'You have reached maximum limit of 16 secured rooms.',
                                                              0);
                                                        }
                                                      },
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 3,
                                                                horizontal: 10),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                            color:
                                                                AppColors.red),
                                                        child: const Text(
                                                          'Add Room',
                                                          style: TextStyle(
                                                            color:
                                                                AppColors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              ListView.builder(
                                                  itemCount: controller
                                                      .allWifiRoomsParamsList[
                                                          index]
                                                      .length,
                                                  shrinkWrap: true,
                                                  padding: EdgeInsets.zero,
                                                  physics:
                                                      const NeverScrollableScrollPhysics(),
                                                  itemBuilder: (context, i) {
                                                    return Padding(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          vertical: 4.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ListTile(
                                                            contentPadding:
                                                                EdgeInsets.zero,
                                                            title: Text(
                                                              controller
                                                                  .allWifiRoomsParamsList[
                                                                      index][i]
                                                                  .nameEncode
                                                                  .decodeBase64,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal,
                                                              ),
                                                            ),
                                                            trailing: InkWell(
                                                              onTap: () {
                                                                Dialogs.showAddEditRoomBottomSheet(
                                                                    roomParam:
                                                                        controller.allWifiRoomsParamsList[index]
                                                                            [i],
                                                                    isNewRoom:
                                                                        false,
                                                                    index:
                                                                        index,
                                                                    i: i);
                                                              },
                                                              child:
                                                                  const SizedBox(
                                                                width: 100,
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .edit_outlined,
                                                                      size: 18,
                                                                      color: AppColors
                                                                          .black,
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          EdgeInsets.all(
                                                                              4.0),
                                                                      child: Text(
                                                                          'Configure'),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          if (i <
                                                              controller
                                                                      .allWifiRoomsParamsList[
                                                                          index]
                                                                      .length -
                                                                  1)
                                                            const Divider(
                                                              height: 0,
                                                              thickness: 1,
                                                            ),
                                                          if (index == 0) ...[
                                                            const SizedBox(
                                                                height: 8),
                                                            const Text(
                                                              'Note:',
                                                              style: TextStyle(
                                                                fontSize: 15,
                                                                color: AppColors
                                                                    .black,
                                                              ),
                                                            ),
                                                            RichText(
                                                              text:
                                                                  const TextSpan(
                                                                text:
                                                                    'Room Assignment: ',
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        'Only one room can be assigned to this SSID.',
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                      color: AppColors
                                                                          .black,
                                                                    ),
                                                                  )
                                                                ],
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 12,
                                                                  color:
                                                                      AppColors
                                                                          .black,
                                                                ),
                                                              ),
                                                            ),
                                                            RichText(
                                                              text:
                                                                  const TextSpan(
                                                                text:
                                                                    'Administrator Assignment: ',
                                                                children: [
                                                                  TextSpan(
                                                                    text:
                                                                        'The first device setting up the Rio Router is automatically designated as the Administrator. The Admin can then assign another device as Admin, but there can be a maximum of 2 Admin  devices only. Other devices added to the Admin room will have Manager role.',
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w300,
                                                                    ),
                                                                  )
                                                                ],
                                                                style:
                                                                    TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  fontSize: 12,
                                                                  color:
                                                                      AppColors
                                                                          .black,
                                                                ),
                                                              ),
                                                            ),
                                                          ]
                                                        ],
                                                      ),
                                                    );
                                                  }),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ),
                                  const Divider(
                                    height: 0,
                                  ),
                                ],
                              ),
                            );
                          });
                        }),
                  FilledRoundButton(
                    onPressed: () {
                      if (controller.routerSettingsKey.currentState!
                          .validate()) {
                        controller.saveAndContinue();
                      }
                    },
                    buttonText: 'Save & Continue',
                  ),
                  OutlinedAppButton(
                    onPressed: () {
                      Get.to(() => const RouterReadyView());
                    },
                    buttonText: 'Skip',
                    buttonColor: AppColors.black,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ColoredTile extends StatelessWidget {
  const ColoredTile({
    super.key,
    required this.title,
    required this.showBackgroundColor,
    this.showBorder = true,
    required this.stepInstruction,
    this.isInstructionColorRed = false,
    this.subSteps,
  });

  final String title;
  final String stepInstruction;
  final List<Map<String, String>>? subSteps;
  final bool showBackgroundColor;
  final bool showBorder;
  final bool isInstructionColorRed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(
        color: showBackgroundColor
            ? AppColors.splashTileBackground
            : AppColors.white,
        border: showBorder
            ? const Border(
                bottom: BorderSide(color: AppColors.appGrabber, width: 0.5))
            : null,
      ),
      child: IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                )),
            Text(
              stepInstruction,
              style: TextStyle(
                color: isInstructionColorRed
                    ? AppColors.red
                    : Colors.black.withOpacity(0.7),
                fontSize: 14,
                fontWeight: FontWeight.w300,
              ),
            ),
            if (subSteps != null && subSteps!.isNotEmpty)
              SizedBox(
                width: Get.width,
                height: 230,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: subSteps!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Wrap(
                        children: [
                          Text(subSteps![index].keys.first,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              )),
                          Text(subSteps![index].values.first,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                              )),
                        ],
                      );
                    }),
              ),
          ],
        ),
      ),
    );
  }
}
