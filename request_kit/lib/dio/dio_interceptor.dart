import 'package:dio/dio.dart';
import 'package:request_kit/api/request.dart';
import 'package:request_kit/interceptor/interceptor.dart';
import 'package:request_kit/request_kit.dart';

class DioInterceptor extends InterceptorsWrapper {
  final List<ResponseInterceptor> responseInterceptors;
  final List<RequestInterceptor> requestInterceptors;
  final List<ErrorInterceptor> errorInterceptors;

  DioInterceptor(this.responseInterceptors, this.requestInterceptors, this.errorInterceptors);

  @override
  Future onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    var request = requestResolver(options);
    for (RequestInterceptor item in requestInterceptors) {
      await item.onRequest(request);
    }
    return super.onRequest(options, handler);
  }

  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (errorInterceptors.isNotEmpty) {
      if (err.response != null) {
        for (ErrorInterceptor item in errorInterceptors) {
          await item.onError(err.response?.statusCode, err.response?.statusMessage);
        }
      }
      if (err.error is RequestException) {
        throw err.error;
      }
      throw UnknownRequestException(message: err.message);
    }
    return super.onError(err, handler);
  }

  @override
  Future onResponse(Response response, ResponseInterceptorHandler handler) async {
    var request = requestResolver(response.requestOptions);
    for (ResponseInterceptor item in responseInterceptors) {
      await item.onResponse(request, response.statusCode, response.data);
    }
    return super.onResponse(response, handler);
  }

  Request requestResolver(RequestOptions options) {
    return Request(
      domain: options.uri.host,
      path: options.path,
      method: requestMethodResolver(options),
      headers: options.headers,
      params: options.queryParameters,
      connectTimeout: options.connectTimeout,
      readTimeout: options.receiveTimeout,
    );
  }

  RequestMethod requestMethodResolver(RequestOptions options) {
    switch (options.method) {
      case 'GET':
        return RequestMethod.GET;
      case 'POST':
        return RequestMethod.POST;
      case 'DELETE':
        return RequestMethod.DELETE;
      case 'PUT':
        return RequestMethod.PUT;
      case 'PATCH':
        return RequestMethod.PATCH;
      default:
        throw UnsupportedError('Request method: ${options.method}');
    }
  }
}
