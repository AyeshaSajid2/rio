import 'package:flutter/material.dart';

import '../../helpers/common_func.dart';

class DateTimePickers {
  static Future<DateTime?> pickDateTime(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selectedDate == null) {
      return null;
    } else {
      // ignore: use_build_context_synchronously
      TimeOfDay? newTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(
            DateTime.now().add(const Duration(minutes: 1))),
      );
      if (newTime == null) {
        return null;
      } else {
        DateTime newDate = DateTime(selectedDate.year, selectedDate.month,
            selectedDate.day, newTime.hour, newTime.minute);
        if (DateTime.now().compareTo(newDate) == -1) {
          return newDate;
        } else {
          constants.showSnackbar('Invalid Date/Time Picked',
              'Please select future time for reminder.', 0);
          return null;
        }
      }
    }
  }

  static Future<DateTime?> pickDate(
      {required BuildContext context,
      required DateTime initialDate,
      required DateTime firstDate,
      required DateTime lastDate}) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      // initialDate: DateTime.now(),
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (selectedDate == null) {
      return null;
    } else {
      return selectedDate;
    }
  }
}
