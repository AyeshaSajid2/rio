// To parse this JSON data, do
//
//     final signInParam = signInParamFromJson(jsonString);

import 'dart:convert';

SignInParam signInParamFromJson(String str) =>
    SignInParam.fromJson(json.decode(str));

String signInParamToJson(SignInParam data) => json.encode(data.toJson());

class SignInParam {
  String password;

  SignInParam({
    required this.password,
  });

  SignInParam copyWith({
    String? password,
  }) =>
      SignInParam(
        password: password ?? this.password,
      );

  factory SignInParam.fromJson(Map<String, dynamic> json) => SignInParam(
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
      };
}
