import 'package:dropcity/country.dart';
import 'package:dropcity/draggable_text.dart';
import 'package:dropcity/drop_target.dart';
import 'package:flutter/material.dart';

class DragBox extends StatefulWidget {
  List<Country> items;

  DragBox(this.items);

  @override
  _DragBoxState createState() => new _DragBoxState();
}

class _DragBoxState extends State<DragBox> {
  Map<int, Country> pairs = {};

  bool validated = false;

  int score = 0;

  Widget getButton(String label, VoidCallback onPress) => new Padding(
      padding: new EdgeInsets.all(10.0),
      child: new SizedBox(
          width: 120.0,
          height: 42.0,
          child: new RaisedButton(child: new Text(label), onPressed: onPress)));

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return new SizedBox(
        width: size.width,
        height: size.height,
        child: new Stack(children: [
          new Positioned(
              right: 20.0,
              top: 40.0,
              child: new Row(mainAxisSize: MainAxisSize.min, children: [
                validated
                    ? new Text('Score : $score / ${widget.items.length}')
                    : getButton('Validate', onValidate),
                getButton('Clear', onClear),
              ])),
          new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                new ConstrainedBox(
                    constraints: new BoxConstraints(minHeight: 100.0),
                    child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: widget.items
                            .where((item) => !item.selected)
                            .map((item) => new DraggableCity(item))
                            .toList())),
                new NotificationListener<SelectionNotification>(
                    onNotification: onSelection,
                    child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: widget.items
                            .map((item) => new DropTarget(item,
                                selectedItem: pairs[item.id]))
                            .toList())),
              ])
        ]));
  }

  bool onSelection(SelectionNotification notif) {
    setState(() {
      // on de-selection
      if (notif.cancel) {
        if (notif.item != null) notif.item.selected = false;
        pairs.remove(notif.dropIndex);
      } else {
        // if target was associated with other country
        if (pairs[notif.dropIndex] != null)
          pairs[notif.dropIndex].selected = false;

        // if country was associated with other dropTarget
        if (pairs.containsValue(notif.item))
          pairs.remove(pairs.keys.firstWhere(
              (k) => pairs[k] == notif.item) );
        onItemSelection(notif.item, notif.dropIndex);
      }
    });
    return false;
  }

  void onItemSelection(Country selectedItem, int targetId) {
    setState(() {
      if (selectedItem != null) {
        selectedItem.selected = true;
        selectedItem.status = Status.none;
      }

      pairs[targetId] = selectedItem;
    });
  }

  void onValidate() {
    setState(() {
      score = 0;
      pairs.forEach((index, item) {
        if (item.id == index) {
          item.status = Status.correct;
          score++;
        } else
          item.status = Status.wrong;
      });
      validated = true;
    });
  }

  void onClear() {
    setState(() {
      pairs.forEach((index, item) {
        item.status = Status.none;
        item.selected = false;
      });
      pairs.clear();
      validated = false;
    });
  }
}
