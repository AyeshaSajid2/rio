import 'package:get/get.dart' as getx;
import 'package:usama/core/extensions/imports.dart';
import 'package:usama/core/utils/helpers/amz_storage.dart';

import '../../../../app/data/params/error_logs_param.dart';
import '../../../../app/routes/app_pages.dart';
import '../../helpers/askey_storage.dart';
import '../../log_utils.dart';
import 'repository/common_repository.dart';

ApiUtilsWithHeader apiUtilsWithHeader = ApiUtilsWithHeader();

class ApiUtilsWithHeader {
  static final ApiUtilsWithHeader _apiUtilsWithHeader = ApiUtilsWithHeader._i();
  late Dio _dioObject;
  static final Dio dio = Dio(BaseOptions(
    headers: {},
    connectTimeout: const Duration(seconds: 20),
    receiveTimeout: AppConstants.baseUrlAsKey.contains('proxy')
        ? const Duration(seconds: 60)
        : const Duration(seconds: 30),
    persistentConnection: false,
  ));

  static String token = '';

  ApiUtilsWithHeader._i() {
    _dioObject = dio;
    // _dioObject.interceptors.add(
    //   CustomLogInterceptor(
    //     request: true,
    //     requestHeader: true,
    //     requestBody: true,
    //     responseHeader: false,
    //     responseBody: true,
    //   ),
    // );
  }

  factory ApiUtilsWithHeader() {
    return _apiUtilsWithHeader;
  }

  Map<String, String> header = {"Content-Type": "application/json"};

  Map<String, String> headers = {
    // "Content-Type": "application/json",
    // "api-version": "1"
  };

  Map<String, String> secureHeaders = {
    "Content-Type": "application/json",
    "api-version": "1",
    "Authorization": ""
  };

  FutureWithEither<Response> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
    required bool firstTime,
  }) async {
    try {
      var result = await _dioObject.get(
        url,
        queryParameters: queryParameters,
        options: options ??
            Options(
              headers: headers = {
                "Cookie": 'session=$token',
              },
              receiveTimeout: AppConstants.baseUrlAsKey.contains('proxy')
                  ? const Duration(seconds: 60)
                  : const Duration(seconds: 30),
            ),
      );
      // if (result.statusCode != 200) {
      //   ErrorModel error = ErrorModel.fromJson(result.data);
      //   if (error.errorCode == 'ERR_INVALID_DEVICE_ID') {
      //     getx.Get.offAllNamed(Routes.SIGN_IN);
      //   } else {}
      // }

      await CommonRepo().setErrorLogs(
        ErrorLogsParam(
          appLogs: [
            AppLogs(
              date: DateTime.now(),
              routerSno: asKeyStorage.getAsKeyRouterSerialNumber(),
              severity: 'Info',
              rioLogin: amzStorage.getAMZUserEmail(),
              logMessage: LogMessage(
                exception: result.statusCode!.toString(),
                exceptionMessage: result.statusMessage!.toString(),
              ),
              apiRequest: ApiRequest(apiEndpoint: url, requestBody: null),
              apiResponse: ApiResponse(
                httpCode: result.statusCode!.toString(),
                responseBody: (result.data),
              ),
            ),
          ],
        ),
      );

      return right(result);
    } catch (e) {
      return errorResponse(e, null, url, queryParameters, 'GET', firstTime);
    }
  }

  FutureWithEither<Response> getForDownloading(
      {required String url,
      Map<String, dynamic>? queryParameters,
      Options? options,
      void Function(int, int)? onReceiveProgress}) async {
    try {
      var result = await _dioObject.get(
        url,
        queryParameters: queryParameters,
        options: options ??
            Options(
              headers: headers = {
                "Cookie": 'session=$token',
              },

              // receiveTimeout: const Duration(seconds: 20),
            ),
        onReceiveProgress: onReceiveProgress,
      );
      // if (result.statusCode != 200) {
      //   ErrorModel error = ErrorModel.fromJson(result.data);
      //   if (error.errorCode == 'ERR_INVALID_DEVICE_ID') {
      //     getx.Get.offAllNamed(Routes.SIGN_IN);
      //   } else {}
      // }

      return right(result);
    } catch (e) {
      return left(ErrorModel(status: e.toString()));
      // return errorResponse(e, null, url, queryParameters);
    }
  }

  FutureWithEither<Response> post({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      var result = await _dioObject
          .post(
            url,
            data: data,
            queryParameters: queryParameters,
            options: options,
          )
          .timeout(
            AppConstants.baseUrlAsKey.contains('proxy')
                ? const Duration(seconds: 60)
                : const Duration(seconds: 30),
          );
      return right(result);
    } catch (e) {
      return left(ErrorModel(
        status: 'Error',
        errorCode: '600',
        errorMessage: e.toString(),
      ));
    }
  }

  FutureWithEither<Response> postWithProgress({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    required bool firstTime,
  }) async {
    //
    try {
      var result = await _dioObject.post(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(
                headers: headers = {
                  "Cookie": 'session=$token',
                },
                contentType: 'multipart/form-data'),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return right(result);
    } catch (e) {
      return errorResponse(e, null, url, jsonDecode(data), 'POST', firstTime);
    }
  }

  FutureWithEither<Response> put({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool? isBackGroundService,
    required firstTime,
  }) async {
    try {
      var result = await _dioObject.put(
        url,
        data: data,
        queryParameters: queryParameters,
        options: options ??
            Options(
              headers: headers = {
                "Cookie": 'session=$token',
              },
              receiveTimeout: AppConstants.baseUrlAsKey.contains('proxy')
                  ? const Duration(seconds: 60)
                  : const Duration(seconds: 30),
            ),
      );
      if (isBackGroundService == null || isBackGroundService == false) {
        await CommonRepo().setErrorLogs(
          ErrorLogsParam(
            appLogs: [
              AppLogs(
                date: DateTime.now(),
                routerSno: asKeyStorage.getAsKeyRouterSerialNumber(),
                severity: 'Info',
                rioLogin: amzStorage.getAMZUserEmail(),
                logMessage: LogMessage(
                  exception: result.statusCode!.toString(),
                  exceptionMessage: result.statusMessage!.toString(),
                ),
                apiRequest:
                    ApiRequest(apiEndpoint: url, requestBody: jsonDecode(data)),
                apiResponse: ApiResponse(
                  httpCode: result.statusCode!.toString(),
                  responseBody: (result.data),
                ),
              ),
            ],
          ),
        );
      }

      return right(result);
    } catch (e) {
      return errorResponse(e, isBackGroundService, url,
          isMap(data) ? data : jsonDecode(data), 'PUT', firstTime);
    }
  }

  Future<Response> delete({
    required String api,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    //Options options = Options(headers: secureHeaders);

    //var result = await _dio.delete(api, options: options);
    var result = await _dioObject.delete(
      api,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  FutureWithEither<Response> errorResponse(
    e,
    isBackGroundService,
    String url,
    dynamic queryParameters,
    String method,
    bool firstTime,
  ) async {
    if (isBackGroundService == true) {
      return left(ErrorModel(
          status: '0', errorCode: 'errorCode', errorMessage: 'errorMessage'));
    }

    if (method == 'GET' && firstTime) {
      await get(url: url, firstTime: false);
    } else if (method == 'PUT' && firstTime) {
      await put(url: url, firstTime: false, data: queryParameters);
    } else if (method == 'POST' && firstTime) {
      await postWithProgress(url: url, firstTime: false, data: queryParameters);
    }

    String errorStatus = '';
    String errorCode = '';
    String errorMessage = '';
    ErrorModel errorModel =
        ErrorModel(status: '', errorCode: '', errorMessage: '');
    if (e is DioException) {
      if (e.type == DioExceptionType.connectionTimeout) {
        // Handle the connection timeout error here
        errorStatus = '598';
        errorCode = '${e.type}';
        // errorMessage = '${e.message}';
        errorMessage = 'Rio Router connection timed out. Try again.';
        errorModel = ErrorModel(
            status: errorStatus,
            errorCode: errorCode,
            errorMessage: errorMessage);
      } else if (e.type == DioExceptionType.connectionError) {
        // Handle the connection error here
        errorStatus = '599';
        errorCode = '${e.type}';
        // errorMessage = '${e.message}';
        errorMessage = 'Rio Router connection error. Try again.';
        errorModel = ErrorModel(
            status: errorStatus,
            errorCode: errorCode,
            errorMessage: errorMessage);
      } else if (e.response != null) {
        //bad response exception : Usually gives Error msg from Our Server
        if (e.response!.statusCode == 404) {
          errorStatus = '${e.response!.statusCode}';
          errorCode = 'Gateway_Time_out';
          errorMessage = '${e.response!.statusMessage}';
        } else if (e.response!.statusCode == 504) {
          errorStatus = '${e.response!.statusCode}';
          errorCode = 'ERR_NOT_FOUND';
          errorMessage = '${e.response!.statusMessage}';
        } else {
          errorModel = ErrorModel.fromJson(e.response!.data);

          if (isBackGroundService == null && firstTime) {
            await Dialogs.showErrorDialog(
              errorCode: errorModel.errorCode!,
              errorMessage: errorModel.errorMessage!,
            );
            if (errorModel.errorCode == 'ERR_SESSION' ||
                errorModel.errorCode == 'ERR_INVALID_DEVICE_ID' ||
                errorModel.errorCode == 'ERR_LOST_DEVICE_ID') {
              getx.Get.offAllNamed(Routes.ADMIN_LOGIN);
            }
          }

          errorStatus = '${e.response!.statusCode}';
          errorCode = '${errorModel.errorCode}';
          errorMessage = '${errorModel.errorMessage}';
        }

        errorModel = ErrorModel(
            status: errorStatus,
            errorCode: errorCode,
            errorMessage: errorMessage);
      } else {
        // Handle other Dio errors

        errorStatus = '600';
        errorCode = '${e.type}';
        errorMessage = '${e.message}';
        errorModel = ErrorModel(
            status: errorStatus,
            errorCode: errorCode,
            errorMessage: errorMessage);
      }
    } else {
      // Handle other non-Dio exceptions

      errorStatus = '590';
      errorCode = 'Non_Dio_Exception';
      errorMessage = '$e';
      errorModel = ErrorModel(
          status: errorStatus,
          errorCode: errorCode,
          errorMessage: errorMessage);
    }

    await CommonRepo().setErrorLogs(
      ErrorLogsParam(
        appLogs: [
          AppLogs(
            date: DateTime.now(),
            routerSno: asKeyStorage.getAsKeyRouterSerialNumber(),
            severity: 'Error',
            rioLogin: amzStorage.getAMZUserEmail(),
            logMessage: LogMessage(
                exception: errorModel.errorCode!,
                exceptionMessage: errorModel.errorMessage!),
            apiRequest:
                ApiRequest(apiEndpoint: url, requestBody: queryParameters),
            apiResponse: ApiResponse(
                httpCode: errorModel.status!,
                responseBody: errorModel.toJson()),
          ),
        ],
      ),
    );

    return left(errorModel);
  }

  String handleError(dynamic error) {
    String errorDescription = "";

    Log.logA(title, "handleError:: error >> $error");

    if (error is DioException) {
      Log.logA(title,
          '************************ DioException ************************');

      DioException dioException = error;
      Log.logA(title, 'dioException:: $dioException');
      if (dioException.response != null) {
        Log.logA(title, "dioException:: response >> ${dioException.response}");
      }

      switch (dioException.type) {
        case DioExceptionType.connectionError:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioExceptionType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioExceptionType.connectionTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioExceptionType.badResponse:
          errorDescription =
              "Received Bad Response whose status code: ${dioException.response?.statusCode}";
          break;
        case DioExceptionType.sendTimeout:
          errorDescription = "Send timeout in connection with API server";
          break;
        case DioExceptionType.badCertificate:
          errorDescription = "Bad Certificate Error";
          break;
        case DioExceptionType.unknown:
          errorDescription = "Unknown Error";
          break;
      }
    } else {
      errorDescription = "Unexpected error occurred";
    }
    Log.logA(title, "handleError:: errorDescription >> $errorDescription");
    return errorDescription;
  }

  getFormattedError() {
    return {'error': 'Error'};
  }

  getNetworkError() {
    return "No Internet Connection.";
  }

  bool isMap(dynamic data) {
    return data.runtimeType.toString() == "_Map<String, dynamic>";
  }
}
