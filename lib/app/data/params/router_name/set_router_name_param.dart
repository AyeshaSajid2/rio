// To parse this JSON data, do
//
//     final setRouterNameParam = setRouterNameParamFromJson(jsonString);

import 'dart:convert';

SetRouterNameParam setRouterNameParamFromJson(String str) =>
    SetRouterNameParam.fromJson(json.decode(str));

String setRouterNameParamToJson(SetRouterNameParam data) =>
    json.encode(data.toJson());

class SetRouterNameParam {
  String routerName;

  SetRouterNameParam({
    required this.routerName,
  });

  SetRouterNameParam copyWith({
    String? routerName,
  }) =>
      SetRouterNameParam(
        routerName: routerName ?? this.routerName,
      );

  factory SetRouterNameParam.fromJson(Map<String, dynamic> json) =>
      SetRouterNameParam(
        routerName: json["router_name"],
      );

  Map<String, dynamic> toJson() => {
        "router_name": routerName,
      };
}
