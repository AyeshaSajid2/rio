// To parse this JSON data, do
//
//     final signUpParam = signUpParamFromJson(jsonString);

import 'dart:convert';

SignUpParam signUpParamFromJson(String str) =>
    SignUpParam.fromJson(json.decode(str));

String signUpParamToJson(SignUpParam data) => json.encode(data.toJson());

class SignUpParam {
  String email;
  String password;

  SignUpParam({
    required this.email,
    required this.password,
  });

  SignUpParam copyWith({
    String? email,
    String? password,
  }) =>
      SignUpParam(
        email: email ?? this.email,
        password: password ?? this.password,
      );

  factory SignUpParam.fromJson(Map<String, dynamic> json) => SignUpParam(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}
