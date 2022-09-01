import 'package:flutter/material.dart';

Future<void> startup(BuildContext context) {
  // exec on app startup
  //
  // return Future(() => null);
  return Future.delayed(const Duration(seconds: 3));
}
