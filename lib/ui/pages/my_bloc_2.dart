import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pubdev_playground/common/log.dart';
import 'package:pubdev_playground/common/translate.dart';
import 'package:pubdev_playground/config/user.dart';
import 'package:pubdev_playground/_pub/flutter_bloc_builder/endpoint.dart';
import 'package:pubdev_playground/_pub/flutter_live_data/live_data.dart';
import 'package:pubdev_playground/app/index.dart';

class MyBloc2Page extends ComponentLogic {
  @override
  String get name => 'mybloc2';

  late final LiveData<int> $counter = LiveData(0, name: '$name.counter').owner(this);
  late final LiveData<String?> $label = LiveData(null, name: '$name.label').owner(this);

  MyBloc2Page._({
    Key? key,
    required Widget Function(ComponentLogic) builder,
  }) : super(key: key, builder: builder);

  @override
  onConstruct() {
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
    String s = tt.login.success;
    var h1 = ui.text.size.header1;
  }

  factory MyBloc2Page.builder(String label) {
    return MyBloc2Page._(
      builder: (bloc) => MyBloc2View(
        bloc as MyBloc2Page,
        label: label,
      ),
    );
  }

  @override
  onInit() {
    super.onInit();
    appLog.d('${appLog.green('tag')} message');
    selfLog('message');
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

class MyBloc2View extends ComponentView<MyBloc2Page> {
  final String label;

  const MyBloc2View(
    MyBloc2Page componentLogic, {
    Key? key,
    required this.label,
  }) : super(componentLogic, key: key);

  @override
  void onInit() {
    appLog.d('view 2 ------> ${nav.push()}');

    appLog.d('${appLog.cyan('[BlocView2]')} :: onInit()');

    StreamSubscription<int>? s = logic.$counter.listen((value) {
      appLog.d('bloc.\$counter.listen = $value');
    });
    logic.subscribe(logic.$counter, (value) {
      appLog.d('bloc.subscribe(bloc.\$counter) = $value');
    });
  }

  @override
  void onDispose() {
    appLog.d('${appLog.cyan('[BlocView2]')} :: onDispose()');
  }

  @override
  void onResume() {
    appLog.d('${appLog.cyan('[BlocView2]')} :: onResume()');
  }

  @override
  void onPause() {
    appLog.d('${appLog.cyan('[BlocView2]')} :: onPause()');
  }

  @override
  Widget build(BuildContext context) {
    // appLog.d('view 2 build ------> ${context.dependOnInheritedWidgetOfExactType<AppNavigator>()?.color}');
    appLog.d('view 2 build ------> ${AppProvider.of(context).color.toString()}');

    return Scaffold(
      appBar: AppBar(
        title: const Text('BlocView2'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            $watch(auth.$state, build: (_, User? user) {
              return Text('$user');
            }),
            Text(label),
            $watch(logic.$counter, build: (_, int count) {
              return Column(
                children: [
                  if (count > 20)
                    $watch(logic.$label, build: (_, String? label) {
                      return Text('$label');
                    }),
                  Text(
                    '$count',
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              );
            }),
            ElevatedButton(
              child: const Text('+1'),
              onPressed: () {
                logic.increment();
              },
            ),
            ElevatedButton(
              child: const Text('Next Page'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (c) => MyBloc2Page.builder('Test 2'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
