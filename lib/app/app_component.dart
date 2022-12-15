import 'package:flutter/material.dart';
import 'package:pubdev_playground/_pub/aves/common/log.dart';
import 'package:pubdev_playground/_pub/aves/architecture/context.dart';
import 'package:pubdev_playground/_pub/aves/index.dart';
import 'package:pubdev_playground/_pub/aves/component/logic.dart' as l;
import 'package:pubdev_playground/_pub/aves/component/view.dart' as v;
import 'package:pubdev_playground/config/context.dart';
import 'package:pubdev_playground/model/user.dart';
import 'package:pubdev_playground/ui/widgets/none.dart';
import 'index.dart';

abstract class ComponentLogic<T> extends l.Logic<T> {
  ComponentLogic({
    Key? key,
    required Widget Function(ComponentLogic) builder,
  }) : super(
          key: key,
          builder: (component) => builder(component as ComponentLogic),
        );

  @override
  construct() {
    super.construct();
    // subscribe(translator.$state, (locale) {
    //   rebuild();
    // });
  }

  AppNavigator get nav {
    if (context == null) {
      avesLog.e('context is null');
      throw Exception();
    }
    return App.of(context!).navigator;
  }

  AppTranslator get translator {
    if (context == null) {
      avesLog.e('context is null');
      throw Exception();
    }

    return App.of(context!).translator;
  }

  AppUi get ui {
    if (context == null) {
      avesLog.e('context is null');
      throw Exception();
    }
    return App.of(context!).ui;
  }

  AppAuth<User> get auth {
    if (context == null) {
      avesLog.e('context is null');
      throw Exception();
    }
    return App.of(context!).auth;
  }

  @override
  FlowContext get ctx => auth.user?.context ?? FlowContext();
}

abstract class View<BC extends ComponentLogic> extends v.View<BC> {
  const View(
    BC component, {
    Key? key,
  }) : super(component, key: key);

  AppNavigator get nav => logic.nav;

  AppTranslator get translator => logic.translator;

  AppUi get ui => logic.ui;

  AppAuth<User> get auth => logic.auth;
}

abstract class PageLogic extends ComponentLogic {
  PageLogic({
    Key? key,
    required Widget Function(PageLogic) builder,
  }) : super(
          key: key,
          builder: (ComponentLogic component) => builder(component as PageLogic),
        );
}

abstract class PageView<BC extends ComponentLogic> extends v.View<BC> {
  const PageView(
    BC component, {
    Key? key,
  }) : super(component, key: key);
}
