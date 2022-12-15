import 'dart:async';

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
