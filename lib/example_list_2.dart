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
        ]).apply(eachItemsInListAsLiveData());

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
                    Blink.on(
                      child: Text('${item.name} ${item.count}'),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'x = x+1',
                              style: TextStyle(
                                color: Colors.black26,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          onTap: () {
                            items.value[index].count = items.value[index].count + 1;
                          },
                        ),
                        GestureDetector(
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'transform',
                              style: TextStyle(
                                color: Colors.redAccent,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          onTap: () {
                            var itemLiveData = detach(items, item);
                            itemLiveData?.transform((item) {
                              return Counter(
                                item.count + 1,
                                name: runner.next(),
                              );
                            });
                          },
                        ),
                        GestureDetector(
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'mutate',
                              style: TextStyle(
                                color: Colors.green,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          onTap: () {
                            items.mutate((list) {
                              list[index].count++;
                            });
                          },
                        ),
                        GestureDetector(
                          child: const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'detach',
                              style: TextStyle(
                                color: Colors.green,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          onTap: () {
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

  @override
  void dispose() {
    items.close();
    super.dispose();
  }
}
