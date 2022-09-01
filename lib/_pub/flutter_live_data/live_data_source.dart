import 'dart:async';
import 'live_data.dart';

class LiveDataSource<T> extends LiveData<T> {
  final DataSourceInterface dataSourceInterface;

  LiveDataSource(
    super.initValue, {
    required this.dataSourceInterface,
  }) {
    _init();
  }

  _init() async {
    T initValue = await dataSourceInterface.loadValue();
    value = initValue;
  }

  @override
  set value(T value) {
    setValueAsync(value);
  }

  setValueAsync(T value) async {
    bool hasChange = super.value != value;
    super.value = value;
    await dataSourceInterface.onValueUpdated(value, hasChange);
  }
}

abstract class DataSourceInterface<T> {
  Future<void> onValueUpdated(T value, bool hasChange);

  Future<T> loadValue();
}

DataSourceInterface<T> createDataSourceInterface<T>({
  required Future<T> Function() loadValueAction,
  required Future<void> Function(T value, bool hasChange) onValueUpdatedAction,
}) {
  return _DataSourceInterface<T>(
    loadValueAction: loadValueAction,
    onValueUpdatedAction: onValueUpdatedAction,
  );
}

class _DataSourceInterface<T> extends DataSourceInterface<T> {
  Future<T> Function() loadValueAction;
  Future<void> Function(T value, bool hasChange) onValueUpdatedAction;

  _DataSourceInterface({
    required this.loadValueAction,
    required this.onValueUpdatedAction,
  });

  @override
  Future<T> loadValue() async {
    return await loadValueAction();
  }

  @override
  Future<void> onValueUpdated(T value, bool hasChange) async {
    await onValueUpdatedAction(value, hasChange);
  }
}
