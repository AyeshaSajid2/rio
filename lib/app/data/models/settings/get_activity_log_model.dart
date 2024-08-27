// To parse this JSON data, do
//
//     final getActivityLogModel = getActivityLogModelFromJson(jsonString);

import 'dart:convert';

GetActivityLogModel getActivityLogModelFromJson(String str) =>
    GetActivityLogModel.fromJson(json.decode(str));

String getActivityLogModelToJson(GetActivityLogModel data) =>
    json.encode(data.toJson());

class GetActivityLogModel {
  final String? status;
  final String? event;
  final String? time;
  final List<ActivityLog>? listOfActivityLog;

  GetActivityLogModel({
    this.status,
    this.event,
    this.time,
    this.listOfActivityLog,
  });

  factory GetActivityLogModel.fromJson(Map<String, dynamic> json) =>
      GetActivityLogModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        listOfActivityLog: json["list"] == null
            ? []
            : List<ActivityLog>.from(
                json["list"]!.map((x) => ActivityLog.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "list": listOfActivityLog == null
            ? []
            : List<dynamic>.from(listOfActivityLog!.map((x) => x.toJson())),
      };
}

class ActivityLog {
  final String? log;

  ActivityLog({
    this.log,
  });

  factory ActivityLog.fromJson(Map<String, dynamic> json) => ActivityLog(
        log: json["log"],
      );

  Map<String, dynamic> toJson() => {
        "log": log,
      };
}
