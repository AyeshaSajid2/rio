// To parse this JSON data, do
//
//     final userSignUpModel = userSignUpModelFromJson(jsonString);

import 'dart:convert';

UserSignUpModel userSignUpModelFromJson(String str) =>
    UserSignUpModel.fromJson(json.decode(str));

String userSignUpModelToJson(UserSignUpModel data) =>
    json.encode(data.toJson());

class UserSignUpModel {
  final CodeDeliveryDetails? codeDeliveryDetails;
  final bool? userConfirmed;
  final String? userSub;

  UserSignUpModel({
    this.codeDeliveryDetails,
    this.userConfirmed,
    this.userSub,
  });

  factory UserSignUpModel.fromJson(Map<String, dynamic> json) =>
      UserSignUpModel(
        codeDeliveryDetails: json["CodeDeliveryDetails"] == null
            ? null
            : CodeDeliveryDetails.fromJson(json["CodeDeliveryDetails"]),
        userConfirmed: json["UserConfirmed"],
        userSub: json["UserSub"],
      );

  Map<String, dynamic> toJson() => {
        "CodeDeliveryDetails": codeDeliveryDetails?.toJson(),
        "UserConfirmed": userConfirmed,
        "UserSub": userSub,
      };
}

class CodeDeliveryDetails {
  final String? attributeName;
  final String? deliveryMedium;
  final String? destination;

  CodeDeliveryDetails({
    this.attributeName,
    this.deliveryMedium,
    this.destination,
  });

  factory CodeDeliveryDetails.fromJson(Map<String, dynamic> json) =>
      CodeDeliveryDetails(
        attributeName: json["AttributeName"],
        deliveryMedium: json["DeliveryMedium"],
        destination: json["Destination"],
      );

  Map<String, dynamic> toJson() => {
        "AttributeName": attributeName,
        "DeliveryMedium": deliveryMedium,
        "Destination": destination,
      };
}
