import '../request_param_factory.dart';

class DefaultRequestParamFactory extends RequestParamFactory {
  DefaultRequestParamFactory({Map<String, dynamic> params}) : super(params);

  @override
  Future<Map<String, dynamic>> buildRequestParams() async {
    return params ?? {};
  }
}
