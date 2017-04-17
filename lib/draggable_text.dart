import 'package:dropcity/country.dart';
import 'package:dropcity/draggable_view.dart';
import 'package:flutter/material.dart';

class DraggableCity extends StatefulWidget {
  Country item;

  bool enabled = true;
  DraggableCity(this.item);

  @override
  _DraggableCityState createState() => new _DraggableCityState();
}

class _DraggableCityState extends State<DraggableCity> {
  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: new EdgeInsets.all(10.0),
      child: new Draggable<Country>(
        onDraggableCanceled: (velocity, offset) {
          setState(() {
            widget.item.selected = false;
            widget.item.status = Status.none;
          });
        },
        childWhenDragging:
        new DragAvatarBorder(new Text(widget.item.city), color: Colors.grey[200]),
        child: new Container(
          width: 100.0,
          height: 100.0,
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
          color: Colors.cyan,
        )));
  }
}
