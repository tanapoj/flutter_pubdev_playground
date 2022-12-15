import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pubdev_playground/common/log.dart';
import 'package:pubdev_playground/common/translate.dart';
import 'package:flutter_live_data/index.dart';
import 'package:pubdev_playground/app/index.dart' as app;
import 'package:pubdev_playground/ui/pages/my_bloc_2/my_bloc_2.view.dart';

class MyBloc2Page extends app.ComponentLogic {
  @override
  String get name => 'mybloc2';

  late final LiveData<int> $counter = LiveData(0, name: '$name.counter').owner(this);
  late final LiveData<String?> $label = LiveData(null, name: '$name.label').owner(this);

  MyBloc2Page._({
    Key? key,
    required Widget Function(app.ComponentLogic) builder,
  }) : super(key: key, builder: builder);

  @override
  construct() {
    // StreamSubscription<int>? s = $counter.listen((value) {
    //   appLog.d('\$counter.listen = $value');
    // });
    subscribe($counter, (value) {
      appLog.d('---> 1 subscribe(\$counter) = $value');
    });

    subscribe(auth.$state, (value) {});

    var snap = periodic(const Duration(seconds: 3), (timer) {
      $counter.value += 100;
    }).startNow();

    translator;
    String s = tt.home_page.title;
    var h1 = ui.style.text.size.header1;
  }

  factory MyBloc2Page.build(String label) {
    return MyBloc2Page._(
      builder: (logic) => MyBloc2View(
        logic as MyBloc2Page,
        label: label,
      ),
    );
  }

  @override
  onInit() {
    super.onInit();
    appLog.d('${appLog.green('tag')} message');
    appLog.d('bloc 2 ------> ${nav.push()}');

    Future.delayed(const Duration(seconds: 1), () {
      $counter.value += 1;
    });

    subscribe($counter, (value) {
      appLog.d('---> 2 subscribe(\$counter) = $value');
    });

    periodic(const Duration(seconds: 3), (timer) {
      $counter.value += 100;
    }).startNow();
  }

  @override
  onDispose() {
    super.onDispose();
  }

  @override
  onResume() {
    super.onResume();
  }

  @override
  onPause() {
    super.onPause();
  }

  increment() {
    appLog.d('counter.value++');
    $counter.value++;
  }
}
