import 'package:dropcity/dropcity/country.dart';
import 'package:dropcity/dropcity/dragbox.dart';
import 'package:flutter/material.dart';

final countries = [
  new Country(0, 'Paris', 'France'),
  new Country(1, 'Madrid', 'Spain'),
  new Country(2, 'Rome', 'Italy'),
  new Country(3, 'Portugal', 'Lisbonne')
];

void main() {
  runApp(new DropCityApp(countries));
}

class DropCityApp extends StatelessWidget {
  List<Country> items;

  DropCityApp(this.items);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: _getTheme(context), home: new Scaffold(body: new GameView(items)));
  }

  ThemeData _getTheme(BuildContext context) => Theme.of(context).copyWith(
      textTheme: new TextTheme(
          body1: new TextStyle(fontSize: 16.0, color: Colors.grey.shade700)));
}
