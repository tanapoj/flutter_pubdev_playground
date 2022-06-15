import 'package:flutter/widgets.dart';
import 'package:pubdev_playground/flutter_bloc_builder/base_bLoc_widget.dart';
import 'package:pubdev_playground/flutter_live_data/core.dart';

class WatchBLoCWidget<T> extends BaseBLoCWidget {
  final LiveData<T> liveData;
  final Widget Function(BuildContext context, T value) builder;

  const WatchBLoCWidget({
    Key? key,
    required this.liveData,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<T>(
      key: key,
      stream: liveData.stream,
      initialData: liveData.initialValue,
      builder: (BuildContext context, AsyncSnapshot<T> snapshot) {
        var value = liveData.value ?? snapshot.data ?? liveData.initialValue;
        return builder(context, value);
      },
    );
  }

  @override
  operator |(BaseBLoCWidget next) => this;
}
