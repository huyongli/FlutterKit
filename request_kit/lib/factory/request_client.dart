import '../api/request.dart';

abstract class RequestClient {
  Future<dynamic> execute(Request request);

  void cancel();
}
