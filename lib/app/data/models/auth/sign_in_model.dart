// To parse this JSON data, do
//
//     final signInModel = signInModelFromJson(jsonString);

import 'dart:convert';

SignInModel signInModelFromJson(String str) =>
    SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
  final String? refresh;
  final String? access;
  final String? type;

  SignInModel({
    this.refresh,
    this.access,
    this.type,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        refresh: json["refresh"],
        access: json["access"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "refresh": refresh,
        "access": access,
        "type": type,
      };
}
