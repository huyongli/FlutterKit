import 'package:flutter/material.dart';
import 'package:laohu_request_kit/config/request_config.dart';
import 'package:laohu_request_kit/factory/impl/default_domain_factory.dart';

import '../dio/dio_client.dart';
import '../laohu_request_kit.dart';

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
