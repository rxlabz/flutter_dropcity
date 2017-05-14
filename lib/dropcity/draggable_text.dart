import 'package:dropcity/dropcity/country.dart';
import 'package:dropcity/dropcity/draggable_view.dart';
import 'package:flutter/material.dart';

class DraggableCity extends StatefulWidget {
  final Country item;
  final Size size;

  bool enabled = true;
  DraggableCity(this.item, {this.size});

  @override
  _DraggableCityState createState() => new _DraggableCityState();
}

class _DraggableCityState extends State<DraggableCity> {
  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: new EdgeInsets.all(4.0),
        child: new Draggable<Country>(
            onDraggableCanceled: (velocity, offset) {
              setState(() {
                widget.item.selected = false;
                widget.item.status = Status.none;
              });
            },
            childWhenDragging: new DragAvatarBorder(new Text(widget.item.city),
                color: Colors.grey[200], size: widget.size),
            child: new Container(
                width: widget.size.width,
                height: widget.size.height,
                color: widget.item.selected ? Colors.grey : Colors.cyan,
                child: new Center(
                  child: new Text(widget.item.city,
                      style: new TextStyle(color: Colors.white)),
                )),
            data: widget.item,
            feedback: new DragAvatarBorder(
              new Text(widget.item.city,
                  style: new TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      decoration: TextDecoration.none)),
              size: widget.size,
              color: Colors.cyan,
            )));
  }
}
