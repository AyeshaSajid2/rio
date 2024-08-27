// To parse this JSON data, do
//
//     final getNewPrefixModel = getNewPrefixModelFromJson(jsonString);

import 'dart:convert';

GetNewPrefixModel getNewPrefixModelFromJson(String str) =>
    GetNewPrefixModel.fromJson(json.decode(str));

String getNewPrefixModelToJson(GetNewPrefixModel data) =>
    json.encode(data.toJson());

class GetNewPrefixModel {
  final String? action;
  final Data? data;

  GetNewPrefixModel({
    this.action,
    this.data,
  });

  factory GetNewPrefixModel.fromJson(Map<String, dynamic> json) =>
      GetNewPrefixModel(
        action: json["action"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "data": data?.toJson(),
      };
}

class Data {
  final String? result;
  final String? sn;
  final String? uriPrefix;
  final String? proxyIp;

  Data({
    this.result,
    this.sn,
    this.uriPrefix,
    this.proxyIp,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        result: json["result"],
        sn: json["sn"],
        uriPrefix: json["uri_prefix"],
        proxyIp: json["proxy_ip"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "sn": sn,
        "uri_prefix": uriPrefix,
        "proxy_ip": proxyIp,
      };
}
