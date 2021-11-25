import 'package:flutter/material.dart';

class Category {
  final String id;
  final String title;
  final Color color;

  const Category(
      {@required this.id,
      @required this.title,
      this.color = Colors
          .orange}); //i gave here a default value for colors in case there wasn't a color chosen
}
