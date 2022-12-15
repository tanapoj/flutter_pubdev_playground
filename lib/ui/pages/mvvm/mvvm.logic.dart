import 'package:flutter/material.dart';
import 'package:flutter_live_data/index.dart';
import 'package:pubdev_playground/_pub/aves/component/logic.dart';
import 'package:pubdev_playground/_pub/aves/component/logic_controller.dart';
import 'package:pubdev_playground/ui/pages/mvvm/mvvm.view.dart';

class MvvmLogic extends Logic {
  MvvmLogic._({
    super.key,
    required super.builder,
  });

  factory MvvmLogic.build({
    Key? key,
  }) {
    return MvvmLogic._(
      key: key,
      builder: (logic) => MvvmView(logic as MvvmLogic),
    );
  }

  /// LiveData

  late final LiveData<int> $counter = LiveData(0).owner(this);

  /// life-cycle

  @override
  construct() {
    LogicController<MvvmLogic> controller;
    subscribe($counter, (value) {});
    periodic(const Duration(minutes: 1), (timer) {});
  }

  /// method

  increment() {
    $counter.value++;
  }

  @override
  // TODO: implement name
  String get name => throw UnimplementedError();
}
