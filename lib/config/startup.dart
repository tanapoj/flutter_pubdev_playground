import 'package:flutter/material.dart';
import 'package:pubdev_playground/_pub/aves/di.dart';
import 'package:pubdev_playground/config/di.dart';
import 'package:pubdev_playground/app/index.dart';

import '../common/translate.dart';

Future<void> startup(BuildContext context) async {
  // exec on app startup
  var provider = AppProvider.of(context);
  await provider.secondaryInit();

  setDefaultDependencies(Di().container);

  return Future(() => null);
  // return Future.delayed(const Duration(seconds: 2));
}
