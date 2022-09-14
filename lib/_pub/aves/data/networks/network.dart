import 'package:pubdev_playground/_pub/aves/auth.dart';
import 'package:pubdev_playground/_pub/aves/context.dart';
import 'package:pubdev_playground/common/utils.dart';

class NetworkApi {
  Request<T> request<T>() {
    return Request<T>.http()
      ..method = 'GET'
      ..baseUrl = 'https://www.api.com/'
      ..url = ''
      ..body = {};
  }
}

class Request<T> {
  String method = 'GET';
  String? url = '/';
  String? baseUrl;
  String? accessToken;
  Map<String, dynamic> body = {};
  MockResponse? mockResponse;

  Request._internal();

  factory Request.http() {
    return Request._internal();
  }

  factory Request.fromRequest(Request<T> request) {
    var newRequest = Request<T>._internal();
    newRequest
      ..method = request.method
      ..url = request.url
      ..baseUrl = request.baseUrl
      ..accessToken = request.accessToken
      ..body = request.body
      ..mockResponse = request.mockResponse;
    return newRequest;
  }

  Future<Response<T>> call() {
    return Future.value(Response<T>());
  }

  Request<T> handler(RequestHandler handler) {
    return Request.fromRequest(this);
  }
}

class MockResponse<T> {
  int status = 0;
  T? response;
  int responseTime = 1;
}

///

class RequestHandler<T> {
  RequestHandler({
    required bool Function() handle,
  });
}

RequestHandler retry({
  required int time,
}) {
  return RequestHandler(handle: () => true);
}

RequestHandler reAuth({
  required AvesUser user,
}) {
  return RequestHandler(handle: () => true);
}

///

class Response<T> {
  T? _data;

  T get data => _data!;

  bool get isOk => true;
}
