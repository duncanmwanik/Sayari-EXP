import 'package:flutter/material.dart';

class Menu {
  Menu({
    this.offset,
    this.width,
    this.maxWidth,
    this.keepMenuPosition = false,
    this.pop = false,
    this.clean = false,
    required this.items,
  });

  Offset? offset;
  double? width;
  double? maxWidth;
  bool keepMenuPosition;
  bool pop;
  bool clean;
  List<Widget> items;

  bool isValid() => items.isNotEmpty;
}
