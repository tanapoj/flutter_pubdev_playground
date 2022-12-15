import 'dart:io';

import 'package:pubdev_playground/_pub/aves/cli/test.dart';

// cmd: fvm flutter pub run xxx:cli

void main(List<String> arguments) async {
  // ProcessResult x = await Process.run('fvm', ['list']);
  // print(x.stdout);

  var time = Stopwatch();
  bool hasDebugFlag = arguments.contains("--debug");
  if (hasDebugFlag == true) {
    time.start();
    arguments.removeWhere((element) => element == "--debug");
  }

  print('arguments: $arguments');

  time.stop();
  print('Time: ${time.elapsed.inMilliseconds} Milliseconds');

  // test build_runner
  // await makeDirectory('lib/gen');
  // await createNewFile('lib/gen/test.t', 'value', forceCreate: true);

  // Process.run('grep', ['-i', 'main_aves.dart']).then((result) {
  Process.run('ls', ['-l']).then((result) {
    print(result.stdout);
    print(result.stderr);
  });

  await Future.delayed(const Duration(seconds: 3));

  // exit(0);
  print('DONE!');
}
