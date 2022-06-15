import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:pubdev_playground/flutter_bloc_builder/base_bLoc_widget.dart';
import 'package:pubdev_playground/flutter_bloc_builder/endpoint.dart' as endpoint;
import 'package:pubdev_playground/flutter_live_data/core.dart';

// ignore: must_be_immutable
class WhenBLoCWidget<T> extends BaseBLoCWidget<T> {
  final LiveData<T> liveData;
  final List<CaseBLoCWidget<T>> cases = [];

  WhenBLoCWidget({
    Key? key,
    required this.liveData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      key: key,
      stream: liveData.stream,
      initialData: liveData.initialValue,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        var value = liveData.value ?? snapshot.data ?? liveData.initialValue;
        Widget Function(BuildContext context, T value)? caseMatchBuilder;
        print('when caseMatchBuilder :: cases=$cases');
        for (var c in cases) {
          var match = c.predicate(value);
          print('when :: value=$value, match=$match');
          if (match) {
            caseMatchBuilder = c.builder;
            break;
          }
        }
        caseMatchBuilder ??= (_, value) => EmptyWidget(key: key);
        return caseMatchBuilder(context, value);
      },
    );
  }

  @override
  operator |(BaseBLoCWidget<T> next) {
    if (next is! CaseBLoCWidget<T>) {
      throw ArgumentError('BLoC Widget in \$when block need to be followed by instance of CaseBLoCWidget, '
          'but got ${next.runtimeType}');
    }
    cases.add(next);
    return this;
  }

  void $case(
    bool Function(T value) predicate, {
    Key? key,
    required Widget Function(BuildContext context, T value) build,
  }) {
    cases.add(endpoint.$case(
      predicate,
      build: build,
    ));
  }

  void $else({
    Key? key,
    required Widget Function(BuildContext context, T value) build,
  }) {
    cases.add(endpoint.$case(
      (T _) => true,
      build: build,
    ));
  }
}

class CaseBLoCWidget<T> extends BaseBLoCWidget<T> {
  final bool Function(T value) predicate;
  final Widget Function(BuildContext context, T value) builder;

  const CaseBLoCWidget({
    Key? key,
    required this.predicate,
    required this.builder,
  }) : super(key: key);
}

// class WhenCaseElse<T> extends WhenCase<T> {
//   final Widget Function(BuildContext context, T value) builder;
//
//   WhenCaseElse({
//     Key? key,
//     required this.builder,
//   }) : super(
//     key: key,
//     predicate: (T value) => true,
//     builder: builder,
//   );
// }
