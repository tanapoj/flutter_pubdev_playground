import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pubdev_playground/helper.dart';
import 'package:pubdev_playground/ui/widgets/blink.dart';
import 'package:pubdev_playground/_pub/flutter_bloc_builder/index.dart';
import 'package:pubdev_playground/_pub/flutter_live_data/index.dart';

class ExampleList1Page extends StatefulWidget {
  const ExampleList1Page({
    Key? key,
  }) : super(key: key);

  @override
  State<ExampleList1Page> createState() => _ExampleList1PageState();
}

class _ExampleList1PageState extends State<ExampleList1Page> {
  NameRunner runner = NameRunner('C');
  LiveData<List<String>> items;

  _ExampleList1PageState()
      : items = LiveData(<String>[
          'A',
          'B',
        ]).apply(eachItemsInListAsLiveData());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('\$for 1 Example'),
      ),
      body: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(20),
            child: const Text(
              'Items',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          $for(
            items,
            buildList: (_, items) {
              return Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (_, int i) => items[i].widget,
                ),
              );
            },
            buildItem: (_, String item, index) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Blink.on(
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: FloatingActionButton(
                onPressed: () {
                  items.value = [...items.value.sublist(0, items.value.length - 1)];
                },
                child: const Icon(Icons.remove),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                var newList = [...items.value, runner.next()];
                items.value = newList;
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    items.close();
    super.dispose();
  }
}
