import 'package:flutter/widgets.dart';

class BaseBLoCWidget<T> extends StatelessWidget {
  const BaseBLoCWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EmptyWidget(key: key);
  }

  operator |(BaseBLoCWidget<T> next) => next;
}

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container();
}
