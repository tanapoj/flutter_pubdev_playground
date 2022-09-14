import 'package:flutter/material.dart';
import 'package:pubdev_playground/_pub/flutter_bloc_builder/index.dart';
import 'package:pubdev_playground/common/translate.dart';
import 'package:pubdev_playground/app/index.dart';
import 'package:pubdev_playground/ui/pages/live_data/guard1/example_guard_1.dart';
import 'package:pubdev_playground/ui/pages/live_data/list1/example_list_1.dart';
import 'package:pubdev_playground/ui/pages/live_data/list2/example_list_2.dart';
import 'package:pubdev_playground/ui/pages/live_data/list3/example_list_3.dart';
import 'package:pubdev_playground/ui/pages/live_data/list4/example_list_4.dart';
import 'package:pubdev_playground/ui/pages/live_data/watch1/example_watch_1.dart';
import 'package:pubdev_playground/ui/pages/live_data/when1/example_when_1.dart';
import 'package:pubdev_playground/ui/pages/my_bloc_1/my_bloc_1.logic.dart';
import 'package:pubdev_playground/ui/pages/my_bloc_2/my_bloc_2.logic.dart';
import 'package:pubdev_playground/ui/pages/setting/setting.logic.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();

  factory HomePage.builder() {
    return const HomePage();
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return $watch(AppProvider.of(context).translator.$state, build: (_, AppLocale locale) {
      return Scaffold(
        appBar: AppBar(
          title: Text(tt.home_page.title),
        ),
        body: Builder(builder: (innerContext) {
          return ListView(
            children: [
              // ElevatedButton(
              //   onPressed: () {
              //     // FrogColor.of(innerContext).color = Colors.redAccent;
              //   },
              //   child: const Text('test'),
              // ),
              ListTile(
                title: Text(
                  'Bloc Component 1 ${context == innerContext}',
                ),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MyBloc1Page.create('Test 1'),
                    ),
                  );
                },
              ),
              ListTile(
                title: const Text('Bloc Component 2'),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {
                  Navigator.push(
                    innerContext,
                    MaterialPageRoute(
                      builder: (context) => MyBloc2Page.builder('Test 2'),
                    ),
                  );
                },
              ),
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
              ListTile(
                title: Text(tt.home_page.menu_setting),
                trailing: const Icon(Icons.keyboard_arrow_right_sharp),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SettingPage.builder(),
                    ),
                  );
                },
              ),
            ],
          );
        }),
      );
    });
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
