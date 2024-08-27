// To parse this JSON data, do
//
//     final setDeviceLabelParam = setDeviceLabelParamFromJson(jsonString);

import 'dart:convert';

SetDeviceLabelParam setDeviceLabelParamFromJson(String str) =>
    SetDeviceLabelParam.fromJson(json.decode(str));

String setDeviceLabelParamToJson(SetDeviceLabelParam data) =>
    json.encode(data.toJson());

class SetDeviceLabelParam {
  String id;
  String labelEncode;

  SetDeviceLabelParam({
    required this.id,
    required this.labelEncode,
  });

  SetDeviceLabelParam copyWith({
    String? id,
    String? labelEncode,
  }) =>
      SetDeviceLabelParam(
        id: id ?? this.id,
        labelEncode: labelEncode ?? this.labelEncode,
      );

  factory SetDeviceLabelParam.fromJson(Map<String, dynamic> json) =>
      SetDeviceLabelParam(
        id: json["id"],
        labelEncode: json["label_encode"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "label_encode": labelEncode,
      };
}
