import 'package:flutter/widgets.dart';
import '../base_widget.dart';
import '../endpoint.dart';
import 'package:pubdev_playground/_pub/flutter_live_data/index.dart';

class ForBLoCWidget<T> extends BaseBLoCWidget {
  final LiveData<List<T>> liveData;
  final Widget Function(BuildContext context, List<Widget> widgets) listBuilder;
  final Widget Function(BuildContext context, T value, int index) itemBuilder;
  final Widget Function(BuildContext context, List<T> value) emptyBuilder;

  const ForBLoCWidget({
    Key? key,
    required this.liveData,
    required this.listBuilder,
    required this.itemBuilder,
    required this.emptyBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<T>>(
      key: key,
      stream: liveData.stream,
      initialData: liveData.initialValue,
      builder: (BuildContext context, AsyncSnapshot<List<T>> snapshot) {
        var value = liveData.value;
        // value ??= snapshot.data ?? liveData.initialValue;
        if (value.isEmpty) {
          return emptyBuilder(context, value);
        }
        var itemWidgets = value.asMap().entries.map((MapEntry entry) {
          int idx = entry.key;
          T item = entry.value;
          var itemLiveData = detach(liveData, item);
          if (itemLiveData != null) {
            return $watch<T>(itemLiveData, build: (_, value) {
              return itemBuilder(context, value, idx);
            });
          } else {
            return itemBuilder(context, item, idx);
          }
        }).toList();
        return listBuilder(context, itemWidgets);
      },
    );
  }

  @override
  operator |(BaseBLoCWidget next) => this;
}
