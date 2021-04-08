import 'package:dio/dio.dart';

const int _timeOut = 30000;

class RequestConfig {
  RequestConfig._internal();

  static final RequestConfig instance = RequestConfig._internal();

  int connectTimeout = _timeOut;    // milliseconds
  int readTimeout = _timeOut;       // milliseconds
  String domain;

  List<InterceptorsWrapper> dioInterceptors = [];
}