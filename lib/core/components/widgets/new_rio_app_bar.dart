import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../theme/colors.dart';

class NewRioAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String titleText;
  final void Function()? onTap;
  final bool backOn;
  final bool refresh;
  final Rx<String>? refreshText;
  final List<Widget>? actions;

  const NewRioAppBar({
    super.key,
    required this.titleText,
    this.onTap,
    this.backOn = true,
    this.refresh = false,
    this.refreshText,
    this.actions,
  }) : preferredSize = const Size.fromHeight(100.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      bottom: PreferredSize(
          preferredSize: Size(Get.width, 44),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                refresh
                    ? Obx(() {
                        return FittedBox(
                          child: Text(
                            refreshText!.value,
                            style: const TextStyle(
                              fontSize: 34,
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      })
                    : SizedBox(
                        width: Get.width - 32,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Text(
                            titleText,
                            style: const TextStyle(
                              fontSize: 34,
                              color: AppColors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
              ],
            ),
          )),
      centerTitle: false,
      leadingWidth: Get.width * .25,
      leading: backOn
          ? IconButton(
              icon: Row(
                children: [
                  Icon(
                    Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                    color: AppColors.white,
                  ),
                  const Text(
                    'Back',
                    style: TextStyle(
                      color: AppColors.white,
                    ),
                  ),
                ],
              ),
              onPressed: () => Navigator.of(context).pop(),
            )
          : null,
      actions: actions,
      automaticallyImplyLeading: false,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }
}
