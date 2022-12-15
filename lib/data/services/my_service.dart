import 'package:pubdev_playground/_pub/aves/data/networks/network.dart' as network;
import 'package:pubdev_playground/_pub/aves/facade/index.dart';
import 'package:pubdev_playground/common/utils.dart';
import 'package:pubdev_playground/config/context.dart';
import 'package:pubdev_playground/data/network/my_api.dart';

class MyService {
  final MyNetworkApi api;

  MyService(this.api);

  Future<Result<TestModel2>> loadData1({FlowContext? ctx}) async {
    network.Response<TestModel1> response = await api.getData(ctx: ctx).call();
    if (response.ok) {
      var data = response.data;
    }else{
      var err = response.data;
    }
    // return Result.fromHttpResponse(response);
    return Result<TestModel2>();
  }

  Future<Result<TestModel2>> loadData2({FlowContext? ctx}) async {
    int x = 0;
    FlowContext.from(ctx).perform(Performable(
      when: (ctx) => (ctx.env?.isProduction ?? false) && (ctx.user?.isGuest ?? true),
      action: (ctx) {
        x = 1;
      },
    ));
    network.Response<TestModel1> response = await api.getData(ctx: ctx).call();
    // return Result.fromHttpResponse(response);

    return Result<TestModel2>();
  }
// Future<Result<TestModel2>> loadData() async {
//   NetworkApi api = NetworkApi();
//   Result<TestModel1> r1 = Result.fromHttpResponse(await api.getData());
//   Result<TestModel1> r2 = await Result.fromHttpResponseAsync(api.getData());
//   Result<TestModel2> r3 = Result<TestModel2>.inherit(r1).and(r2);
//   Result<TestModel2> r4 = Result<TestModel2>.inherits([r1, r2, r3]);
//   return r4;
// }
//
// Future<Result<TestModel2>> loadData2() async {
//   NetworkApi api = NetworkApi();
//   Result<TestModel2> result = Result<TestModel2>();
//   Response<TestModel1> res = await api.getData(flow: result.flow);
//   return result;
// }
}
