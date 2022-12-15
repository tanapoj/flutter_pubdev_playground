import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_live_data/index.dart' as fld;
import 'package:logger/logger.dart';
import 'package:pubdev_playground/_pub/aves/common/log.dart';
import 'package:pubdev_playground/_pub/aves/component/periodic_lifecycle_event.dart';
import 'package:pubdev_playground/_pub/aves/component/subscribe_lifecycle_event.dart';
import 'package:pubdev_playground/_pub/aves/architecture/context.dart';
import 'package:pubdev_playground/common/log.dart';
import 'package:pubdev_playground/ui/widgets/none.dart';
import 'legacy/index.dart' as legacy;

abstract class Logic<T> extends legacy.ComponentLogic {
  String get name;

  final bool _logging;

  final SubscribeLifeCycleEvent _subscribeLifeCycleEvent = SubscribeLifeCycleEvent();
  final PeriodicLifeCycleEvent _periodicLifeCycleEvent = PeriodicLifeCycleEvent();

  Logic({
    Key? key,
    required Widget Function(T) builder,
    bool showSysLog = false,
  })  : _logging = showSysLog,
        super(
          key: key,
          builder: (legacy.ComponentLogic component) => builder(component as T),
        ) {
    _selfLog('ctor');
    _subscribeLifeCycleEvent.onCtor();
    _periodicLifeCycleEvent.onCtor();
  }

  AvesContext get ctx => AvesContext();

  String get _logTag => '[Logic: $name]';

  _selfLog(String message) {
    if (_logging) {
      sysLog.i('$_logTag - $message');
    }
  }

  subscribe<T>(
    fld.LiveData<T>? liveData,
    void Function(T value) onData,
  ) {
    if (liveData == null) return;
    if (attr.isInitializingState) {
      avesLog.w('call [subscribe] inside method onInit (initState) cause abnormal behavior when Hot-Reload'
          ' --> '
          'move code to class constructor or onCreate');
    }
    return _subscribeLifeCycleEvent.call(liveData, onData);
  }

  PeriodicTimerSnap periodic(
    Duration duration,
    void Function(Timer timer) callback,
  ) {
    if (attr.isInitializingState) {
      avesLog.w('call [periodic] inside method onInit (initState) cause abnormal behavior when Hot-Reload'
          ' --> '
          'move code to class constructor or onCreate');
    }

    return _periodicLifeCycleEvent.call(duration, callback);
  }

  @override
  construct() {
    super.construct();
    _selfLog('construct');
  }

  @override
  void onInit() {
    _selfLog('init');
    super.onInit();
    _subscribeLifeCycleEvent.onInit();
    _periodicLifeCycleEvent.onInit();
  }

  @override
  void onDispose() {
    _subscribeLifeCycleEvent.onDispose();
    _periodicLifeCycleEvent.onDispose();
    super.onDispose();
    _selfLog('disposed');
  }

  @override
  onPause() {
    _subscribeLifeCycleEvent.onPause();
    _periodicLifeCycleEvent.onPause();
    super.onPause();
    _selfLog('paused');
  }

  @override
  onResume() {
    _selfLog('resume');
    super.onResume();
    _subscribeLifeCycleEvent.onResume();
    _periodicLifeCycleEvent.onResume();
  }
}
