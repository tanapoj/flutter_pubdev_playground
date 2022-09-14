import 'dart:io';

void main(List<String> arguments) async {
  var time = Stopwatch();
  bool hasDebugFlag = arguments.contains("--debug");
  if (hasDebugFlag == true) {
    time.start();
    arguments.removeWhere((element) => element == "--debug");
  }

  print('arguments: $arguments');

  time.stop();
  print('Time: ${time.elapsed.inMilliseconds} Milliseconds');

  exit(0);
}
