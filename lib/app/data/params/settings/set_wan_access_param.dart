// To parse this JSON data, do
//
//     final setWanAccessStatusParam = setWanAccessStatusParamFromJson(jsonString);

import 'dart:convert';

SetWanAccessStatusParam setWanAccessStatusParamFromJson(String str) =>
    SetWanAccessStatusParam.fromJson(json.decode(str));

String setWanAccessStatusParamToJson(SetWanAccessStatusParam data) =>
    json.encode(data.toJson());

class SetWanAccessStatusParam {
  String status;

  SetWanAccessStatusParam({
    required this.status,
  });

  SetWanAccessStatusParam copyWith({
    String? status,
  }) =>
      SetWanAccessStatusParam(
        status: status ?? this.status,
      );

  factory SetWanAccessStatusParam.fromJson(Map<String, dynamic> json) =>
      SetWanAccessStatusParam(
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
      };
}
