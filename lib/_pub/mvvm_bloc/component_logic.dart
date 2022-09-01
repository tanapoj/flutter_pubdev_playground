import 'package:flutter/widgets.dart';
import 'package:pubdev_playground/_pub/flutter_live_data/index.dart';
import 'life_cycle_listener.dart';
import 'component_view.dart';

// ignore: must_be_immutable
class ComponentLogic extends StatefulWidget implements LifeCycleListener, LifeCycleOwner {
  final Widget Function(ComponentLogic) builder;
  final List<LiveData> _liveData = <LiveData>[];
  late Widget view;
  final BlocComponentDependencies dependencies = BlocComponentDependencies();
  bool isInitializingState = false;
  bool isCreatingState = false;
  void Function()? setRebuild;

  BuildContext? get context => dependencies.context;

  ComponentLogic({
    Key? key,
    required this.builder,
  }) : super(key: key) {
    view = builder(this);

    Future.delayed(const Duration(microseconds: 1), () {
      isCreatingState = true;
      onConstruct();
      isCreatingState = false;
    });
  }

  onConstruct() {}

  rebuild() {
    setRebuild?.call();
  }

  @override
  State<StatefulWidget> createState() => _ComponentLogicState();

  @override
  void observeLiveData<T>(LiveData<T> liveData) {
    _liveData.add(liveData);
  }

  void clearObserveLiveData() {
    for (var liveData in _liveData) {
      liveData.close();
    }
    _liveData.clear();
  }

  Widget bindView(Widget view) {
    return this.view = view;
  }

  // void bloComponentSelfInit() {}

  @override
  void onInit() {
    // TODO: implement onBuild
  }

  @override
  void onDispose() {
    // TODO: implement onBuild
  }

  @override
  void onPause() {
    // TODO: implement onPause
  }

  @override
  void onResume() {
    // TODO: implement onResume
  }

  // onReassemble() {
  //   appLog.i('==================================\n'
  //       'onReassemble'
  //       '==================================\n');
  //   onDispose();
  // }
}

class _ComponentLogicState extends State<ComponentLogic> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    widget.dependencies.context = context;
    Future.delayed(const Duration(microseconds: 1), () {
      widget.isInitializingState = true;
      WidgetsBinding.instance.addObserver(this);
      widget.onInit();
      // widget.bloComponentSelfInit();
      _asView(widget.view)?.onInit();
      widget.isInitializingState = false;
    });
  }

  @override
  void dispose() {
    widget.onDispose();
    widget.clearObserveLiveData();
    _asView(widget.view)?.onDispose();
    WidgetsBinding.instance.removeObserver(this);
    widget.setRebuild = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.dependencies.context = context;
    widget.setRebuild = rebuild;
    return widget.bindView(widget.builder(widget));
  }

  rebuild() {
    setState(() {});
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      widget.onResume();
      _asView(widget.view)?.onResume();
    } else if (state == AppLifecycleState.paused) {
      widget.onPause();
      _asView(widget.view)?.onPause();
    }
  }

// @override
// reassemble() {
//   super.reassemble();
//   if (widget.onReassemble != null) {
//     widget.onReassemble();
//   }
// }
}

ComponentView? _asView(Widget w) => w is ComponentView ? w : null;

class BlocComponentDependencies {
  BuildContext? context;
}
