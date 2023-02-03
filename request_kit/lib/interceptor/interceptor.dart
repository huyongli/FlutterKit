import 'package:request_kit/api/request.dart';

abstract class ResponseInterceptor {
  void onResponse(Request request, int? statusCode, dynamic data);
}

abstract class RequestInterceptor {
  void onRequest(Request request);
}

abstract class ErrorInterceptor {
  void onError(int? code, String? message);
}