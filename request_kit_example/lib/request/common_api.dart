import 'package:flutter/foundation.dart';
import 'package:laohu_request_kit/api.dart';
import 'package:laohu_request_kit/factory/impl/default_path_factory.dart';
import 'package:laohu_request_kit/factory/impl/default_request_header_factory.dart';
import 'package:laohu_request_kit/factory/impl/default_request_param_factory.dart';
import 'package:laohu_request_kit/factory/impl/default_response_factory.dart';
import 'package:laohu_request_kit/factory/url_factory.dart';

import 'mock_client.dart';

class CommonApi extends Api {
  CommonApi({@required String path, Map params}): super(
    domain: DefaultMockDomainFactory(),
    path: DefaultPathFactory(path),
    params: DefaultRequestParamFactory(params: params),
    headers: DefaultRequestHeaderFactory(),
    response: DefaultResponseFactory(),
    client: MockClient()
  );
}

class DefaultMockDomainFactory extends DomainFactory {

  @override
  Future<String> newDomain() async {
    return '';
  }
}