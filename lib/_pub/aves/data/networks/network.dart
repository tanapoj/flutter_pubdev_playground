import 'package:dio/dio.dart' as dio;
import 'package:pubdev_playground/_pub/aves/architecture/auth.dart';
import 'package:pubdev_playground/_pub/aves/architecture/context.dart';
import 'package:pubdev_playground/_pub/aves/facade/index.dart';
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
  bool? isIncludeBaseUrl;
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
      ..isIncludeBaseUrl = true
      ..accessToken = request.accessToken
      ..body = request.body
      ..mockResponse = request.mockResponse;
    return newRequest;
  }

  Future<Response<T>> call() {
    var flow = app().flow();
    var v = Future.value(Response<T>());
    dio.Response<Map<String, dynamic>> res = dio.Response(
      requestOptions: dio.RequestOptions(
        path: '',
      ),
    );
    return v;
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
  String _body = '';
  int _statusCode = 0;

  T get data => _data!;

  String get body => _body;

  int get statusCode => _statusCode;

  bool get ok => true;
}
