// To parse this JSON data, do
//
//     final getRouterNameModel = getRouterNameModelFromJson(jsonString);

import 'dart:convert';

GetRouterNameModel getRouterNameModelFromJson(String str) =>
    GetRouterNameModel.fromJson(json.decode(str));

String getRouterNameModelToJson(GetRouterNameModel data) =>
    json.encode(data.toJson());

class GetRouterNameModel {
  final String? status;
  final String? event;
  final String? time;
  final String? routerName;

  GetRouterNameModel({
    this.status,
    this.event,
    this.time,
    this.routerName,
  });

  factory GetRouterNameModel.fromJson(Map<String, dynamic> json) =>
      GetRouterNameModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        routerName: json["router_name"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "router_name": routerName,
      };
}
