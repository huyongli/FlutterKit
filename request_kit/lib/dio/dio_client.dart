import 'package:dio/dio.dart';

import '../config/request_config.dart';
import '../factory/request_client.dart';
import '../api/request.dart';
import '../common/request_exception.dart';
import '../common/request_method.dart';

class DioClient extends RequestClient {
  final Dio _dio = Dio();
  final CancelToken _token = CancelToken();

  @override
  Future<dynamic> execute(Request request) async {
    _dio.interceptors.addAll(RequestConfig.instance.dioInterceptors);
    try {
      Response response;
      switch (request.method) {
        case RequestMethod.POST:
          response = await _dio.post(
            request.url,
            data: request.params,
            cancelToken: _token,
            options: Options(
              headers: request.headers,
              sendTimeout: request.connectTimeout,
              receiveTimeout: request.readTimeout,
            ),
          );
          break;
        case RequestMethod.GET:
          response = await _dio.get(
            request.url,
            queryParameters: request.params,
            cancelToken: _token,
            options: Options(
              headers: request.headers,
              sendTimeout: request.connectTimeout,
              receiveTimeout: request.readTimeout,
            ),
          );
          break;
        case RequestMethod.PATCH:
          response = await _dio.patch(
            request.url,
            data: request.params,
            cancelToken: _token,
            options: Options(
              headers: request.headers,
              sendTimeout: request.connectTimeout,
              receiveTimeout: request.readTimeout,
            ),
          );
          break;
        case RequestMethod.DELETE:
          response = await _dio.delete(
            request.url,
            data: request.params,
            cancelToken: _token,
            options: Options(
              headers: request.headers,
              sendTimeout: request.connectTimeout,
              receiveTimeout: request.readTimeout,
            ),
          );
          break;
        default:
          break;
      }
      return response.data;
    } catch (e) {
      if (e is DioError) {
        if (e.type == DioErrorType.cancel) {
          throw CancelException();
        } else {
          throw e;
        }
      } else {
        if (e is RequestException) {
          throw e;
        } else {
          throw RequestException(message: e.toString());
        }
      }
    }
  }

  @override
  void cancel() {
    _token.cancel('cancel');
  }
}
