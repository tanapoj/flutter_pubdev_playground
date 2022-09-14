import 'package:flutter/widgets.dart';
import 'package:pubdev_playground/_pub/flutter_bloc_builder/base_widget.dart';
import 'package:pubdev_playground/_pub/flutter_bloc_builder/index.dart';
import 'package:pubdev_playground/_pub/flutter_live_data/index.dart';
import 'package:pubdev_playground/ui/widgets/none.dart';

class LiveDataStateHolder<Data, Loading, Error> {
  final LiveData<Data> data;
  final LiveData<Loading> loading;
  final LiveData<Error> error;

  LiveDataStateHolder({
    required this.data,
    required this.loading,
    required this.error,
  });

// void dataState() {}
//
// void emptyDataState() {}
//
// void loadingState() {}
//
// void errorState() {}
//
// final LiveData<Data?> _data = LiveData<Data?>(null);
// final LiveData<Loading?> _loading = LiveData<Loading?>(null);
// final LiveData<Error?> _error = LiveData<Error?>(null);
//
// LiveData<Data?> get data$ => _data;
//
// set data(Data? data) {}
}

class BLoCWidget<T> extends BaseBLoCWidget<T> {
  final Widget Function(BuildContext context, {Key? key}) child;

  const BLoCWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return child(context, key: key);
  }
}

BaseBLoCWidget $state<Data, Loading, Error>(
  LiveDataStateHolder<Data, Loading, Error> state, {
  Key? key,
  required Widget Function(BuildContext context, Data data) child,
  required Widget Function(BuildContext context) onEmptyData,
  required Widget Function(BuildContext context, Loading loading) onLoading,
  required Widget Function(BuildContext context, Error error) onError,
}) {
  // return BaseBLoCWidget(key: key);
  return $guard(
        state.error,
        when: (error) => error != null,
        build: (context, Error? error) {
          return BLoCWidget(
            child: (context, {key}) {
              return onError(context, error!);
            },
          );
        },
      ) |
      $guard(
        state.loading,
        when: (loading) => loading != null,
        build: (context, Loading? loading) {
          return BLoCWidget(
            child: (context, {key}) {
              return onLoading(context, loading!);
            },
          );
        },
      ) |
      $guard(
        state.data,
        when: (data) => data != null,
        build: (context, Data? data) {
          return BLoCWidget(
            child: (context, {key}) {
              return onEmptyData(context);
            },
          );
        },
      ) |
      $watch(
        state.data,
        build: (context, Data? data) {
          return child(context, data!);
        },
      );
}
