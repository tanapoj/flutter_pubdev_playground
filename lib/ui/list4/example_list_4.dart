import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pubdev_playground/helper.dart';
import 'package:pubdev_playground/ui/widgets.dart';
import 'package:pubdev_playground/_pub/flutter_bloc_builder/index.dart';
import 'package:pubdev_playground/_pub/flutter_live_data/index.dart';

class ExampleList4Page extends StatefulWidget {
  const ExampleList4Page({
    Key? key,
  }) : super(key: key);

  @override
  State<ExampleList4Page> createState() => _ExampleList4PageState();
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

class _ExampleList4PageState extends State<ExampleList4Page> {
  NameRunner runner = NameRunner('C');
  LiveData<List<Counter>> items;

  final GlobalKey<AnimatedListState> _animatedKey = GlobalKey();

  _ExampleList4PageState()
      : items = LiveData(<Counter>[
          Counter(0, name: 'A'),
          Counter(0, name: 'B'),
        ]).apply(eachItemsInListAsLiveData());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('\$for 4 Example'),
      ),
      body: $for(
        items,
        buildList: (_, items1) {
          return AnimatedList(
            key: _animatedKey,
            initialItemCount: items1.length,
            padding: const EdgeInsets.all(4),
            itemBuilder: (_, i, animation) {
              return SizeTransition(
                key: UniqueKey(),
                sizeFactor: animation,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Blink.on(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            items1[i].widget,
                            GestureDetector(
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'mutate()',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              onTap: () {
                                var lv = detach(items, items.value[i]);
                                lv?.mutate((counter) {
                                  counter.count++;
                                });
                              },
                            ),
                            GestureDetector(
                              child: const Padding(
                                padding: EdgeInsets.all(4.0),
                                child: Text(
                                  'transform()',
                                  style: TextStyle(
                                    color: Colors.redAccent,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
                              onTap: () {
                                var lv = detach(items, items.value[i]);
                                lv?.transform((counter) {
                                  return Counter(counter.count + 1, name: runner.next());
                                });
                              },
                            ),
                            // GestureDetector(
                            //   child: const Padding(
                            //     padding: EdgeInsets.all(4.0),
                            //     child: Text(
                            //       'unAttach-attach',
                            //       style: TextStyle(
                            //         color: Colors.blue,
                            //         decoration: TextDecoration.underline,
                            //       ),
                            //     ),
                            //   ),
                            //   onTap: () {
                            //     unAttach(items, items.value[i]);
                            //     items.value[i] = Counter(0, name: runner.next());
                            //     attach(items, items.value[i]);
                            //   },
                            // ),
                          ],
                        ),
                        Row(
                          children: [
                            ElevatedButton(
                              child: const Icon(Icons.remove),
                              onPressed: () {
                                items.value.removeAt(i);
                                items.tick();

                                _animatedKey.currentState!.removeItem(i, (_, animation) {
                                  return SizeTransition(
                                    sizeFactor: animation,
                                    child: const Card(
                                      margin: EdgeInsets.all(8),
                                      elevation: 10,
                                      color: Colors.redAccent,
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text("Deleted!", style: TextStyle(fontSize: 14)),
                                      ),
                                    ),
                                  );
                                }, duration: const Duration(milliseconds: 400));
                              },
                            ),
                            ElevatedButton(
                              child: const Icon(Icons.add),
                              onPressed: () {
                                items.value.insert(i, Counter(0, name: runner.next()));
                                items.tick();

                                _animatedKey.currentState!.insertItem(
                                  i,
                                  duration: const Duration(milliseconds: 200),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
        buildItem: (_, Counter item, index) {
          return Blink.on(
            child: Text('${item.name} = ${item.count}'),
          );
        },
      ),
      floatingActionButton: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              onPressed: () {
                var newList = [...items.value, Counter(0, name: runner.next())];
                items.value = newList;
                _animatedKey.currentState!.insertItem(
                  newList.length - 1,
                  duration: const Duration(milliseconds: 200),
                );
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
