// To parse this JSON data, do
//
//     final getMeshTopologyModel = getMeshTopologyModelFromJson(jsonString);

import 'dart:convert';

GetMeshTopologyModel getMeshTopologyModelFromJson(String str) =>
    GetMeshTopologyModel.fromJson(json.decode(str));

String getMeshTopologyModelToJson(GetMeshTopologyModel data) =>
    json.encode(data.toJson());

class GetMeshTopologyModel {
  final String? status;
  final String? event;
  final String? time;
  final Controller? controller;
  final List<Connectors>? listOfConnectors;

  GetMeshTopologyModel({
    this.status,
    this.event,
    this.time,
    this.controller,
    this.listOfConnectors,
  });

  factory GetMeshTopologyModel.fromJson(Map<String, dynamic> json) =>
      GetMeshTopologyModel(
        status: json["status"],
        event: json["event"],
        time: json["time"],
        controller: json["controller"] == null
            ? null
            : Controller.fromJson(json["controller"]),
        listOfConnectors: json["list"] == null
            ? []
            : List<Connectors>.from(
                json["list"]!.map((x) => Connectors.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "event": event,
        "time": time,
        "controller": controller?.toJson(),
        "list": listOfConnectors == null
            ? []
            : List<dynamic>.from(listOfConnectors!.map((x) => x.toJson())),
      };
}

class Controller {
  final String? layer;
  final String? name;
  final String? ip;
  final String? mac;

  Controller({
    this.layer,
    this.name,
    this.ip,
    this.mac,
  });

  factory Controller.fromJson(Map<String, dynamic> json) => Controller(
        layer: json["layer"],
        name: json["name"],
        ip: json["ip"],
        mac: json["mac"],
      );

  Map<String, dynamic> toJson() => {
        "layer": layer,
        "name": name,
        "ip": ip,
        "mac": mac,
      };
}

class Connectors {
  final String? layer;
  final String? name;
  final String? ip;
  final String? mac;
  final String? type;
  final String? link;
  final String? upstream;

  Connectors({
    this.layer,
    this.name,
    this.ip,
    this.mac,
    this.type,
    this.link,
    this.upstream,
  });

  factory Connectors.fromJson(Map<String, dynamic> json) => Connectors(
        layer: json["layer"],
        name: json["name"],
        ip: json["ip"],
        mac: json["mac"],
        type: json["type"],
        link: json["link"],
        upstream: json["upstream"],
      );

  Map<String, dynamic> toJson() => {
        "layer": layer,
        "name": name,
        "ip": ip,
        "mac": mac,
        "type": type,
        "link": link,
        "upstream": upstream,
      };
}
