import 'package:flutter/material.dart';
import 'package:pubdev_playground/ui/widgets.dart';
// import 'package:pubdev_playground/flutter_bloc_builder/endpoint.dart';
// import 'package:pubdev_playground/flutter_live_data/live_data.dart';
import 'package:bloc_builder/bloc_builder.dart';
import 'package:flutter_live_data/flutter_live_data.dart';

class ExampleWhen1Page extends StatefulWidget {
  const ExampleWhen1Page({
    Key? key,
  }) : super(key: key);

  @override
  State<ExampleWhen1Page> createState() => _ExampleWhen1PageState();
}

class _ExampleWhen1PageState extends State<ExampleWhen1Page> {
  LiveData<int> counter = LiveData(0);
  LiveData<bool> toggle = LiveData(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('\$when Example'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50, 100, 50, 100),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: [
                  const Text('Counter is '),
                  $watch(
                    counter,
                    build: (_, int count) {
                      return Blink(
                        key: UniqueKey(),
                        child: Text(
                          '$count',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                      );
                    },
                  ),
                ],
              ),
              $when(counter) |
                  $case(
                    (int value) => value % 2 == 0,
                    build: (_, int value) {
                      return Blink(
                        key: UniqueKey(),
                        child: Text('[case 1] $value is Even.'),
                      );
                    },
                  ) |
                  $else(
                    build: (_, int value) {
                      return Blink.on(
                        child: Text('[else] just $value'),
                      );
                    },
                  ),
              $when(counter)
                ..$case(
                  (int value) => value % 2 == 0,
                  build: (_, int value) {
                    return Blink(
                      key: UniqueKey(),
                      child: Text('[case 1] $value is Even.'),
                    );
                  },
                )
                ..$case(
                  (int value) => value % 5 == 0,
                  build: (_, int value) {
                    return Blink.on(
                      child: Text('[case 2] $value is multiply of 5'),
                    );
                  },
                )
                ..$else(
                  build: (_, int value) {
                    return Blink.on(
                      child: Text('[else] just $value'),
                    );
                  },
                ),
              $if(
                    counter,
                    condition: (int c) => c % 2 == 0,
                    build: (_, value) {
                      return Blink.on(
                        child: Text('[if] $value is Even.'),
                      );
                    },
                  ) |
                  $else(
                    build: (_, value) {
                      return Blink.on(
                        child: Text('[else] $value is Odd.'),
                      );
                    },
                  ),
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
              const Divider(color: Colors.black),
              $when(toggle) |
                  $true(build: (_, value) {
                    return Blink.on(
                      child: Column(
                        children: const [
                          Text(
                            '\\',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          Text('[true]'),
                        ],
                      ),
                    );
                  }) |
                  $false(build: (_, value) {
                    return Blink.on(
                      child: Column(
                        children: const [
                          Text(
                            '/',
                            style: TextStyle(
                              fontSize: 24,
                            ),
                          ),
                          Text('[false]'),
                        ],
                      ),
                    );
                  }),
              ElevatedButton(
                onPressed: () {
                  toggle.value = !toggle.value;
                },
                child: Row(
                  children: const [
                    Icon(Icons.add),
                    Text('toggle.value = !toggle.value'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    counter.close();
    toggle.close();
    super.dispose();
  }
}
