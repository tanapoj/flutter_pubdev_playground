import 'package:pubdev_playground/common/utils.dart';

class NetworkApi {
  HttpRequest<T> request<T>(String url) {
    return HttpRequest<T>();
  }

  Future<HttpResponse<TestModel1>> getData({Flow? flow}) async {
    return await request<TestModel1>('https://').call();
  }
}

class HttpRequest<T> {
  HttpRequest();

  factory HttpRequest.make() {
    return HttpRequest();
  }

  Future<HttpResponse<T>> call() {
    return Future.value(HttpResponse<T>());
  }
}

class HttpResponse<T> {}
