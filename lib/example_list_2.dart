import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pubdev_playground/example_list_1.dart';
import 'package:pubdev_playground/flutter_bloc_builder/endpoint.dart';
import 'package:pubdev_playground/flutter_live_data/core.dart';
import 'package:pubdev_playground/helper.dart';
import 'package:pubdev_playground/ui/components.dart';

class ExampleList2Page extends StatefulWidget {
  const ExampleList2Page({
    Key? key,
  }) : super(key: key);

  @override
  State<ExampleList2Page> createState() => _ExampleList2PageState();
}

class Counter {
  String? name;
  int count;

  Counter(this.count, {this.name}) {
    if (name == null) throw Exception('test');
  }

  @override
  String toString() {
    return 'Item($name: $count)';
  }
}

class _ExampleList2PageState extends State<ExampleList2Page> {
  NameRunner runner = NameRunner('C');
  LiveData<List<Counter>> items;

  _ExampleList2PageState()
      : items = LiveData([
          Counter(0, name: 'A'),
          Counter(0, name: 'B'),
        ]).apply(eachItemsInListAsLiveData(then: (liveData) {
          print(' eachItem.apples=${liveData.apples}');
        }));

  ButtonStyle btnLineStyle(Color bg) => ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(bg),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('\$for 2 Example'),
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
            buildList: (_, widgets) {
              return Expanded(
                child: ListView.builder(
                  itemCount: widgets.length,
                  itemBuilder: (_, int i) => widgets[i],
                ),
              );
            },
            buildItem: (_, Counter item, index) {
              return Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlinkContainer(
                      key: UniqueKey(),
                      child: Text('${item.name} ${item.count}'),
                    ),
                    Row(
                      children: [
                        ElevatedButton(
                          child: const Icon(Icons.add),
                          style: btnLineStyle(Colors.black12),
                          onPressed: () {
                            items.value[index].count = items.value[index].count + 1;
                          },
                        ),
                        ElevatedButton(
                          child: const Icon(Icons.add),
                          style: btnLineStyle(Colors.black12),
                          onPressed: () {
                            items.mutate((list) {
                              list[index].count++;
                            });
                          },
                        ),
                        ElevatedButton(
                          child: const Icon(Icons.add),
                          style: btnLineStyle(Colors.deepOrange),
                          onPressed: () {
                            var itemLiveData = detach(items, item);
                            itemLiveData?.transform((item) {
                              return Counter(
                                item.count + 1,
                                name: runner.next(),
                              );
                            });
                          },
                        ),
                        ElevatedButton(
                          child: const Icon(Icons.add),
                          style: btnLineStyle(Colors.green),
                          onPressed: () {
                            // var x = items.value[index];
                            // var itemModel = detach(items, x);
                            var itemLiveData = detach(items, item);
                            itemLiveData?.mutate((item) {
                              item.count++;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
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
                var newList = [
                  ...items.value,
                  Counter(
                    0,
                    name: runner.next(),
                  )
                ];
                items.value = newList;
              },
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}
