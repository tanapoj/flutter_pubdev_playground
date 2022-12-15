import 'package:flutter/material.dart';
import 'package:flutter_live_data/live_data.dart';
import 'package:pubdev_playground/app/index.dart';
import 'package:pubdev_playground/ui/pages/my_bloc_1/my_bloc_1.view.dart';

class MyBloc1Page extends ComponentLogic {
  @override
  String get name => 'mybloc1';

  late final LiveData<int> $counter;

  MyBloc1Page({
    Key? key,
    required Widget Function(ComponentLogic) builder,
  }) : super(key: key, builder: builder) {
    $counter = LiveData(0).owner(this);
  }

  factory MyBloc1Page.build(String label) {
    return MyBloc1Page(
      builder: (bloc) => MyBlocView1(
        logic: bloc as MyBloc1Page,
        label: label,
      ),
    );
  }

  @override
  onInit() {
    print('\x1B[32m[BlocComponent1]\x1B[0m :: onInit()');
    Future.delayed(const Duration(seconds: 1), () {
      $counter.value = 1;
    });
  }

  @override
  onDispose() {
    print('\x1B[32m[BlocComponent1]\x1B[0m :: onDispose()');
  }

  @override
  onResume() {
    print('\x1B[32m[BlocComponent1]\x1B[0m :: onResume()');
  }

  @override
  onPause() {
    print('\x1B[32m[BlocComponent1]\x1B[0m :: onPause()');
  }

  increment() {
    print('counter.value++');
    $counter.value++;

    $counter.just.value = 1;
    $counter.tick();
  }
}
