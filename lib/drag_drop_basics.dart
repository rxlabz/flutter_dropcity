import 'package:flutter/material.dart';

void main() {
  runApp(new MaterialApp(home: new Scaffold(body: new DragBox())));
}

class DragBox extends StatefulWidget {
  @override
  _DragBoxState createState() => new _DragBoxState();
}

class _DragBoxState extends State<DragBox> {
  String selection;

  @override
  Widget build(BuildContext context) {
    return new Stack(children: [
      getTarget(),
      new DraggableText('A', new Offset(20.0, 60.0)),
      new DraggableText('B', new Offset(180.0, 60.0)),
    ]);
  }

  getTarget() => new Positioned(
    left: 40.0,
    bottom: 40.0,
    child: new DragTarget(
      builder: (BuildContext context, List<dynamic> accepted,
        List<dynamic> rejected) {
        final hovered = accepted.length > 0;
        return new Container(
          width: 200.0,
          height: 200.0,
          decoration: new BoxDecoration(
            color:
            hovered ? Colors.cyan.shade100 : Colors.grey.shade200,
            border: new Border.all(
              width: 2.0,
              color: hovered ? Colors.cyan : Colors.grey)),
          child: new Center(child: new Text(selection ?? 'Drop here')));
      },
      onWillAccept: (value) => selection == null,
      onAccept: (value) => setState(() {
        selection = value;
      })));
}

class DraggableText extends StatefulWidget {
  final Offset initialOffset;
  final String text;

  DraggableText(this.text, this.initialOffset);

  @override
  _DraggableTextState createState() => new _DraggableTextState();
}

class _DraggableTextState extends State<DraggableText> {
  Offset position = new Offset(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    position = widget.initialOffset;
  }

  @override
  Widget build(BuildContext context) {
    final item = new LabelBox(size: new Size.square(100.0), label: widget.text);
    final avatar = new LabelBox(
      size: new Size.square(150.0), label: widget.text, opacity: 0.4);
    final draggable = new Draggable(
      data: widget.text,
      feedback: avatar,
      child: item,
      childWhenDragging: new Opacity(opacity: 0.0, child: item),
      onDraggableCanceled: (velocity, offset) {
        print('_DragBoxState.build -> offset ${offset}');
        setState(() => position = offset);
      });
    return new Positioned(
      left: position.dx, top: position.dy, child: draggable);
  }
}

class LabelBox extends StatefulWidget {
  Offset position = new Offset(0.0, 0.0);
  final Size size;
  final String label;
  final double opacity;

  LabelBox({this.size, this.label, this.opacity: 1.0});

  @override
  State<StatefulWidget> createState() => new LabelBoxState();
}

class LabelBoxState extends State<LabelBox> {
  final defaultStyle = new TextStyle(
    color: Colors.white, decoration: TextDecoration.none, fontSize: 16.0);

  @override
  Widget build(BuildContext context) => new Container(
    width: widget.size.width,
    height: widget.size.height,
    color: Colors.cyan.withOpacity(widget.opacity),
    child: new Center(
      child: new Text(
        widget.label,
        style: defaultStyle,
      )),
  );
}
