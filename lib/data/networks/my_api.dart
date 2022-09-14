import 'package:pubdev_playground/_pub/aves/data/networks/network.dart';
import 'package:pubdev_playground/common/utils.dart';
import 'package:pubdev_playground/config/context.dart';

class MyNetworkApi extends NetworkApi {
  @override
  Request<T> request<T>() {
    return Request<T>.http()
      ..method = 'GET'
      ..baseUrl = 'https://www.api.com/'
      ..url = ''
      ..body = {};
  }

  Request<TestModel1> getData({Ctx? ctx}) {
    ctx ??= Ctx();
    return ctx.perform(
      request<TestModel1>()
        ..method = 'GET'
        ..url = 'data'
        ..body = {
          'x': 1,
        }
        ..mockResponse = (MockResponse<String>()
          ..status = 200
          ..responseTime = 1
          ..response = '{"x":1}'),
    );
  }

  Request<TestModel1> postAccessToken({Ctx? ctx}) {
    return request<TestModel1>()
      ..method = 'GET'
      ..url = 'data'
      ..body = {
        'x': 1,
      }
      ..handler(retry(time: 3));
  }
}
