import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pubdev_playground/_pub/aves/common/log.dart';
import 'package:pubdev_playground/_pub/aves/context.dart';
import 'package:pubdev_playground/_pub/aves/index.dart';
import 'package:pubdev_playground/_pub/flutter_live_data/index.dart' as fld;
import 'legacy/index.dart' as legacy;

abstract class ComponentLogic extends legacy.ComponentLogic {
  String get name;

  final SubscribeLifeCycleEvent _subscribeLifeCycleEvent = SubscribeLifeCycleEvent();
  final PeriodicLifeCycleEvent _periodicLifeCycleEvent = PeriodicLifeCycleEvent();

  ComponentLogic({
    Key? key,
    required Widget Function(ComponentLogic) builder,
  }) : super(
          key: key,
          builder: (legacy.ComponentLogic component) => builder(component as ComponentLogic),
        ) {
    selfLog(_logDecorate('ctor'));
    _subscribeLifeCycleEvent.onCtor();
    _periodicLifeCycleEvent.onCtor();
  }

  AvesCtx get ctx => AvesCtx();

  String _logDecorate(String message) => avesLog.magenta(message);

  String get _logTag => _logDecorate('[AppBloc: $name]');

  selfLog(String message) {
    avesLog.log(Level.verbose, '$_logTag - $message');
  }

  subscribe<T>(
    fld.LiveData<T>? liveData,
    void Function(T value) onData,
  ) {
    if (liveData == null) return;
    if (isInitializingState) {
      avesLog.w('call [subscribe] inside method onInit (initState) cause abnormal behavior when Hot-Reload'
          ' --> '
          'please move code to class constructor or onCreate');
    }
    return _subscribeLifeCycleEvent.call(liveData, onData);
  }

  PeriodicTimerSnap periodic(
    Duration duration,
    void Function(Timer timer) callback,
  ) {
    if (isInitializingState) {
      avesLog.w('call [periodic] inside method onInit (initState) cause abnormal behavior when Hot-Reload'
          ' --> '
          'please move code to class constructor or onCreate');
    }

    return _periodicLifeCycleEvent.call(duration, callback);
  }

  @override
  construct() {
    super.construct();
  }

  @override
  void onInit() {
    selfLog(_logDecorate('init'));
    super.onInit();
    _subscribeLifeCycleEvent.onInit();
    _periodicLifeCycleEvent.onInit();
  }

  @override
  void onDispose() {
    _subscribeLifeCycleEvent.onDispose();
    _periodicLifeCycleEvent.onDispose();
    super.onDispose();
    selfLog(_logDecorate('disposed'));
  }

  @override
  onPause() {
    _subscribeLifeCycleEvent.onPause();
    _periodicLifeCycleEvent.onPause();
    super.onPause();
    selfLog(_logDecorate('paused'));
  }

  @override
  onResume() {
    selfLog(_logDecorate('resume'));
    super.onResume();
    _subscribeLifeCycleEvent.onResume();
    _periodicLifeCycleEvent.onResume();
  }
}

class SubscribeLifeCycleEvent {
  final List<dynamic> streamSubscription = [];

  call<T>(
    fld.LiveData<T> liveData,
    void Function(T value) onData,
  ) {
    streamSubscription.add(liveData.listen(onData)!);
  }

  onCtor() {}

  onInit() {}

  onPause() {
    for (var s in streamSubscription) {
      if (s is! StreamSubscription) continue;
      StreamSubscription subscription = s;
      subscription.pause();
    }
  }

  onResume() {
    for (var s in streamSubscription) {
      if (s is! StreamSubscription) continue;
      StreamSubscription subscription = s;
      subscription.resume();
    }
  }

  onDispose() {
    onPause();
    streamSubscription.clear();
  }
}

class PeriodicLifeCycleEvent {
  final List<PeriodicTimerSnap> periodicTimerSnap = <PeriodicTimerSnap>[];

  call(
    Duration duration,
    void Function(Timer timer) callback,
  ) {
    var snap = PeriodicTimerSnap(duration, callback);
    _startTask(snap);
    periodicTimerSnap.add(snap);
    return snap;
  }

  _startTask(PeriodicTimerSnap snap) {
    snap.timer = Timer.periodic(snap.duration, (Timer timer) {
      snap.callback(timer);
      snap.run = true;
    });
  }

  _cancel() {
    for (var snap in periodicTimerSnap) {
      snap.timer?.cancel();
      snap.run = false;
    }
  }

  onCtor() {
    avesLog.d('onCtor .. periodicTimerSnap=$periodicTimerSnap');
    for (var snap in periodicTimerSnap) {
      if (!snap.run) {
        _startTask(snap);
      }
    }
  }

  onInit() {}

  onPause() {
    _cancel();
  }

  onResume() {
    for (var snap in periodicTimerSnap) {
      snap.timer = Timer.periodic(snap.duration, (Timer timer) {
        snap.callback(timer);
        snap.run = false;
      });
    }
  }

  onDispose() {
    _cancel();
    periodicTimerSnap.clear();
  }
}

class PeriodicTimerSnap {
  final Duration duration;
  final void Function(Timer timer) callback;
  Timer? timer;
  bool run = false;

  PeriodicTimerSnap(this.duration, this.callback);

  PeriodicTimerSnap startNow() {
    Future.delayed(const Duration(microseconds: 1), () {
      if (timer != null) {
        callback(timer!);
      }
    });
    return this;
  }

  @override
  String toString() {
    return 'PeriodicTimerSnap{duration: $duration, callback: $callback, timer: $timer, run: $run}';
  }
}

abstract class ComponentView<BC extends legacy.ComponentLogic> extends legacy.ComponentView<BC> {
  const ComponentView(
    BC bloc, {
    Key? key,
  }) : super(bloc, key: key);
}
