import 'core.dart';

abstract class LifeCycleObserver {
  void observeLiveData<T>(LiveData<T> liveData);
}

abstract class LifeCycleObservable {
  void close();
}
