import 'package:flutter/material.dart';

class Item {
  Item(this.id,this.name,this.imagePath): color = Colors.primaries[id % Colors.primaries.length];
  final int id;
  final String name;
  final String imagePath;
  final Color color;
  final int price =42;
}

