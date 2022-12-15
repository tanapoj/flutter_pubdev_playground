import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bloc_builder/index.dart';
import 'package:pubdev_playground/common/log.dart';
import 'package:pubdev_playground/model/user.dart';
import 'package:pubdev_playground/app/index.dart' as app;
import 'package:pubdev_playground/ui/pages/my_bloc_2/my_bloc_2.logic.dart';

class MyBloc2View extends app.View<MyBloc2Page> {
  final String label;

  const MyBloc2View(
      MyBloc2Page logic, {
        Key? key,
        required this.label,
      }) : super(logic, key: key);

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
                    builder: (c) => MyBloc2Page.build('Test 2'),
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
