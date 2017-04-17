import 'package:dropcity/country.dart';
import 'package:dropcity/dragbox.dart';
import 'package:flutter/material.dart';

final countries = [
  new Country(0, 'Paris', 'France'),
  new Country(1, 'Madrid', 'Spain'),
  new Country(2, 'Rome', 'Italy')
];

void main() {
  runApp(new DropCityApp(countries));
}

class DropCityApp extends StatelessWidget {
  List<Country> items;

  DropCityApp(this.items);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(home: new Scaffold(body: new DragBox(items)));
  }
}
