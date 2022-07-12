import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pubdev_playground/ui/components.dart';
// import 'package:pubdev_playground/flutter_bloc_builder/endpoint.dart';
// import 'package:pubdev_playground/flutter_live_data/core.dart';
import 'package:bloc_builder/bloc_builder.dart';
import 'package:flutter_live_data/flutter_live_data.dart';

class ExampleGuard1Page extends StatefulWidget {
  const ExampleGuard1Page({
    Key? key,
  }) : super(key: key);

  @override
  State<ExampleGuard1Page> createState() => _ExampleGuard1PageState();
}

class _ExampleGuard1PageState extends State<ExampleGuard1Page> {
  LiveData<int> counter = LiveData(0);
  LiveData<bool> loading = LiveData(false);
  LiveData<String?> errorMessage = LiveData(null);

  void loadNewCounter() {
    loading.value = true;
    errorMessage.value = null;
    Future.delayed(Duration(milliseconds: 1000), () {
      bool fail = Random().nextInt(3) == 1;
      if (fail) {
        errorMessage.value = 'Cannot load new count';
      } else {
        counter.value = counter.value + 1;
      }
      loading.value = false;
    });
  }

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
              $guard(
                    loading,
                    when: (loading) => loading == true,
                    build: (_, loading) {
                      return Text(
                        'Loading...',
                        style: Theme.of(context).textTheme.headline4,
                      );
                    },
                  ) |
                  $guard.isNotNull(
                    errorMessage,
                    build: (_, msg) {
                      return Text(
                        'Error: $msg',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 24,
                        ),
                      );
                    },
                  ) |
                  $watch(counter, build: (_, int count) {
                    return Blink.on(
                      child: Text(
                        '$count',
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    );
                  }),
              $when(loading) |
                  $true(build: (_, loading) {
                    return ElevatedButton(
                      onPressed: null,
                      child: Row(
                        children: const [
                          Icon(Icons.add),
                          Text('loading...'),
                        ],
                      ),
                    );
                  }) |
                  $false(build: (_, loading) {
                    return ElevatedButton(
                      onPressed: () {
                        loadNewCounter();
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.add),
                          Text('load new counter'),
                        ],
                      ),
                    );
                  }),
              $watch(counter, build: (_, int count) {
                return Blink.on(
                  child: Text(
                    '[watch] counter is $count',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.black26,
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void dispose() {
    counter.close();
    loading.close();
    errorMessage.close();
    super.dispose();
  }
}
