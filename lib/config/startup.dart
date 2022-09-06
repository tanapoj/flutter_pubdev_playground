import 'package:flutter/material.dart';

import '../common/translate.dart';

Future<void> startup(BuildContext context) async {
  // exec on app startup
  //

  // return Future(() => null);
  return Future.delayed(const Duration(seconds: 2));
}
