import 'package:flutter/material.dart';

class SizedCircle extends StatelessWidget {
  const SizedCircle({super.key, required this.child, required this.elevation, this.padding = const EdgeInsets.all(8.0)});

  final Widget child;
  final double elevation;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color.fromRGBO(255, 209, 143, 100),
      child: Padding(
        padding: padding,
        child: child,
        ),
      shape: CircleBorder(),
      elevation: elevation,
    );
  }
}