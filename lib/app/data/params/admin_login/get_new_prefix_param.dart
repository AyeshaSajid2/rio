// To parse this JSON data, do
//
//     final getNewPrefixParam = getNewPrefixParamFromJson(jsonString);

import 'dart:convert';

GetNewPrefixParam getNewPrefixParamFromJson(String str) =>
    GetNewPrefixParam.fromJson(json.decode(str));

String getNewPrefixParamToJson(GetNewPrefixParam data) =>
    json.encode(data.toJson());

class GetNewPrefixParam {
  String action;
  SerialNumber data;

  GetNewPrefixParam({
    required this.action,
    required this.data,
  });

  GetNewPrefixParam copyWith({
    String? action,
    SerialNumber? data,
  }) =>
      GetNewPrefixParam(
        action: action ?? this.action,
        data: data ?? this.data,
      );

  factory GetNewPrefixParam.fromJson(Map<String, dynamic> json) =>
      GetNewPrefixParam(
        action: json["action"],
        data: SerialNumber.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "data": data.toJson(),
      };
}

class SerialNumber {
  String sn;

  SerialNumber({
    required this.sn,
  });

  SerialNumber copyWith({
    String? sn,
  }) =>
      SerialNumber(
        sn: sn ?? this.sn,
      );

  factory SerialNumber.fromJson(Map<String, dynamic> json) => SerialNumber(
        sn: json["sn"],
      );

  Map<String, dynamic> toJson() => {
        "sn": sn,
      };
}
