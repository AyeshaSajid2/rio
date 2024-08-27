// To parse this JSON data, do
//
//     final setVpnParam = setVpnParamFromJson(jsonString);

import 'dart:convert';

SetVpnParam setVpnParamFromJson(String str) =>
    SetVpnParam.fromJson(json.decode(str));

String setVpnParamToJson(SetVpnParam data) => json.encode(data.toJson());

class SetVpnParam {
  String id;
  String status;
  String server;
  String country;
  String city;
  String protocol;

  SetVpnParam({
    required this.id,
    required this.status,
    required this.server,
    required this.country,
    required this.city,
    required this.protocol,
  });

  SetVpnParam copyWith({
    String? id,
    String? status,
    String? server,
    String? country,
    String? city,
    String? protocol,
  }) =>
      SetVpnParam(
        id: id ?? this.id,
        status: status ?? this.status,
        server: server ?? this.server,
        country: country ?? this.country,
        city: city ?? this.city,
        protocol: protocol ?? this.protocol,
      );

  factory SetVpnParam.fromJson(Map<String, dynamic> json) => SetVpnParam(
        id: json["id"],
        status: json["status"],
        server: json["server"],
        country: json["country"],
        city: json["city"],
        protocol: json["protocol"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "server": server,
        "country": country,
        "city": city,
        "protocol": protocol,
      };
}
