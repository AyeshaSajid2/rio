// To parse this JSON data, do
//
//     final setTimeZoneParam = setTimeZoneParamFromJson(jsonString);

import 'dart:convert';

SetTimeZoneParam setTimeZoneParamFromJson(String str) =>
    SetTimeZoneParam.fromJson(json.decode(str));

String setTimeZoneParamToJson(SetTimeZoneParam data) =>
    json.encode(data.toJson());

class SetTimeZoneParam {
  String timeZone;
  String timeLocation;

  SetTimeZoneParam({
    required this.timeZone,
    required this.timeLocation,
  });

  SetTimeZoneParam copyWith({
    String? timeZone,
    String? timeLocation,
  }) =>
      SetTimeZoneParam(
        timeZone: timeZone ?? this.timeZone,
        timeLocation: timeLocation ?? this.timeLocation,
      );

  factory SetTimeZoneParam.fromJson(Map<String, dynamic> json) =>
      SetTimeZoneParam(
        timeZone: json["time_zone"],
        timeLocation: json["time_location"],
      );

  Map<String, dynamic> toJson() => {
        "time_zone": timeZone,
        "time_location": timeLocation,
      };
}
