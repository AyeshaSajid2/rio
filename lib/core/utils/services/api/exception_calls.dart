// import 'dart:convert';

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:fpdart/fpdart.dart';

// import '../../../app/data/models/error_model.dart';
// import '../../../app/data/models/exceptions/add_exception_model.dart';
// import '../../../app/data/models/message_model.dart';
// import '../../../constants/api_paths.dart';
// import 'api_utils.dart';

// class ExceptionCalls {
//   static FutureWithEither<MessageModel> addException(
//       AddExceptionModel addExceptionModel) async {
//     final connectivityResult = await (Connectivity().checkConnectivity());
//     if (connectivityResult == ConnectivityResult.none) {
//       return left(
//           ErrorModel(statusCode: 100, statusMessage: 'No Internet Connection'));
//     }
//     var params = {
//       'UserID': addExceptionModel.userId,
//       "Event_Name": addExceptionModel.eventName,
//       "Module_Name": addExceptionModel.moduleName,
//       "Message": addExceptionModel.message,
//     };

//     String url = baseURL + addExceptionLink;

//     try {
//       final response = await apiUtils.post(url: url, data: jsonEncode(params));
//       var checkStatus = MessageModel.fromJson(response.data);

//       if (checkStatus.statusCode == 1) {
//         return right(checkStatus);
//       } else {
//         return left(ErrorModel.fromJson(response.data));
//       }
//     } catch (e) {
//       return left(ErrorModel(
//           statusCode: 102,
//           statusMessage: 'Something went wrong. Please Try Again.'));
//     }
//   }
// }
