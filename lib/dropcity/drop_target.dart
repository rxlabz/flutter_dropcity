import 'package:dropcity/dropcity/country.dart';
import 'package:dropcity/dropcity/draggable_view.dart';
import 'package:flutter/material.dart';

typedef void DropItemSelector(Country item, DropTarget target);

class SelectionNotification extends Notification {
  final int dropIndex;
  final Country item;
  final bool cancel;

  SelectionNotification(this.dropIndex, this.item, {this.cancel: false});
}

class DropTarget extends StatefulWidget {
  final Country item;
  Country _selection;

  Country get selection => _selection;

  get id => item.id;

  set selection(Country value) {
    clearSelection();
    _selection = value;
  }

  DropTarget(this.item, {Country selectedItem}) {
    _selection = selectedItem;
  }
  @override
  _DropTargetState createState() => new _DropTargetState();

  void clearSelection() {
    if (_selection != null) _selection.selected = false;
  }
}

class _DropTargetState extends State<DropTarget> {
  static const double kFingerSize = 50.0;

  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: new EdgeInsets.all(10.0),
        child:
            widget.selection != null ? addDraggable(getTarget()) : getTarget());
  }

  Widget addDraggable(DragTarget target) => new Draggable(
      data: widget.selection,
      dragAnchor: DragAnchor.pointer,
      onDraggableCanceled: onDragCancelled,
      feedback: getCenteredAvatar(),
      child: target);

  DragTarget getTarget() => new DragTarget<Country>(
      onWillAccept: (item) => widget.selection != item,
      onAccept: (value) {
        new SelectionNotification(widget.item.id, value).dispatch(context);
      },
      builder: (BuildContext context, List<Country> accepted,
          List<dynamic> rejected) {
        return new SizedBox(
            child: new Container(
                width: 200.0,
                height: 200.0,
                decoration: new BoxDecoration(
                    backgroundColor: accepted.isEmpty
                        ? (widget.selection != null
                            ? getDropBorderColor(widget.selection.status)
                            : Colors.grey[300])
                        : Colors.cyan[100],
                    border: new Border.all(
                        width: 2.0,
                        color:
                            accepted.isEmpty ? Colors.grey : Colors.cyan[300])),
                child: widget.selection != null
                    ? new Column(children: [
                        new Padding(
                            padding: new EdgeInsets.symmetric(vertical: 16.0),
                            child: new Text(widget.item.country)),
                        new Center(
                            child: new SizedBox(
                                width: 100.0,
                                height: 100.0,
                                child: new Material(
                                    elevation: 1,
                                    child: new Center(
                                      child: new Text(
                                        widget.selection.city,
                                      ),
                                    )))),
                      ])
                    : new Center(child: new Text(widget.item.country))));
      });

  void onDragCancelled(Velocity velocity, Offset offset) {
    setState(() {
      widget.selection = null;
      new SelectionNotification(widget.item.id, widget.selection, cancel: true)
          .dispatch(context);
    });
  }

  Widget getCenteredAvatar() => new Transform(
      transform: new Matrix4.identity()
        ..translate(-100.0 / 2.0, -(100.0 / 2.0)),
      child: new DragAvatarBorder(
        new Text(widget.selection?.city,
            style: new TextStyle(
                fontSize: 16.0,
                color: Colors.white,
                decoration: TextDecoration.none)),
        color: Colors.cyan,
      ));
}
