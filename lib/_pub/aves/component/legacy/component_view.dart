import 'package:flutter/widgets.dart';
import 'component_logic.dart';
import 'life_cycle_listener.dart';

abstract class ComponentView<BC extends ComponentLogic> extends StatelessWidget implements LifeCycleListener {
  final BC logic;

  const ComponentView(
    this.logic, {
    Key? key,
  }) : super(key: key);

  @override
  void onInit() {
    // TODO: implement onInit
  }

  @override
  void onDispose() {
    // TODO: implement onDispose
  }

  @override
  void onResume() {
    // TODO: implement onResume
  }

  @override
  void onPause() {
    // TODO: implement onPause
  }
}
