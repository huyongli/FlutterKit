import 'package:example/demo/demo_http/mock_client.dart';
import 'package:flutter/foundation.dart';
import 'package:laohu_kit/http/api.dart';
import 'package:laohu_kit/http/factory/impl/default_path_factory.dart';
import 'package:laohu_kit/http/factory/impl/default_request_header_factory.dart';
import 'package:laohu_kit/http/factory/impl/default_request_param_factory.dart';
import 'package:laohu_kit/http/factory/impl/default_response_factory.dart';
import 'package:laohu_kit/http/factory/url_factory.dart';
import 'package:laohu_kit/http/request_method.dart';

class CommonApi extends Api {
  CommonApi({@required String path}): super(
    method: RequestMethod.GET,
    domain: DefaultDomainFactory(),
    path: DefaultPathFactory(path),
    params: DefaultRequestParamFactory(),
    headers: DefaultRequestHeaderFactory(),
    response: DefaultResponseFactory(),
    client: MockClient()
  );
}

class DefaultDomainFactory extends DomainFactory {

  @override
  Future<String> newDomain() async {
    return '';
  }
}