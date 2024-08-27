import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

class Log {
  static void logs(String title, String msg) {
    log('TAG:: $title :: $msg');
  }

  static void logA(String title, var msg) {
    //print('TAG:: $title :: $msg');
    // OR
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern
        .allMatches(msg)
        .forEach((match) => log('TAG:: $title :: ${match.group(0)!}'));
  }

  static void logI(String title, int msg) {
    log('TAG:: $title :: $msg');
  }

  static printWrapped(String text) {
    final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => log(match.group(0)!));
  }

  static String printPrettyMap(Map mapData) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');

    // display map in alphabetic order
    final sortedData =
        SplayTreeMap<String, dynamic>.from(mapData, (a, b) => a.compareTo(b));
    String prettyPrint = encoder.convert(sortedData);

    return prettyPrint;
  }
}
