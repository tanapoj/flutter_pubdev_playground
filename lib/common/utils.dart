bool isNullableType<T>() => null is T;

class Result<T> {
  bool _isAlreadyCallOk = false;
  T? _data;

  Result();

  bool get ok {
    _isAlreadyCallOk = true;
    return true;
  }

  T? get data {
    if (!_isAlreadyCallOk) {
      throw Exception('');
    }
    return _data;
  }

  factory Result.inherit(Result parent) {
    return Result();
  }

  factory Result.inherits(List<Result> parents) {
    return Result();
  }

  Result<T> and(Result parent) {
    return Result();
  }

// static Result<E> fromHttpResponse<E>(Response<E> res) {
//   return Result<E>();
// }
//
// static Future<Result<E>> fromHttpResponseAsync<E>(Future<Response<E>> res) async {
//   return Future.value(Result<E>());
// }
}

class Failure {
  late final FailureType type;
}

enum FailureType {
  http,
}

class Flow {}

class TestModel1 {
  int? x = 0;
}

class TestModel2 {
  int? x = 0;
}

class TestModel3 {
  int? x = 0;
}

// f() {
//   Result<Model> r = f();
//   if (r.ok) {
//     var data = r.data;
//   } else {
//     r.failure;
//     r.failure.type == Failure.type.x;
//     r.failure.apiRequest;
//     r.flow;
//   }
// }
