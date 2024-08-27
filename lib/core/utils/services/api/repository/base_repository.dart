import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import '../api_params.dart';
import '../api_utils.dart';

class BaseRepo<T> {
  Future<T> get({
    required String apiURL,
    Map<String, dynamic>? queryParameters,
    Options? options,
  }) async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      return {
        PARAM_STATUS_CODE: CODE_NO_INTERNET,
        PARAM_MESSAGE: apiUtils.getNetworkError(),
      } as T;
    }

    try {
      final response = await apiUtils.get(
        url: apiURL,
        queryParameters: queryParameters,
        options: options,
      );
      return response.data;
    } catch (e) {
      return {
        PARAM_STATUS_CODE: CODE_ERROR,
        PARAM_MESSAGE: apiUtils.handleError(e),
      } as T;
    }
  }

  // Future<T> post({
  //   required String apiURL,
  //   data,
  //   Map<String, dynamic>? queryParameters,
  //   Options? options,
  // }) async {
  //   final connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.none) {
  //     return {
  //       PARAM_STATUS_CODE: CODE_NO_INTERNET,
  //       PARAM_MESSAGE: apiUtils.getNetworkError(),
  //     } as T;
  //   }

  //   try {
  //     final response = await apiUtils.post(
  //       url: apiURL,
  //       data: data,
  //       queryParameters: queryParameters,
  //       options: options,
  //     );
  //     return response.data;
  //   } catch (e) {
  //     return {
  //       PARAM_STATUS_CODE: CODE_ERROR,
  //       PARAM_MESSAGE: apiUtils.handleError(e),
  //     } as T;
  //   }
  // }

  // FutureWithEither<Either<ErrorModel, T>> postEither({
  //   required String apiURL,
  //   data,
  //   Map<String, dynamic>? queryParameters,
  //   Options? options,
  // }) async {
  //   final connectivityResult = await (Connectivity().checkConnectivity());
  //   if (connectivityResult == ConnectivityResult.none) {
  //     return left(
  //         ErrorModel(statusCode: 100, statusMessage: 'No Internet Access'));
  //   }

  //   try {
  //     final response = await apiUtils.post(
  //       url: apiURL,
  //       data: data,
  //       queryParameters: queryParameters,
  //       options: options,
  //     );
  //     return right(response.data);
  //   } catch (e) {
  //     log(e.toString());
  //     return left(ErrorModel(
  //         statusCode: 102,
  //         statusMessage: 'Something went wrong. Please Try Again.'));
  //   }
  // }
}
