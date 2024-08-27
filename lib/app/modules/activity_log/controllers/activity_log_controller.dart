import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/extensions/imports.dart';
import '../../../data/models/settings/get_activity_log_model.dart';

class ActivityLogController extends GetxController {
  RxBool showLoader = false.obs;

  ScrollController logScrollController = ScrollController();

  GetActivityLogModel getActivityLogModel = GetActivityLogModel();

  List<LogInfo> listOfActivityLog = [];

  @override
  void onInit() {
    getActivityLog();
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

  FutureWithEither<GetActivityLogModel> getActivityLog() async {
    showLoader.value = true;

    String url = AppConstants.baseUrlAsKey + EndPoints.activeLogGetEndPoint;

    final response = await apiUtilsWithHeader.get(url: url, firstTime: true);

    return response.fold((l) {
      showLoader.value = false;
      return left(l);
    }, (r) {
      getActivityLogModel = GetActivityLogModel.fromJson(r.data);

      for (var logMessage in getActivityLogModel.listOfActivityLog!) {
        // Process the log message
        LogInfo logInfo = processLogMessage(logMessage.log!);

        // Display the results
        // print("Formatted Date and Time: ${logInfo.formattedDateTime}");
        // print("Message: ${logInfo.message}");
        listOfActivityLog.add(logInfo);
      }

      showLoader.value = false;

      return right(getActivityLogModel);
    });
  }

  LogInfo processLogMessage(String logMessage) {
    // Split the log message by space
    List<String> parts = logMessage.split(' ');

    // Extract date and time information

    bool isNewStyleLog =
        !(parts[0].substring(17, 20).toLowerCase().contains('z'));

    String dateTimePart = '';
    String routerSRNo = '';
    String formattedDateTime = '';
    String message = '';

    if (isNewStyleLog) {
      dateTimePart = parts[0].substring(0, 25);

      routerSRNo = parts[0].substring(26, 37);

      // Format the date and time in the phone's local time zone
      formattedDateTime = formatDateTime(dateTimePart);

      // Combine the remaining parts to form the message

      if (parts[0].endsWith(':')) {
        message = parts.skip(1).join(' ');
      } else {
        message = "${parts[0].split(':').last} ${parts.skip(1).join(' ')}";
      }
    } else {
      dateTimePart = parts[0].substring(0, 20);

      routerSRNo = parts[0].substring(21, 32);

      // Format the date and time in the phone's local time zone
      formattedDateTime = formatDateTime(dateTimePart);

      // Combine the remaining parts to form the message

      if (parts[0].endsWith(':')) {
        message = parts.skip(1).join(' ');
      } else {
        message = "${parts[0].split(':').last} ${parts.skip(1).join(' ')}";
      }
    }

    return LogInfo(
        formattedDateTime: formattedDateTime,
        message: message.replaceAll(RegExp(r'[<>]'), ''),
        routerSRNo: routerSRNo);
  }

  String formatDateTime(String dateTimeStr) {
    // Parse the string into a DateTime object

    DateTime dateTime = DateTime.parse(dateTimeStr);

    // Convert the DateTime to the local time zone
    DateTime localDateTime = dateTime.toLocal();

    // Format the localized DateTime using the intl package
    String formattedDateTime =
        DateFormat('yyyy-MM-dd HH:mm:ss', 'en_US').format(localDateTime);

    return formattedDateTime;
  }
}

class LogInfo {
  final String formattedDateTime;
  final String message;
  final String routerSRNo;

  LogInfo(
      {required this.formattedDateTime,
      required this.message,
      required this.routerSRNo});
}
