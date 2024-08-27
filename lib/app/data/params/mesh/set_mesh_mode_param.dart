// To parse this JSON data, do
//
//     final setMeshModeParam = setMeshModeParamFromJson(jsonString);

import 'dart:convert';

SetMeshModeParam setMeshModeParamFromJson(String str) =>
    SetMeshModeParam.fromJson(json.decode(str));

String setMeshModeParamToJson(SetMeshModeParam data) =>
    json.encode(data.toJson());

class SetMeshModeParam {
  String mode;

  SetMeshModeParam({
    required this.mode,
  });

  SetMeshModeParam copyWith({
    String? mode,
  }) =>
      SetMeshModeParam(
        mode: mode ?? this.mode,
      );

  factory SetMeshModeParam.fromJson(Map<String, dynamic> json) =>
      SetMeshModeParam(
        mode: json["mode"],
      );

  Map<String, dynamic> toJson() => {
        "mode": mode,
      };
}
