import 'package:flutter/material.dart';
import 'package:pubdev_playground/_pub/flutter_bloc_builder/endpoint.dart';
import 'package:pubdev_playground/_pub/flutter_live_data/live_data.dart';
import 'package:pubdev_playground/app/index.dart';

class MyBloc1Page extends ComponentLogic {
  @override
  String get name => 'mybloc1';

  late final LiveData<int> counter;

  MyBloc1Page({
    Key? key,
    required Widget Function(ComponentLogic) builder,
  }) : super(key: key, builder: builder) {
    counter = LiveData(0).owner(this);
  }

  @override
  onInit() {
    print('\x1B[32m[BlocComponent1]\x1B[0m :: onInit()');
    Future.delayed(const Duration(seconds: 1), () {
      counter.value = 1;
    });
  }

  @override
  onDispose() {
    print('\x1B[32m[BlocComponent1]\x1B[0m :: onDispose()');
  }

  @override
  onResume() {
    print('\x1B[32m[BlocComponent1]\x1B[0m :: onResume()');
  }

  @override
  onPause() {
    print('\x1B[32m[BlocComponent1]\x1B[0m :: onPause()');
  }

  increment() {
    print('counter.value++');
    counter.value++;
  }

  factory MyBloc1Page.create(String label) {
    return MyBloc1Page(
      builder: (bloc) => MyBlocView1(
        $bloc: bloc as MyBloc1Page,
        label: label,
      ),
    );
  }
}

class MyBlocView1 extends StatelessWidget {
  final MyBloc1Page $bloc;
  final String label;

  const MyBlocView1({
    Key? key,
    required this.$bloc,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BlocView1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label),
            $watch($bloc.counter, build: (_, count) {
              return Text(
                '$count',
                style: Theme.of(context).textTheme.headline4,
              );
            }),
            ElevatedButton(
              child: const Text('+1'),
              onPressed: () {
                $bloc.increment();
              },
            ),
            ElevatedButton(
              child: const Text('Next Page'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (c) => MyBloc1Page.create('Test 2'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
