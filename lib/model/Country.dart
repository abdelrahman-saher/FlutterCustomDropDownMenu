import 'package:flutter/material.dart';

class Country {
  final String id;
  final String name;
  Country({@required this.id, this.name});
  Map<String, dynamic> toDropDownItems() => {
        "name": name,
        "value": id,
      };
}
