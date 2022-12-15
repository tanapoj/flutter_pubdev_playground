import 'package:flutter/material.dart';
import 'package:pubdev_playground/common/log.dart';
import 'package:pubdev_playground/ui/widgets/blink.dart';
import 'package:bloc_builder/index.dart';
import 'package:flutter_live_data/index.dart';

class ExampleWatch1Page extends StatefulWidget {
  const ExampleWatch1Page({
    Key? key,
  }) : super(key: key);

  @override
  State<ExampleWatch1Page> createState() => _ExampleWatch1PageState();
}

class _ExampleWatch1PageState extends State<ExampleWatch1Page> {
  LiveData<int> counter = LiveData(0, name: 'counter-1');
  LiveData<int> counter2 = LiveData(0, name: 'counter-2');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('\$watch Example'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 100, 50, 100),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text('Counter is'),
              $watch(counter2, build: (_, int count) {
                return Blink.on(
                  child: Column(
                    children: [
                      Text(
                        '$count',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                      Text(
                        '${DateTime.now()}',
                      ),
                    ],
                  ),
                );
              }),
              ElevatedButton(
                onPressed: () {
                  counter.value = counter.value + 1;
                },
                child: Row(
                  children: const [
                    Icon(Icons.add),
                    Text('counter.value = counter.value + 1'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  counter.value++;
                },
                child: Row(
                  children: const [
                    Icon(Icons.add),
                    Text('counter.value++'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  counter.transform((val) => val + 1);
                },
                child: Row(
                  children: const [
                    Icon(Icons.add),
                    Text('counter.transform((val) => val + 1)'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  counter.patch((val) => val += 1);
                },
                child: Row(
                  children: const [
                    Icon(Icons.add),
                    Text('counter.mutate((val) => val += 1)'),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  counter.tick();
                },
                child: Row(
                  children: const [
                    Icon(Icons.adjust),
                    Text('counter.tick()'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void initState() {
    super.initState();

    counter.listen((value) {
      counter2.value = value * 10;
    });
  }

  @override
  void dispose() {
    counter.close();
    counter2.close();
    super.dispose();
  }
}
