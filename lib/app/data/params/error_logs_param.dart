// To parse this JSON data, do
//
//     final errorLogsParam = errorLogsParamFromJson(jsonString);

import 'dart:convert';

ErrorLogsParam errorLogsParamFromJson(String str) =>
    ErrorLogsParam.fromJson(json.decode(str));

String errorLogsParamToJson(ErrorLogsParam data) => json.encode(data.toJson());

class ErrorLogsParam {
  List<AppLogs> appLogs;

  ErrorLogsParam({
    required this.appLogs,
  });

  ErrorLogsParam copyWith({
    List<AppLogs>? appLogs,
  }) =>
      ErrorLogsParam(
        appLogs: appLogs ?? this.appLogs,
      );

  factory ErrorLogsParam.fromJson(Map<String, dynamic> json) => ErrorLogsParam(
        appLogs: List<AppLogs>.from(
            json["app_logs"].map((x) => AppLogs.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "app_logs": List<dynamic>.from(appLogs.map((x) => x.toJson())),
      };
}

class AppLogs {
  DateTime date;
  String routerSno;
  String severity;
  String rioLogin;
  LogMessage logMessage;
  ApiRequest apiRequest;
  ApiResponse apiResponse;

  AppLogs({
    required this.date,
    required this.routerSno,
    required this.severity,
    required this.rioLogin,
    required this.logMessage,
    required this.apiRequest,
    required this.apiResponse,
  });

  AppLogs copyWith({
    DateTime? date,
    String? routerSno,
    String? severity,
    String? rioLogin,
    LogMessage? logMessage,
    ApiRequest? apiRequest,
    ApiResponse? apiResponse,
  }) =>
      AppLogs(
        date: date ?? this.date,
        routerSno: routerSno ?? this.routerSno,
        severity: severity ?? this.severity,
        rioLogin: rioLogin ?? this.rioLogin,
        logMessage: logMessage ?? this.logMessage,
        apiRequest: apiRequest ?? this.apiRequest,
        apiResponse: apiResponse ?? this.apiResponse,
      );

  factory AppLogs.fromJson(Map<String, dynamic> json) => AppLogs(
        date: DateTime.parse(json["date"]),
        routerSno: json["router_sno"],
        severity: json["severity"],
        rioLogin: json["rio_login"],
        logMessage: LogMessage.fromJson(json["log_message"]),
        apiRequest: ApiRequest.fromJson(json["api_request"]),
        apiResponse: ApiResponse.fromJson(json["api_response"]),
      );

  Map<String, dynamic> toJson() => {
        "date": date.toUtc().toIso8601String(),
        "router_sno": routerSno,
        "severity": severity,
        "rio_login": rioLogin,
        "log_message": logMessage.toJson(),
        "api_request": apiRequest.toJson(),
        "api_response": apiResponse.toJson(),
      };
}

class ApiRequest {
  String apiEndpoint;
  dynamic requestBody;

  ApiRequest({
    required this.apiEndpoint,
    required this.requestBody,
  });

  ApiRequest copyWith({
    String? apiEndpoint,
    dynamic requestBody,
  }) =>
      ApiRequest(
        apiEndpoint: apiEndpoint ?? this.apiEndpoint,
        requestBody: requestBody ?? this.requestBody,
      );

  factory ApiRequest.fromJson(Map<String, dynamic> json) => ApiRequest(
        apiEndpoint: json["api_endpoint"],
        requestBody: json["request_body"],
      );

  Map<String, dynamic> toJson() => {
        "api_endpoint": apiEndpoint,
        "request_body": requestBody,
      };
}

class ApiResponse {
  String httpCode;
  dynamic responseBody;

  ApiResponse({
    required this.httpCode,
    required this.responseBody,
  });

  ApiResponse copyWith({
    String? httpCode,
    dynamic responseBody,
  }) =>
      ApiResponse(
        httpCode: httpCode ?? this.httpCode,
        responseBody: responseBody ?? this.responseBody,
      );

  factory ApiResponse.fromJson(Map<String, dynamic> json) => ApiResponse(
        httpCode: json["http_code"],
        responseBody: json["response_body"],
      );

  Map<String, dynamic> toJson() => {
        "http_code": httpCode,
        "response_body": responseBody,
      };
}

class LogMessage {
  String exception;
  String exceptionMessage;

  LogMessage({
    required this.exception,
    required this.exceptionMessage,
  });

  LogMessage copyWith({
    String? exception,
    String? exceptionMessage,
  }) =>
      LogMessage(
        exception: exception ?? this.exception,
        exceptionMessage: exceptionMessage ?? this.exceptionMessage,
      );

  factory LogMessage.fromJson(Map<String, dynamic> json) => LogMessage(
        exception: json["exception"],
        exceptionMessage: json["exception_message"],
      );

  Map<String, dynamic> toJson() => {
        "exception": exception,
        "exception_message": exceptionMessage,
      };
}
