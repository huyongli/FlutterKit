import 'package:flutter/foundation.dart';
import 'package:laohu_kit/request/factory/impl/default_path_factory.dart';
import 'package:laohu_kit/request/api.dart';
import 'package:laohu_kit/request/factory/impl/default_request_header_factory.dart';
import 'package:laohu_kit/request/factory/impl/default_request_param_factory.dart';
import 'package:laohu_kit/request/factory/impl/default_response_factory.dart';
import 'package:laohu_kit/request/factory/url_factory.dart';
import 'package:laohu_kit/request/request_method.dart';

import 'mock_client.dart';

class CommonApi extends Api {
  CommonApi({@required String path, method: RequestMethod.GET}): super(
    method: method,
    domain: DefaultMockDomainFactory(),
    path: DefaultPathFactory(path),
    params: DefaultRequestParamFactory(),
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