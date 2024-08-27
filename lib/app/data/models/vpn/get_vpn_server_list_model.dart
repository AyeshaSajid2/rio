// To parse this JSON data, do
//
//     final getVpnModel = getVpnModelFromJson(jsonString);

import 'dart:convert';

GetVpnServerListModel getVpnServerListModelFromJson(String str) =>
    GetVpnServerListModel.fromJson(json.decode(str));

String getVpnServerListModelToJson(GetVpnServerListModel data) =>
    json.encode(data.toJson());

class GetVpnServerListModel {
  final String? status;
  final String? event;
  final String? time;
  final List<ServerItem>? serverList;

  GetVpnServerListModel({
    this.status,
    this.event,
    this.time,
    this.serverList,
  });

  factory GetVpnServerListModel.fromJson(Map<String, dynamic> json) =>
      GetVpnServerListModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        serverList: json["server_list"] == null
            ? []
            : List<ServerItem>.from(
                json["server_list"]!.map((x) => ServerItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "server_list": serverList == null
            ? []
            : List<dynamic>.from(serverList!.map((x) => x.toJson())),
      };
}

class ServerItem {
  final String? name;
  final String? country;
  final String? city;
  final String? ip;
  final String? supportProtocol;

  ServerItem({
    this.name,
    this.country,
    this.city,
    this.ip,
    this.supportProtocol,
  });

  factory ServerItem.fromJson(Map<String, dynamic> json) => ServerItem(
        name: json["name"],
        country: json["country"],
        city: json["city"],
        ip: json["ip"],
        supportProtocol: json["support_protocol"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "country": country,
        "city": city,
        "ip": ip,
        "support_protocol": supportProtocol,
      };
}
