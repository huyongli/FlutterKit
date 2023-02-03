import 'package:dio/dio.dart';
import 'package:request_kit/dio/dio_interceptor.dart';
import 'package:request_kit/interceptor/interceptor.dart';

import '../factory/request_client.dart';
import '../api/request.dart';
import '../common/request_exception.dart';
import '../common/request_method.dart';

class DioClient extends RequestClient {
  final Dio _dio = Dio();
  final CancelToken _token = CancelToken();
  late final InterceptorsWrapper interceptor;

  DioClient({
    List<ResponseInterceptor>? responseInterceptors,
    List<RequestInterceptor>? requestInterceptors,
    List<ErrorInterceptor>? errorInterceptors,
  }) : interceptor = DioInterceptor(responseInterceptors ?? [], requestInterceptors ?? [], errorInterceptors ?? []);

  @override
  Future<dynamic> execute(Request request) async {
    _dio.interceptors.add(interceptor);
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
          throw ArgumentError('Method ${request.method} not implemented');
      }
      return response.data;
    } catch (e) {
      if (e is DioError) {
        throw e.error;
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
