import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart' as leisim;
import 'package:package_info_plus/package_info_plus.dart';

Logger appLog = Logger.instance;

class Logger implements leisim.Logger {
  leisim.Level level = leisim.Level.debug;

  static Logger? _instance;

  static Logger get instance {
    _instance ??= Logger();
    return _instance!;
  }

  static set instance(Logger newInstance) {
    _instance = newInstance;
  }

  Future<String> _getPackageName() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }

  @override
  void close() {
    // TODO: implement close
  }

  @override
  void v(message, [error, StackTrace? stackTrace]) {
    if (level.index >= leisim.Level.verbose.index && kDebugMode) {
      print('${black('[v]')} $message');
    }
  }

  @override
  void d(message, [error, StackTrace? stackTrace]) {
    if (level.index >= leisim.Level.debug.index && kDebugMode) {
      List<String> stackTraceLine = '${StackTrace.current}'
          .split('\n')
          .where((line) => line.length > 2)
          .map((line) => line.substring(1).replaceAll(RegExp(r'^([0-9])+'), '').trim())
          .takeWhile((line) => !line.contains('package:flutter'))
          .skip(1)
          .toList();

      String stackTrace = stackTraceLine.isNotEmpty ? stackTraceLine[0] : '';

      print('${green('[d]')} ${message.toString().padRight(80)}\t\t\t${green('at: $stackTrace')}');
    }
  }

  @override
  void i(message, [error, StackTrace? stackTrace]) {
    if (level.index >= leisim.Level.info.index && kDebugMode) {
      print('${green('[i]')} $message');
    }
  }

  @override
  void w(message, [error, StackTrace? stackTrace]) {
    //if (level.index >= leisim.Level.warning.index && kDebugMode) {

    List<String> stackTraceLine = '${StackTrace.current}'
        .split('\n')
        .where((line) => line.length > 2)
        .map((line) => line.substring(1).replaceAll(RegExp(r'^([0-9])+'), '').trim())
        .takeWhile((line) => !line.contains('package:flutter'))
        .skip(1)
        .toList();

    String stackTrace = stackTraceLine.isNotEmpty ? stackTraceLine[1] : '';

    print(yellow('\n'
        '=== WARNING ============================'
        '\n'
        '[w] $message'
        '\n'
        '    $stackTrace'
        '\n'));
    //}
  }

  @override
  void e(message, [error, StackTrace? stackTrace]) {
    // if (level.index >= leisim.Level.error.index && kDebugMode) {

    List<String> stackTraceLine = '${StackTrace.current}'
        .split('\n')
        .where((line) => line.length > 2)
        .map((line) => line.substring(1).replaceAll(RegExp(r'^([0-9])+'), '').trim())
        .takeWhile((line) => !line.contains('package:flutter'))
        .skip(1)
        .toList();

    String stackTrace = stackTraceLine.map((line) => '    $line').join('\n');

    print(red('\n'
        '=== ERROR =============================='
        '\n'
        '[e] $message'
        '\n'
        '$stackTrace'
        '\n'));

    // }
  }

  @override
  void log(leisim.Level level, message, [error, StackTrace? stackTrace]) {
    print(message);
  }

  @override
  void wtf(message, [error, StackTrace? stackTrace]) {
    // TODO: implement wtf
  }

  // Black:   \x1B[30m
  // Red:     \x1B[31m
  // Green:   \x1B[32m
  // Yellow:  \x1B[33m
  // Blue:    \x1B[34m
  // Magenta: \x1B[35m
  // Cyan:    \x1B[36m
  // White:   \x1B[37m
  // Reset:   \x1B[0m

  String black(String msg) {
    return '\x1B[30m$msg\x1B[0m';
  }

  String red(String msg) {
    return '\x1B[31m$msg\x1B[0m';
  }

  String green(String msg) {
    return '\x1B[32m$msg\x1B[0m';
  }

  String blue(String msg) {
    return '\x1B[34m$msg\x1B[0m';
  }

  String cyan(String msg) {
    return '\x1B[36m$msg\x1B[0m';
  }

  String magenta(String msg) {
    return '\x1B[35m$msg\x1B[0m';
  }

  String yellow(String msg) {
    return '\x1B[33m$msg\x1B[0m';
  }

  String white(String msg) {
    return '\x1B[37m$msg\x1B[0m';
  }
}
