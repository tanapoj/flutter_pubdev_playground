import 'package:flutter/material.dart';
import 'package:pubdev_playground/_pub/flutter_bloc_builder/index.dart';
import 'package:pubdev_playground/ui/pages/my_bloc_1/my_bloc_1.logic.dart';

class MyBlocView1 extends StatelessWidget {
  final MyBloc1Page $logic;
  final String label;

  const MyBlocView1({
    Key? key,
    required this.$logic,
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
            $watch($logic.counter, build: (_, count) {
              return Text(
                '$count',
                style: Theme.of(context).textTheme.headline4,
              );
            }),
            ElevatedButton(
              child: const Text('+1'),
              onPressed: () {
                $logic.increment();
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
