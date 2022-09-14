import 'dart:async';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:pubdev_playground/_pub/flutter_live_data/index.dart' as ld;
import 'package:pubdev_playground/_pub/mvvm_bloc/index.dart' as mvvm;
import 'package:pubdev_playground/app1/index.dart';
import 'package:pubdev_playground/common/log.dart';

abstract class Page extends ComponentLogic {
  Page({
    required super.builder,
  });
}

abstract class ComponentLogic extends mvvm.ComponentLogic {
  String get name;

  final SubscribeLifeCycleEvent _subscribeLifeCycleEvent = SubscribeLifeCycleEvent();
  final PeriodicLifeCycleEvent _periodicLifeCycleEvent = PeriodicLifeCycleEvent();

  ComponentLogic({
    Key? key,
    required Widget Function(ComponentLogic) builder,
  }) : super(
          key: key,
          builder: (mvvm.ComponentLogic component) => builder(component as ComponentLogic),
        ) {
    selfLog(_logDecorate('ctor'));
    _subscribeLifeCycleEvent.onCtor();
    _periodicLifeCycleEvent.onCtor();
  }

  AppNavigator get nav {
    if (context == null) {
      appLog.e('context is null');
      throw Exception();
    }
    return AppProvider.of(context!).navigator;
  }

  AppTranslator get translator {
    if (context == null) {
      appLog.e('context is null');
      throw Exception();
    }

    return AppProvider.of(context!).translator;
  }

  AppUi get ui {
    if (context == null) {
      appLog.e('context is null');
      throw Exception();
    }
    return AppProvider.of(context!).ui;
  }

  AppAuth get auth {
    if (context == null) {
      appLog.e('context is null');
      throw Exception();
    }
    return AppProvider.of(context!).auth;
  }

  String _logDecorate(String message) => appLog.magenta(message);

  String get _logTag => _logDecorate('[AppBloc: $name]');

  selfLog(String message) {
    appLog.log(Level.verbose, '$_logTag - $message');
  }

  subscribe<T>(
    ld.LiveData<T>? liveData,
    void Function(T value) onData,
  ) {
    if (liveData == null) return;
    if (isInitializingState) {
      appLog.w('call [subscribe] inside method onInit (initState) cause abnormal behavior when Hot-Reload'
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
      appLog.w('call [periodic] inside method onInit (initState) cause abnormal behavior when Hot-Reload'
          ' --> '
          'please move code to class constructor or onCreate');
    }

    return _periodicLifeCycleEvent.call(duration, callback);
  }

  @override
  onConstruct() {
    super.onConstruct();
    subscribe(translator.$state, (locale) {
      rebuild();
    });
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
    ld.LiveData<T> liveData,
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
    appLog.d('onCtor .. periodicTimerSnap=$periodicTimerSnap');
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

abstract class ComponentView<BC extends mvvm.ComponentLogic> extends mvvm.ComponentView<BC> {
  AppNavigator get nav {
    if (logic is! ComponentLogic) {
      appLog.e('bloc is not instance of AppBloc');
      throw Exception();
    }
    return (logic as ComponentLogic).nav;
  }

  AppTranslator get translator {
    if (logic is! ComponentLogic) {
      appLog.e('bloc is not instance of AppBloc');
      throw Exception();
    }
    return (logic as ComponentLogic).translator;
  }

  AppUi get ui {
    if (logic is! ComponentLogic) {
      appLog.e('bloc is not instance of AppBloc');
      throw Exception();
    }
    return (logic as ComponentLogic).ui;
  }

  AppAuth get auth {
    if (logic is! ComponentLogic) {
      appLog.e('bloc is not instance of AppBloc');
      throw Exception();
    }
    return (logic as ComponentLogic).auth;
  }

  const ComponentView(
    BC bloc, {
    Key? key,
  }) : super(bloc, key: key);
}
