import 'package:flutter/material.dart';

enum Status { none, correct, wrong }

class Country {
  final int id;
  final String city;
  final String country;
  bool selected = false;
  Status status;

  Country(this.id, this.city, this.country, {this.status: Status.none});

  @override
  String toString() {
    return 'Item{id: $id, city: $city, country: $country,'
      ' selected: $selected, status: $status}';
  }
}

Color getDropBorderColor(Status status) {
  Color c;
  switch (status) {
    case Status.none:
      c = Colors.grey[300];
      break;
    case Status.correct:
      c = Colors.lime[300];
      break;
    case Status.wrong:
      c = Colors.orange[300];
      break;
  }
  return c;
}