import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pubdev_playground/example_guard_1.dart';
import 'package:pubdev_playground/example_list_1.dart';
import 'package:pubdev_playground/example_list_3.dart';
import 'package:pubdev_playground/example_list_2.dart';
import 'package:pubdev_playground/example_list_4.dart';
import 'package:pubdev_playground/example_watch_1.dart';
import 'package:pubdev_playground/example_when_1.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: const Text('\$watch'),
            trailing: const Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExampleWatch1Page(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('\$when'),
            trailing: const Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExampleWhen1Page(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('\$guard'),
            trailing: const Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExampleGuard1Page(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('\$for 1 basic'),
            trailing: const Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExampleList1Page(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('\$for 2 nested counter'),
            trailing: const Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExampleList2Page(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('\$for 3 nested object'),
            trailing: const Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExampleList3Page(),
                ),
              );
            },
          ),
          ListTile(
            title: const Text('\$for 4 animated list'),
            trailing: const Icon(Icons.keyboard_arrow_right_sharp),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ExampleList4Page(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

// //
// // === watch ======================================
// //
// $watch(intLv, build: (_, int value) {
//   return Text('B1: $value');
// }),
// intLv.build((_, int value) {
//   return Text('B1: $value');
// }),
// intLv.$((_, int value) {
//   return Text('B1: $value');
// }),
// //
// // === when ======================================
// //
// $when(intLv)
//   ..$case(
//         (int value) => value < 10,
//     build: (_, int value) {
//       return animateIt(Text('A1: $value'));
//     },
//   )..$case(
//       (int value) => value == 0,
//   build: (_, int value) {
//     return animateIt(Text('A2: $value'));
//   },
// ),
// $when(intLv) |
// $case(
//       (int value) => value < 10,
//   build: (_, int value) {
//     return animateIt(Text('A1: $value'));
//   },
// ) |
// $case(
//       (String value) => value == '',
//   build: (_, int value) {
//     return animateIt(Text('A2: $value'));
//   },
// ) |
// $case(
//       (int value) => value < 20,
//   build: (_, int value) {
//     return animateIt(Text('A2: $value'));
//   },
// ) |
// $else(
//   build: (_, int value) {
//     return animateIt(Text('A3: $value'));
//   },
// ),
// //
// // === guard ======================================
// //
// $guard(
//   intLv,
//   when: (int value) => value < 0,
//   build: (_, int value) {
//     return Text('C1: $value');
//   },
// ) |
// $guard(
//   stringLv,
//   when: (String value) => value == 'off',
//   build: (_, String value) {
//     return Text('C2: $value');
//   },
// ) |
// $watch(
//   intLv,
//   build: (_, int value) {
//     return Text('C3: $value');
//   },
// ),
// $guard.isNull(
//   nums,
//   build: (_, value) {
//     return const Text('D: test');
//   },
// ) |
// $guard.isEmpty(
//   nums,
//   build: (_, v) {
//     return Text('$v');
//   },
// ) |
// $guard(
//   nums,
//   when: $isEmptyFn(),
//   build: (_, value) {
//     return const Text('D: test');
//   },
// ) |
// $for(
//   nums,
//   buildItem: (_, int value, i) {
//     return Text('D: $value');
//   },
// ),
// //
// // === if ======================================
// //
// $if(
//   boolLv,
//   //(bool v) => v,
//   build: (_, value) {
//     return Text('E: $value');
//   },
// ) |
// $else(
//   build: (_, bool value) {
//     return Text('E: $value');
//   },
// ),
// //
// $if(
//   boolLv,
//   condition: (bool v) => v,
//   build: (_, value) {
//     return Text('E: $value');
//   },
// ) |
// $else(
//   build: (_, bool value) {
//     return Text('E: $value');
//   },
// ),
// $when(boolLv) |
// $true(
//   build: (_, value) {
//     return Text('F: $value');
//   },
// ) |
// $false(
//   build: (_, value) {
//     return Text('F: $value');
//   },
// ) |
// $else(
//   build: (_, bool value) {
//     return Text('F: $value');
//   },
// ),
// //
// // === for ======================================
// //
// $for(
//   countries,
// ),
// $for(
//   countries,
//   buildList: (_,
//       int itemCount,
//       Widget Function(BuildContext context, Country c, int index)
//       itemBuilder,) {
//     // return ListView(children: list);
//     return ListView.builder(
//       itemCount: itemCount,
//       itemBuilder: (context, i) =>
//           itemBuilder(context, countries.value[i], i),
//     );
//   },
//   buildItem: (_, Country value, i) {
//     return Text('$i $value');
//   },
// ),
// $for(
//   countries,
//   buildList: (_,
//       int itemCount,
//       Widget Function(BuildContext context, Country value, int index)
//       itemBuilder,) {
//     // return ListView(children: list);
//     return ListView.builder(
//       itemCount: itemCount,
//       itemBuilder: (context, i) =>
//           itemBuilder(context, countries.value[i], i),
//     );
//   },
//   buildItem: (_, Country value, i) {
//     return Column(
//       children: [
//         Text(value.name),
//         $for(
//           detach(countries, value.cities)!,
//           buildList: (_,
//               int itemCount,
//               Widget Function(
//                   BuildContext context, City value, int index)
//               itemBuilder,) {
//             // return ListView(children: list);
//             return ListView.builder(
//               itemCount: itemCount,
//               itemBuilder: (context, i) =>
//                   itemBuilder(context,
//                       detach(countries, value.cities)!.value[i], i),
//             );
//           },
//           buildItem: (_, City value, i) {
//             return Text('$value');
//           },
//         ),
//         detach(countries, value.cities)?.then((c) {
//           return $for(
//             c,
//           );
//         }),
//       ],
//     );
//   },
// ),
