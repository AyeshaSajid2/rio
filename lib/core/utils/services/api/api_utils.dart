import 'package:usama/core/extensions/imports.dart';

import '../../../../app/data/models/sign_up_apis/error_sign_up_model.dart';
import '../../../../app/data/params/error_logs_param.dart';
import '../../helpers/amz_storage.dart';
import '../../helpers/askey_storage.dart';
import '../../log_utils.dart';
import 'repository/common_repository.dart';

ApiUtils apiUtils = ApiUtils();

class ApiUtils {
  static final ApiUtils _apiUtils = ApiUtils._i();
  static final Dio dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );
  late final Dio _dio;

  ApiUtils._i() {
    _dio = dio;
    // _dio.interceptors.add(CustomLogInterceptor(
    //   requestHeader: true,
    //   requestBody: true,
    //   responseHeader: false,
    //   responseBody: true,
    // ));
  }

  factory ApiUtils() {
    return _apiUtils;
  }

  Map<String, String> header = {"Content-Type": "application/json"};

  Map<String, String> headers = {
    "Content-Type": "application/json",
    "api-version": "1"
  };

  Map<String, String> secureHeaders = {
    "Content-Type": "application/json",
    "api-version": "1",
    "Authorization": ""
  };

  Future<Response> get({
    required String url,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    var result = await _dio
        .get(
          url,
          queryParameters: queryParameters,
          options: options,
        )
        .timeout(const Duration(seconds: 30));

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

    return result;
  }

  Future<Response> getWithProgress({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onReceiveProgress,
  }) async {
    //
    var result = await _dio
        .get(
          url,
          queryParameters: queryParameters,
          options: options,
          onReceiveProgress: onReceiveProgress,
        )
        .timeout(const Duration(seconds: 30));
    return result;
  }

  FutureWithEitherSign<Response> post({
    // Future<Response> post({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    try {
      var result = await _dio
          .post(
            url,
            data: data,
            queryParameters: queryParameters,
            options: options,
          )
          .timeout(const Duration(seconds: 30));

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
                responseBody: jsonDecode(result.data),
              ),
            ),
          ],
        ),
      );

      return right(result);
    } catch (e) {
      if (e is DioException && e.response != null) {
        e.response!.statusCode;

        return left(errorSignUpModelFromJson(e.response!.data));
      }
      return left(ErrorSignUpModel(
          type: 'Network Error',
          message:
              'Network Error \nPlease Check your Internet connection and try again.'));
    }
  }

  Future<Response> postWithProgress({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    ProgressCallback? onSendProgress,
  }) async {
    //
    var result = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      onSendProgress: onSendProgress,
    );
    await CommonRepo().setErrorLogs(
      ErrorLogsParam(
        appLogs: [
          AppLogs(
            date: DateTime.now(),
            routerSno: asKeyStorage.getAsKeyRouterSerialNumber(),
            severity: result.statusCode == 200 ? 'Info' : 'Error',
            rioLogin: amzStorage.getAMZUserEmail(),
            logMessage: LogMessage(
              exception: result.statusCode!.toString(),
              exceptionMessage: result.statusMessage!.toString(),
            ),
            apiRequest: ApiRequest(apiEndpoint: url, requestBody: data),
            apiResponse: ApiResponse(
              httpCode: result.statusCode!.toString(),
              responseBody: (result.data),
            ),
          ),
        ],
      ),
    );
    return result;
  }

  FutureWithEither<Response> put({
    // Future<Response> put({
    required String url,
    data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    bool? isBackGroundService,
  }) async {
    try {
      var result = await _dio
          .put(
            url,
            data: data,
            queryParameters: queryParameters,
            options: Options(receiveTimeout: const Duration(seconds: 30)),
          )
          .timeout(const Duration(seconds: 30));

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
      return errorResponse(e, isBackGroundService, url, jsonDecode(data));
    }
  }

  Future<Response> delete({
    required String api,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    //Options options = Options(headers: secureHeaders);

    //var result = await _dio.delete(api, options: options);
    var result = await _dio.delete(
      api,
      queryParameters: queryParameters,
      options: options,
    );
    return result;
  }

  FutureWithEither<Response> errorResponse(
    e,
    bool? isBackGroundService,
    String url,
    dynamic queryParameters,
  ) async {
    if (isBackGroundService == true) {
      return left(ErrorModel(
          status: '0', errorCode: 'errorCode', errorMessage: 'errorMessage'));
    }
    // 590 is Other than Dio Error
    // 598 is Connection Timeout
    // 599 is Connection Error
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

        // Dialogs.showErrorDialog(
        //   // Run 3 times API then close App
        //   // titleText: 'Unable to connect to Internet. Retrying',
        //   titleText: 'Your network is slow. Connection Timed Out',
        // );
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
      }
      // else if (e.type == DioExceptionType.badResponse) {
      //   // Handle the connection error here
      //   errorStatus = '${e.response!.statusCode}';
      //   errorCode = '${e.type}';
      //   errorMessage = '${e.response!.statusMessage}';
      //   // errorMessage = 'Rio Router connection error. Try again.';
      //   errorModel = ErrorModel(
      //       status: errorStatus,
      //       errorCode: errorCode,
      //       errorMessage: errorMessage);
      // }
      else if (e.response != null) {
        final error = ErrorModel.fromJson(e.response!.data);
        if (isBackGroundService == null && e.response!.statusCode != 401) {
          Dialogs.showErrorDialog(
            errorCode: error.errorCode!,
            errorMessage: error.errorMessage!,
          );
        }

        errorStatus = '${e.response!.statusCode}';
        errorCode = '${error.errorCode}';
        errorMessage = '${error.errorMessage}';
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
            // ApiRequest(apiEndpoint: url, requestBody: queryParameters),
            apiResponse: ApiResponse(
                httpCode: errorModel.status!,
                responseBody: errorModel.toJson()),
          ),
        ],
      ),
    );

    // print(e);
    return left(ErrorModel(
        status: errorStatus, errorCode: errorCode, errorMessage: errorMessage));
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
}

typedef FutureWithEither<T> = Future<Either<ErrorModel, T>>;
typedef FutureWithEitherSign<T> = Future<Either<ErrorSignUpModel, T>>;
