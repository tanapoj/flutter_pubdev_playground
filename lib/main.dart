import 'package:flutter/material.dart';
import 'package:pubdev_playground/_pub/flutter_bloc_builder/index.dart';
import 'package:pubdev_playground/app/index.dart';
import 'package:pubdev_playground/config/lang/translations.g.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

// void main2() {
//   // var di = AppDi().withDefaultDependencies();
//   Environment env = Environment();
//
//   WidgetsFlutterBinding.ensureInitialized();
//   LocaleSettings.useDeviceLocale();
//
//   runApp(MainApplication(
//     env: env,
//   ));
// }
//
// class MainApplication extends StatelessWidget {
//   final Environment env;
//
//   const MainApplication({
//     Key? key,
//     required this.env,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return AppProvider(
//       env: env,
//       child: Builder(
//         builder: (BuildContext context) {
//           var provider = AppProvider.of(context);
//           provider.primaryInit();
//           return $watch(
//             provider.$state,
//             build: (context, value) {
//               return MaterialApp(
//                 title: provider.env.appName,
//                 theme: provider.ui.theme.themeData,
//                 home: provider.navigator.startup(),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
