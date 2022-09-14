import 'package:flutter/material.dart';
import 'package:pubdev_playground/app/index.dart';
import 'package:pubdev_playground/config/startup.dart';

class StartupPage extends StatefulWidget {
  const StartupPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StartupPage> createState() => _StartupPageState();

  factory StartupPage.builder() {
    return const StartupPage();
  }
}

class _StartupPageState extends State<StartupPage> {
  @override
  Widget build(BuildContext context) {
    startup(context).then((_) async {
      var provider = AppProvider.of(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => provider.navigator.home(),
        ),
      );
    });
    return Scaffold(
      backgroundColor: Colors.green,
      body: Builder(
        builder: (innerContext) {
          return const Center(
            child: Text('starting up..'),
          );
        },
      ),
    );
  }
}
