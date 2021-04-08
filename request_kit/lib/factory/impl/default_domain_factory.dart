import 'package:laohu_request_kit/config/request_config.dart';
import 'package:laohu_request_kit/factory/url_factory.dart';

class DefaultDomainFactory extends DomainFactory {
  
  @override
  Future<String> newDomain() {
    return Future.value(RequestConfig.instance.domain);
  }
}