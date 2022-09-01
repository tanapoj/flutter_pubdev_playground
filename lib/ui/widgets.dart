import 'package:flutter/material.dart';

class Blink extends StatefulWidget {
  const Blink({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  factory Blink.on({
    required Widget child,
  }) {
    return Blink(
      key: UniqueKey(),
      child: child,
    );
  }

  @override
  State<Blink> createState() => BlinkState();
}

class BlinkState extends State<Blink> {
  double opacity = .0;

  BlinkState() {
    opacity = 1.0;
    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        opacity = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        AnimatedOpacity(
          opacity: opacity,
          duration: const Duration(milliseconds: 400),
          child: Container(
            color: Colors.orangeAccent,
            child: widget.child,
          ),
        ),
      ],
    );
  }
}
