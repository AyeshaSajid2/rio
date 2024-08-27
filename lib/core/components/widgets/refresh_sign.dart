import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/colors.dart';

class RefreshSign extends StatelessWidget {
  const RefreshSign({super.key, required this.showRefreshTitle});
  final RxBool showRefreshTitle;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: (showRefreshTitle.value)
            ? const Card(
                shape: StadiumBorder(),
                child: SizedBox(
                  width: 200,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sync,
                        color: AppColors.red,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Pull down to Refresh',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.red,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : Container(),
      );
    });
  }
}
