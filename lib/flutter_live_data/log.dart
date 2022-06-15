import 'package:flutter/foundation.dart';

abstract class Log {
  void d(msg);

  void i(msg);

  void e(msg);
}

class Logger implements Log {
  static Logger? _instance;

  static Logger get instance {
    _instance ??= Logger();
    return _instance!;
  }

  static set instance(Logger newInstance) {
    _instance = newInstance;
  }

  @override
  void d(msg) {
    if (kDebugMode) {
      print('\x1B[34m[LIVEDATA]\x1B[0m :: $msg');
    }
  }

  @override
  void i(msg) {
    if (kDebugMode) {
      print('\x1B[34m[LIVEDATA]\x1B[0m :: $msg');
    }
  }

  @override
  void e(msg) {
    if (kDebugMode) {
      print('\x1B[31m[LIVEDATA]\x1B[0m :: $msg');
    }
  }
}
