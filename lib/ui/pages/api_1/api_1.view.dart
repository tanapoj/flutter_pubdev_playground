import 'package:flutter/material.dart';
import 'package:bloc_builder/index.dart';
import 'package:pubdev_playground/common/live_data.dart';
import 'package:pubdev_playground/ui/pages/api_1/api_1.logic.dart';
import 'package:pubdev_playground/ui/pages/my_bloc_1/my_bloc_1.logic.dart';
import 'package:pubdev_playground/ui/widgets/none.dart';

class ApiView1Page extends StatelessWidget {
  final Api1Page page;
  final String label;

  const ApiView1Page({
    Key? key,
    required this.page,
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
            $watch(page.counter, build: (_, count) {
              return Text(
                '$count',
                style: Theme.of(context).textTheme.headline4,
              );
            }),
            ElevatedButton(
              child: const Text('+1'),
              onPressed: () {},
            ),
            ElevatedButton(
              child: const Text('Next Page'),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (c) => MyBloc1Page.build('Test 2'),
                  ),
                );
              },
            ),
            $scene(
              page.scene,
              child: (context, int? data) => None(),
              onEmptyData: (context) => None(),
              onLoading: (context, int? loading) => None(),
              onError: (context, int? error) => None(),
            ),
          ],
        ),
      ),
    );
  }
}
