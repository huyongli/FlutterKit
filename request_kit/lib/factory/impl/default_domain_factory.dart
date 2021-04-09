import '../../config/request_config.dart';
import '../../factory/url_factory.dart';

class DefaultDomainFactory extends DomainFactory {
  
  @override
  Future<String> newDomain() {
    return Future.value(RequestConfig.instance.domain);
  }
}