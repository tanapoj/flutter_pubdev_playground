import 'package:bloc_builder/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_data/index.dart';
import 'package:pubdev_playground/_pub/aves/component/logic.dart';
import 'package:pubdev_playground/_pub/aves/component/view.dart';
import 'package:pubdev_playground/config/di.dart';

void main() {
  configureDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePageLogic.build(title: 'Test', initCount: 0),
    );
  }
}

class MyHomePageLogic extends Logic<MyHomePageLogic> {
  @override
  String get name => 'my-home-page';

  final int initCount;
  late final LiveData<int> $counter = LiveData(initCount).owner(this);

  MyHomePageLogic({
    super.key,
    required this.initCount,
    required super.builder,
  });

  factory MyHomePageLogic.build({
    Key? key,
    required String title,
    required int initCount,
  }) {
    return MyHomePageLogic(
      key: key,
      initCount: initCount,
      builder: (logic) => MyHomePageView(logic, title: title),
    );
  }

  incrementCounter() {
    $counter.value++;
  }
}

class MyHomePageView extends View<MyHomePageLogic> {
  final String title;

  const MyHomePageView(
    super.logic, {
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            $watch(logic.$counter, build: (_, int count) {
              return Text(
                '$count',
                style: Theme.of(context).textTheme.headlineMedium,
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: logic.incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
