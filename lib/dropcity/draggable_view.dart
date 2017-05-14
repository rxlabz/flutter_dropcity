import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class DragAvatarBorder extends StatelessWidget {

  final Color color;
  final double scale;
  final double opacity;
  final Widget child;
  final Size size;

  DragAvatarBorder(this.child,
    {this.color, this.scale: 1.0, this.opacity: 1.0, @required this.size});

  @override
  Widget build(BuildContext context)  =>
    new Opacity(
      opacity: opacity,
      child: new Container(
        transform: new Matrix4.identity()..scale(scale),
        width: size.width,
        height: size.height,
        color: color ?? Colors.grey.shade400,
        child: new Center(child: child),
      ));
}