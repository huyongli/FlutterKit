import 'package:dio/dio.dart';
import 'package:laohu_kit/request/factory/request_client.dart';
import 'package:laohu_kit/request/request.dart';
import 'package:laohu_kit/request/request_exception.dart';
import 'package:laohu_kit/request/request_method.dart';

class DioInterceptor extends InterceptorsWrapper {}

class DioClient extends RequestClient {
  final Dio _dio = Dio();
  final CancelToken _token = CancelToken();

  @override
  Future<dynamic> execute(Request request) async {
    _dio.interceptors.add(DioInterceptor());
    try {
      try {
        Response response;
        switch (request.method) {
          case RequestMethod.POST:
            response = await _dio.post(request.url,
                data: request.params,
                cancelToken: _token,
                options: RequestOptions(
                    headers: request.headers,
                    connectTimeout: request.connectTimeout,
                    receiveTimeout: request.readTimeout));
            break;
          case RequestMethod.GET:
            response = await _dio.get(request.url,
                queryParameters: request.params,
                cancelToken: _token,
                options: RequestOptions(
                    headers: request.headers,
                    connectTimeout: request.connectTimeout,
                    receiveTimeout: request.readTimeout));
            break;
          case RequestMethod.PATCH:
            response = await _dio.patch(request.url,
                data: request.params,
                cancelToken: _token,
                options: RequestOptions(
                    headers: request.headers,
                    connectTimeout: request.connectTimeout,
                    receiveTimeout: request.readTimeout));
            break;
          case RequestMethod.DELETE:
            response = await _dio.delete(request.url,
                data: request.params,
                cancelToken: _token,
                options: RequestOptions(
                    headers: request.headers,
                    connectTimeout: request.connectTimeout,
                    receiveTimeout: request.readTimeout));
            break;
          default:
            break;
        }
        return response.data;
      } catch (e) {
        if (e is DioError) {
          if (e.type == DioErrorType.CANCEL) {
            throw CancelException();
          } else {
            throw e;
          }
        } else {
          throw RequestException(message: e.toString());
        }
      }
    } catch (e) {}
  }

  @override
  void cancel() {
    _token.cancel('cancel');
  }
}
