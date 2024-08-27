// To parse this JSON data, do
//
//     final getVpnModel = getVpnModelFromJson(jsonString);

import 'dart:convert';

import 'get_vpn_server_list_model.dart';

GetVpnModel getVpnModelFromJson(String str) =>
    GetVpnModel.fromJson(json.decode(str));

String getVpnModelToJson(GetVpnModel data) => json.encode(data.toJson());

class GetVpnModel {
  final String? status;
  final String? event;
  final String? time;
  final List<VpnItem>? vpnList;
  final List<ServerItem>? serverList;

  GetVpnModel({
    this.status,
    this.event,
    this.time,
    this.vpnList,
    this.serverList,
  });

  factory GetVpnModel.fromJson(Map<String, dynamic> json) => GetVpnModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        vpnList: json["vpn_list"] == null
            ? []
            : List<VpnItem>.from(
                json["vpn_list"]!.map((x) => VpnItem.fromJson(x))),
        serverList: json["server_list"] == null
            ? []
            : List<ServerItem>.from(
                json["server_list"]!.map((x) => ServerItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "vpn_list": vpnList == null
            ? []
            : List<dynamic>.from(vpnList!.map((x) => x.toJson())),
        "server_list": serverList == null
            ? []
            : List<dynamic>.from(serverList!.map((x) => x.toJson())),
      };
}

// class ServerItem {
//   final String? name;
//   final String? country;
//   final String? city;
//   final String? ip;
//   final String? supportProtocol;

//   ServerItem({
//     this.name,
//     this.country,
//     this.city,
//     this.ip,
//     this.supportProtocol,
//   });

//   factory ServerItem.fromJson(Map<String, dynamic> json) => ServerItem(
//         name: json["name"],
//         country: json["country"],
//         city: json["city"],
//         ip: json["ip"],
//         supportProtocol: json["support_protocol"],
//       );

//   Map<String, dynamic> toJson() => {
//         "name": name,
//         "country": country,
//         "city": city,
//         "ip": ip,
//         "support_protocol": supportProtocol,
//       };
// }

class VpnItem {
  final String? id;
  final String? status;
  final String? server;
  final String? country;
  final String? city;
  final String? protocol;
  // final String? scramble;
  // final String? transport;
  // final String? cipher;
  final String? connection;

  VpnItem({
    this.id,
    this.status,
    this.server,
    this.country,
    this.city,
    this.protocol,
    // this.scramble,
    // this.transport,
    // this.cipher,
    this.connection,
  });

  factory VpnItem.fromJson(Map<String, dynamic> json) => VpnItem(
        id: json["id"],
        status: json["status"],
        server: json["server"],
        country: json["country"],
        city: json["city"],
        protocol: json["protocol"],
        // scramble: json["scramble"],
        // transport: json["transport"],
        // cipher: json["cipher"],
        connection: json["connection"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "server": server,
        "country": country,
        "city": city,
        "protocol": protocol,
        // "scramble": scramble,
        // "transport": transport,
        // "cipher": cipher,
        "connection": connection,
      };
}
