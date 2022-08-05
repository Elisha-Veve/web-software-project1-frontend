import 'package:flutter/material.dart';
import './../utils/dimensions.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget desktop;
  final Widget mobile;

  const ResponsiveLayout(
      {Key? key, required this.desktop, required this.mobile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        return desktop;
      } else {
        return mobile;
      }
    });
  }
}
