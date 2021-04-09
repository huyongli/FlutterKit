import 'package:request_kit/request_kit.dart';

import 'mock_client.dart';

class MockApi extends Api {
  MockApi({required String path, Map<String, dynamic>? params}): super(
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