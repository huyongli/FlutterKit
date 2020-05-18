import '../request.dart';

abstract class ResponseFactory<T> {
  Future<Map<String, dynamic>> handleResponse(
      Request request, dynamic response);
}