// To parse this JSON data, do
//
//     final getAllowedUrlListModel = getAllowedUrlListModelFromJson(jsonString);

import 'dart:convert';

GetAllowedUrlListModel getAllowedUrlListModelFromJson(String str) =>
    GetAllowedUrlListModel.fromJson(json.decode(str));

String getAllowedUrlListModelToJson(GetAllowedUrlListModel data) =>
    json.encode(data.toJson());

class GetAllowedUrlListModel {
  final String? status;
  final String? event;
  final String? time;
  final List<AllowedUrlItem>? listOfAllowedUrls;

  GetAllowedUrlListModel({
    this.status,
    this.event,
    this.time,
    this.listOfAllowedUrls,
  });

  factory GetAllowedUrlListModel.fromJson(Map<String, dynamic> json) =>
      GetAllowedUrlListModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        listOfAllowedUrls: json["list"] == null
            ? []
            : List<AllowedUrlItem>.from(
                json["list"]!.map((x) => AllowedUrlItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "list": listOfAllowedUrls == null
            ? []
            : List<dynamic>.from(listOfAllowedUrls!.map((x) => x.toJson())),
      };
}

class AllowedUrlItem {
  final String? id;
  final String? url;
  final String? accessTime;

  AllowedUrlItem({
    this.id,
    this.url,
    this.accessTime,
  });

  factory AllowedUrlItem.fromJson(Map<String, dynamic> json) => AllowedUrlItem(
        id: json["id"],
        url: json["url"],
        accessTime: json["access_time"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "access_time": accessTime,
      };
}
