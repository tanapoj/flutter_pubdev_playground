import 'package:flutter/widgets.dart';
import 'package:bloc_builder/base_widget.dart';
import 'package:bloc_builder/index.dart';
import 'package:flutter_live_data/index.dart';
import 'package:pubdev_playground/common/utils.dart';
import 'package:pubdev_playground/ui/widgets/none.dart';

class LiveScene<Data, Loading, Error> {
  final LiveData<Data?> data;
  final LiveData<Loading?> loading;
  final LiveData<Error?> error;

  LiveScene({
    required this.data,
    required this.loading,
    required this.error,
  }) {
    if (!isNullableType<Data>() || !isNullableType<Loading>() || !isNullableType<Error>()) {
      throw Exception('to use LiveDataSceneHolder: data, loading, and error must be nullable type');
    }
  }

  void setStateData(Data value) => {
        data.value = value,
        loading.value = null,
        error.value = null,
      };

  void setStateLoading(Loading value) => {
        data.value = null,
        loading.value = value,
        error.value = null,
      };

  void setStateError(Error value) => {
        data.value = null,
        loading.value = null,
        error.value = value,
      };
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

BaseBLoCWidget $scene<Data, Loading, Error>(
  LiveScene<Data, Loading, Error> state, {
  Key? key,
  required Widget Function(BuildContext context, Data data) child,
  required Widget Function(BuildContext context) onEmptyData,
  required Widget Function(BuildContext context, Loading loading) onLoading,
  required Widget Function(BuildContext context, Error error) onError,
}) {
  // return BaseBLoCWidget(key: key);
  return $guard.isNotNull(
        state.error,
        build: (context, Error? error) {
          return BLoCWidget(
            child: (context, {key}) {
              return onError(context, error!);
            },
          );
        },
      ) |
      $guard.isNotNull(
        state.loading,
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
        when: (data) => data == null || (data is List && data.isEmpty),
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
