// To parse this JSON data, do
//
//     final getVpnModel = getVpnModelFromJson(jsonString);

import 'dart:convert';

GetVpn2Model getVpn2ModelFromJson(String str) =>
    GetVpn2Model.fromJson(json.decode(str));

String getVpn2ModelToJson(GetVpn2Model data) => json.encode(data.toJson());

class GetVpn2Model {
  final String? status;
  final String? event;
  final String? time;
  final List<VpnItem>? vpnList;

  GetVpn2Model({
    this.status,
    this.event,
    this.time,
    this.vpnList,
  });

  factory GetVpn2Model.fromJson(Map<String, dynamic> json) => GetVpn2Model(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        vpnList: json["vpn_list"] == null
            ? []
            : List<VpnItem>.from(
                json["vpn_list"]!.map((x) => VpnItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "vpn_list": vpnList == null
            ? []
            : List<dynamic>.from(vpnList!.map((x) => x.toJson())),
      };
}

class VpnItem {
  final String? id;
  final String? status;
  final String? server;
  final String? country;
  final String? city;
  final String? protocol;
  final String? connection;

  VpnItem({
    this.id,
    this.status,
    this.server,
    this.country,
    this.city,
    this.protocol,
    this.connection,
  });

  factory VpnItem.fromJson(Map<String, dynamic> json) => VpnItem(
        id: json["id"],
        status: json["status"],
        server: json["server"],
        country: json["country"],
        city: json["city"],
        protocol: json["protocol"],
        connection: json["connection"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "server": server,
        "country": country,
        "city": city,
        "protocol": protocol,
        "connection": connection,
      };
}
