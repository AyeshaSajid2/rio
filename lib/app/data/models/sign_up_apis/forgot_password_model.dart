// To parse this JSON data, do
//
//     final attributeResponseModel = attributeResponseModelFromJson(jsonString);

import 'dart:convert';

AttributeResponseModel attributeResponseModelFromJson(String str) =>
    AttributeResponseModel.fromJson(json.decode(str));

String attributeResponseModelToJson(AttributeResponseModel data) =>
    json.encode(data.toJson());

class AttributeResponseModel {
  final CodeDeliveryDetails? codeDeliveryDetails;

  AttributeResponseModel({
    this.codeDeliveryDetails,
  });

  factory AttributeResponseModel.fromJson(Map<String, dynamic> json) =>
      AttributeResponseModel(
        codeDeliveryDetails: json["CodeDeliveryDetails"] == null
            ? null
            : CodeDeliveryDetails.fromJson(json["CodeDeliveryDetails"]),
      );

  Map<String, dynamic> toJson() => {
        "CodeDeliveryDetails": codeDeliveryDetails?.toJson(),
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
