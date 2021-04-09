import 'package:flutter/material.dart';

import '../config/request_config.dart';
import '../factory/impl/default_domain_factory.dart';
import '../factory/impl/default_path_factory.dart';
import '../factory/impl/default_request_param_factory.dart';
import '../factory/impl/default_request_header_factory.dart';
import '../factory/impl/default_response_factory.dart';
import '../factory/request_header_factory.dart';
import '../factory/response_factory.dart';
import '../factory/url_factory.dart';
import '../factory/request_client.dart';
import '../dio/dio_client.dart';
import '../api/api.dart';

class CommonApi extends Api {
  CommonApi({
    @required String path,
    Map params,
    DomainFactory domainFactory,
    RequestHeaderFactory headerFactory,
    ResponseFactory responseFactory,
    RequestClient client,
  }) : super(
          domain: domainFactory ?? _getDefaultDomainFactory(),
          path: DefaultPathFactory(path),
          params: DefaultRequestParamFactory(params: params),
          headers: headerFactory ?? DefaultRequestHeaderFactory(),
          response: responseFactory ?? DefaultResponseFactory(),
          client: client ?? DioClient(),
          connectTimeout: RequestConfig.instance.connectTimeout,
          readTimeout: RequestConfig.instance.readTimeout,
        );
}

DomainFactory _getDefaultDomainFactory() {
  if (RequestConfig.instance.domain != null && RequestConfig.instance.domain.isNotEmpty) {
    return DefaultDomainFactory();
  }
  return null;
}
