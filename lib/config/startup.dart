import 'package:flutter/material.dart';
import 'package:pubdev_playground/_pub/aves/architecture/di.dart';
import 'package:pubdev_playground/config/di.dart';
import 'package:pubdev_playground/app/index.dart';

import '../common/translate.dart';

Future<void> startup(BuildContext context) async {
  var provider = App.of(context);
  await provider.asyncInit();
  setDefaultDependencies(Di().container);
  return await _startup(context);
}

Future<void> _startup(BuildContext context) async {
  // custom...
  return Future.delayed(const Duration(seconds: 2));
}
