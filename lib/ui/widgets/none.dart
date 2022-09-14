import 'package:flutter/widgets.dart';

class None extends Widget {
  static None? _singleton;

  factory None({Key? key}) {
    _singleton ??= None._internal(key: key);
    return _singleton!;
  }

  const None._internal({Key? key}) : super(key: key);

  @override
  Element createElement() => _NoneElement(this);
}

class _NoneElement extends Element {
  _NoneElement(None widget) : super(widget);

  @override
  void mount(Element? parent, dynamic newSlot) {
    super.mount(parent, newSlot);
  }

  @override
  bool get debugDoingBuild => false;

  @override
  void performRebuild() {}
}
