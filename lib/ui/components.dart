import 'package:flutter/material.dart';

class BlinkContainer extends StatefulWidget {
  const BlinkContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<BlinkContainer> createState() => BlinkContainerState();
}

class BlinkContainerState extends State<BlinkContainer> {
  double opacity = .0;

  BlinkContainerState() {
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
