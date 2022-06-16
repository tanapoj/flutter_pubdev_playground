import 'dart:async';

import 'package:pubdev_playground/flutter_bloc_builder/endpoint.dart';
import 'package:pubdev_playground/flutter_live_data/broadcast.dart';
import 'package:pubdev_playground/flutter_live_data/log.dart';

import 'life_cycle.dart';
export 'broadcast.dart';

/// Live Data Structure
class LiveData<T> implements LifeCycleObservable {
  final String? name;
  final T initialValue;
  T _currentValue;
  LifeCycleObserver? _lifeCycleObserver;
  late StreamController<T> streamController;
  late Logger logger;
  Map<dynamic, dynamic> attachedItems = {};
  List<void Function(LiveData<T> liveData)> apples = [];

  LiveData(
    T initValue, {
    this.name,
    StreamController<T>? streamController,
    LifeCycleObserver? lifeCycleObserver,
    Logger? logger,
  })  : initialValue = initValue,
        _currentValue = initValue {
    this.logger = logger ?? Logger.instance;
    this.streamController = streamController ?? StreamController<T>.broadcast();
    if (lifeCycleObserver != null) {
      bind(lifeCycleObserver);
    }
  }

  factory LiveData.many(
    T initValue, {
    String? name,
    StreamController<T>? streamController,
    LifeCycleObserver? lifeCycleObserver,
    Logger? logger,
  }) {
    return LiveData(
      initValue,
      name: name,
      streamController: streamController,
      lifeCycleObserver: lifeCycleObserver,
      logger: logger,
    );
  }

  factory LiveData.once(
    T initValue, {
    String? name,
    StreamController<T>? streamController,
    LifeCycleObserver? lifeCycleObserver,
    Logger? logger,
  }) {
    LiveData<T> instance = LiveData<T>(
      initValue,
      name: name,
    );
    instance.streamController = streamController ?? StreamController<T>();
    instance._currentValue = initValue;
    instance.logger = logger ?? Logger.instance;
    instance.streamController = streamController ?? StreamController<T>();
    if (lifeCycleObserver != null) {
      instance.bind(lifeCycleObserver);
    }
    return instance;
  }

  LiveData<T> bind(LifeCycleObserver lifeCycleObserver) {
    logger.d('$name bind on lifeCycleObserver: $lifeCycleObserver');
    _lifeCycleObserver = lifeCycleObserver;
    _lifeCycleObserver?.observeLiveData<T>(this);
    return this;
  }

  Stream<T>? get stream => streamController.stream;

  LifeCycleObserver? get lifeCycleObserver => _lifeCycleObserver;

  set value(T value) {
    if (name == null) {
      logger.i('set value: $value');
    } else {
      logger.i('"${name ?? ''}" set value: $value');
    }
    _currentValue = value;
    if (apples.isNotEmpty) {
      for (var fn in apples) {
        applyOnce(fn);
      }
    }
    try {
      streamController.add(value);
    } catch (e) {
      close();
    }
  }

  T get value => _currentValue;

  void mutate(void Function(T) setter) {
    setter(_currentValue);
    value = _currentValue;
  }

  void transform(T Function(T) setter) {
    value = setter(_currentValue);
  }

  void tick() {
    value = _currentValue;
  }

  LiveData<T> apply(void Function(LiveData<T> liveData) apply) {
    apples.add(apply);
    applyOnce(apply);
    return this;
  }

  LiveData<T> applyOnce(void Function(LiveData<T> liveData) apply) {
    apply(this);
    return this;
  }

  @override
  void close() {
    streamController.close();
    // streamController = null;
  }

  StreamSubscription<T>? subscribe(
    void Function(T event) onData, {
    void Function()? onDone,
    Function? onError,
    bool? cancelOnError,
  }) {
    return stream?.listen(
      onData,
      onError: onError,
      onDone: onDone,
      cancelOnError: cancelOnError,
    );
  }

  @override
  String toString() {
    // return 'LiveData{name: $name, initialValue: $initialValue, _currentValue: $_currentValue, _lifeCycleObserver: $_lifeCycleObserver, streamController: $streamController, logger: $logger, attachedItems: $attachedItems, apples: $apples}';
    return 'LiveData{$name, $_currentValue}';
  }
}

LiveData<C> attach<P, C>(
  LiveData<P> parent,
  C child, {
  String? name,
}) {
  return parent.attachedItems[child] = LiveData<C>(
    child,
    name: name ?? (parent.name != null ? '${parent.name}-child' : null),
  );
}

bool unAttach<P, C>(LiveData<P> parent, C child) {
  var len = parent.attachedItems.length;
  parent.attachedItems.removeWhere((key, value) => identical(key, child));
  return parent.attachedItems.length < len;
}

LiveData<C>? detach<P, C>(LiveData<P> parent, C child) {
  for (var item in parent.attachedItems.keys) {
    if (identical(item, child)) {
      return parent.attachedItems.containsKey(child) ? parent.attachedItems[child] : null;
    }
  }
  return null;
}

extension DetachLiveData<P, C> on LiveData<P> {
  LiveData<C>? detachedBy(C Function(LiveData<P> lv) detacher) {
    return detach<P, C>(this, detacher(this));
  }

  // O let<I, O>(I value, O Function(I value) runner) {
  //   return runner(value);
  // }

  C then<T>(C Function(LiveData<P> value) runner) {
    return runner(this);
  }
}

void Function(LiveData<List<T>> liveData) eachItemsInListAsLiveData<T>({
  void Function(LiveData<T> item)? then,
}) {
  return (LiveData<List<T>> liveData) {
    int i = 0;
    for (var element in liveData.value) {
      LiveData<T> lv = attach(
        liveData,
        element,
        name: '${liveData.name ?? ''}[$i]',
      );
      then?.call(lv);
      i++;
    }
  };
}
