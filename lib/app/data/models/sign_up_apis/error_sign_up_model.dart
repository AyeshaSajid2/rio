// To parse this JSON data, do
//
//     final errorSignUpModel = errorSignUpModelFromJson(jsonString);

import 'dart:convert';

ErrorSignUpModel errorSignUpModelFromJson(String str) =>
    ErrorSignUpModel.fromJson(json.decode(str));

String errorSignUpModelToJson(ErrorSignUpModel data) =>
    json.encode(data.toJson());

class ErrorSignUpModel {
  final String? type;
  final String? message;

  ErrorSignUpModel({
    this.type,
    this.message,
  });

  factory ErrorSignUpModel.fromJson(Map<String, dynamic> json) =>
      ErrorSignUpModel(
        type: json["__type"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "__type": type,
        "message": message,
      };
}
