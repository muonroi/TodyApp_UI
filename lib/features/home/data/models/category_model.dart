import 'package:flutter/material.dart';

class Category {
  final String id;
  String name;
  Color? color;
  IconData? icon;

  Category({
    required this.id,
    required this.name,
    this.color = Colors.grey,
    this.icon = Icons.label,
  });
}
