import 'package:bloc_builder/index.dart';
import 'package:bloc_builder/widgets/for_bloc_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_live_data/index.dart';
import 'package:pubdev_playground/_pub/aves/component/logic.dart';
import 'package:pubdev_playground/_pub/aves/component/view.dart';
import 'package:pubdev_playground/config/di.dart';
import 'package:pubdev_playground/ui/widgets/blink.dart';

void main() {
  configureDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(key: key),
    );
  }
}

class Item {
  int id;
  String name;

  Item(this.id, this.name);

  @override
  String toString() {
    return 'Item{id: $id, name: $name}';
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key}) {
    // attach(items, items.value[0]);
  }

  int i = 0;

  late LiveData<List<Item>> items = LiveData(<Item>[
    Item(1, 'AAA'),
    Item(2, 'BBB'),
    Item(3, 'CCC'),
  ]).apply(eachItemsInListAsLiveData());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('test'),
      ),
      body: Container(
        child: $for(
          items,
          buildList: (_, items) {
            return Blink.on(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (_, int i) => items[i].widget,
              ),
            );
          },
          buildItem: (_, Item item, int index) {
            return Blink.on(child: Text('$item'));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // items.patch((list) {
          //   list[0].id = ++i;
          // });

          detach(items, items.value[0])!.patch((item) {
            item.id = ++i;
          });


          detach(items, items.value[1])!.patch((item) {
            item.id = ++i;
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
