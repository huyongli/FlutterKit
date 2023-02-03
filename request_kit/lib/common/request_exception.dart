class RequestException extends Error {
  final int httpCode;
  final String? message;

  RequestException({this.message, this.httpCode = -1});

  @override
  String toString() {
    return "{httpCode: $httpCode, message: '$message'}";
  }
}

class UnknownRequestException extends RequestException {
  UnknownRequestException({int? httpCode, String? message}): super(httpCode: httpCode ?? -1, message: message);
}