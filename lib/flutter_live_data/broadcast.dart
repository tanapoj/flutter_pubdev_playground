// import 'dart:async';
//
// import 'core.dart';
// import 'life_cycle.dart';
//
// /// Live Data Structure
// class LiveDataBroadcast<T> extends LiveData<T> {
//   LiveDataBroadcast(
//     T initValue, {
//     String? name,
//     StreamController<T>? streamController,
//     LifeCycleObserver? lifeCycleObserver,
//   }) : super(
//           initValue,
//           name: name,
//           streamController: StreamController<T>.broadcast(),
//           lifeCycleObserver: lifeCycleObserver,
//         );
// }
//
// extension LiveDataToBroadcast<T> on LiveData<T> {
//   LiveData<T> asBroadcast() {
//     var l = LiveDataBroadcast(
//       initialValue,
//       name: name,
//       lifeCycleObserver: lifeCycleObserver,
//       streamController: streamController,
//     );
//     l.attachedItems = attachedItems;
//     l.apples = apples;
//     return l;
//   }
// }
