import 'package:bloc_builder/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pubdev_playground/_pub/aves/component/view.dart';

import 'mvvm.logic.dart';

class MvvmView extends View<MvvmLogic> {
  const MvvmView(
    super.logic, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          $watch(logic.$counter, build: (_, int count) {
            return Text('count is $count');
          }),
          ElevatedButton(
            child: const Text('count'),
            onPressed: () {
              logic.increment();
            },
          ),
        ],
      ),
    );
  }
}
