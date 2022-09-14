import 'package:flutter/material.dart';
import 'package:pubdev_playground/_pub/aves/common/log.dart';
import 'package:pubdev_playground/_pub/aves/context.dart';
import 'package:pubdev_playground/_pub/aves/index.dart';
import 'package:pubdev_playground/_pub/aves/component.dart' as aves;
import 'package:pubdev_playground/config/context.dart';
import 'package:pubdev_playground/ui/widgets/none.dart';
import 'index.dart';

abstract class ComponentLogic extends aves.ComponentLogic {
  ComponentLogic({
    Key? key,
    required Widget Function(ComponentLogic) builder,
  }) : super(
          key: key,
          builder: (aves.ComponentLogic component) => builder(component as ComponentLogic),
        );

  @override
  construct() {
    super.construct();
    subscribe(translator.$state, (locale) {
      rebuild();
    });
  }

  AppNavigator get nav {
    if (context == null) {
      avesLog.e('context is null');
      throw Exception();
    }
    return AppProvider.of(context!).navigator;
  }

  AppTranslator get translator {
    if (context == null) {
      avesLog.e('context is null');
      throw Exception();
    }

    return AppProvider.of(context!).translator;
  }

  AppUi get ui {
    if (context == null) {
      avesLog.e('context is null');
      throw Exception();
    }
    return AppProvider.of(context!).ui;
  }

  AppAuth get auth {
    if (context == null) {
      avesLog.e('context is null');
      throw Exception();
    }
    return AppProvider.of(context!).auth;
  }

  @override
  Ctx get ctx => auth.user?.ctx ?? Ctx();
}

abstract class ComponentView<BC extends ComponentLogic> extends aves.ComponentView<BC> {
  const ComponentView(
    BC component, {
    Key? key,
  }) : super(component, key: key);

  AppNavigator get nav => logic.nav;

  AppTranslator get translator => logic.translator;

  AppUi get ui => logic.ui;

  AppAuth get auth => logic.auth;
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

abstract class PageView<BC extends ComponentLogic> extends ComponentView<BC> {
  const PageView(
    BC component, {
    Key? key,
  }) : super(component, key: key);
}
