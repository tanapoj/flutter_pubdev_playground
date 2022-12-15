import 'package:flutter/material.dart';
import 'package:flutter_live_data/live_data.dart';
import 'package:pubdev_playground/config/context.dart';
import 'package:pubdev_playground/app/index.dart';
import 'package:pubdev_playground/common/live_data.dart';
import 'package:pubdev_playground/common/utils.dart';
import 'package:pubdev_playground/data/network/my_api.dart';
import 'package:pubdev_playground/data/services/my_service.dart';
import 'package:pubdev_playground/ui/pages/tab_1/tab_1.view.dart';

class Tab1Page extends PageLogic {
  @override
  String get name => 'api-1';

  late final LiveData<int> $counter = LiveData(0).owner(this);
  late final LiveData<int> _$loading = LiveData(0).owner(this);
  late final LiveScene<int, int, int> $scene = LiveScene(
    data: $counter,
    loading: _$loading,
    error: LiveData(0).owner(this),
  );

  Tab1Page({
    Key? key,
    required Widget Function(ComponentLogic) builder,
  }) : super(key: key, builder: builder);

  factory Tab1Page.build() {
    return Tab1Page(
      builder: (component) => TabView1Page(page: component as Tab1Page),
    );
  }

  f() {
    $scene.data.value = 0;
  }

  @override
  onInit() async {
    MyService service = MyService(MyNetworkApi());
    Result<TestModel2> result = await service.loadData1(ctx: ctx + FlowContext(user: auth.user));
  }
}
