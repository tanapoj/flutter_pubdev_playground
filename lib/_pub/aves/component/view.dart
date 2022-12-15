import 'package:flutter/foundation.dart';
import 'legacy/index.dart' as legacy;

abstract class View<BC extends legacy.ComponentLogic> extends legacy.ComponentView<BC> {
  const View(
    BC bloc, {
    Key? key,
  }) : super(bloc, key: key);
}
