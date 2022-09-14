import 'package:flutter/material.dart';
import 'package:pubdev_playground/_pub/aves/data/networks/network.dart';
import 'package:pubdev_playground/_pub/flutter_live_data/live_data.dart';
import 'package:pubdev_playground/config/context.dart';
import 'package:pubdev_playground/app/index.dart';
import 'package:pubdev_playground/common/live_data.dart';
import 'package:pubdev_playground/common/utils.dart';
import 'package:pubdev_playground/data/networks/my_api.dart';
import 'package:pubdev_playground/data/services/my_service.dart';
import 'package:pubdev_playground/ui/pages/api_1/api_1.view.dart';
import 'package:pubdev_playground/ui/pages/my_bloc_1/my_bloc_1.view.dart';

class Api1Page extends PageLogic {
  @override
  String get name => 'api-1';

  late final LiveData<int> counter = LiveData(0).owner(this);
  late final LiveData<int> _loading = LiveData(0).owner(this);
  late final LiveData<int> _error = LiveData(0).owner(this);
  late final LiveDataStateHolder<int, int, int> state = LiveDataStateHolder(
    data: counter,
    loading: _loading,
    error: _error,
  );

  Api1Page({
    Key? key,
    required Widget Function(ComponentLogic) builder,
  }) : super(key: key, builder: builder);

  factory Api1Page.create(String label) {
    return Api1Page(
      builder: (component) => ApiView1Page(
        page: component as Api1Page,
        label: label,
      ),
    );
  }

  @override
  onInit() async {
    MyService service = MyService(MyNetworkApi());
    Result<TestModel2> result = await service.loadData1(ctx: ctx + Ctx(user: auth.user));
  }
}
