import 'package:request_kit/api/request.dart';

abstract class ResponseInterceptor {
  Future onResponse(Request request, int? statusCode, dynamic data);
}

abstract class RequestInterceptor {
  Future onRequest(Request request);
}

abstract class ErrorInterceptor {
  Future onError(int? code, String? message);
}