import 'package:flutter/material.dart';

class DragAvatarBorder extends StatelessWidget {

  final Color color;
  final double scale;
  final double opacity;
  final Widget child;

  DragAvatarBorder(this.child,
    {this.color, this.scale: 1.0, this.opacity: 1.0});

  @override
  Widget build(BuildContext context)  =>
    new Opacity(
      opacity: opacity,
      child: new Container(
        transform: new Matrix4.identity()..scale(scale),
        width: 100.0,
        height: 100.0,
        color: color ?? Colors.grey.shade400,
        child: new Center(child: child),
      ));
}