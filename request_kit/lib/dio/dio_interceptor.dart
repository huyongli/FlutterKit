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
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    var request = requestResolver(options);
    requestInterceptors.forEach((it) {
      it.onRequest(request);
    });
    super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (errorInterceptors.isNotEmpty) {
      if (err.response != null) {
        errorInterceptors.forEach((it) {
          it.onError(err.response?.statusCode, err.response?.statusMessage);
        });
      }
      if (err.error is RequestException) {
        throw err.error;
      }
      throw UnknownRequestException(message: err.message);
    }
    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    var request = requestResolver(response.requestOptions);
    responseInterceptors.forEach((it) {
      it.onResponse(request, response.statusCode, response.data);
    });
    super.onResponse(response, handler);
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
