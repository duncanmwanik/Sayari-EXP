import 'package:flutter/material.dart';

import 'scroll.dart';

class AppScroll extends StatelessWidget {
  const AppScroll({
    super.key,
    required this.children,
    this.padding,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.scroll = true,
  });

  final List<Widget> children;
  final EdgeInsets? padding;
  final CrossAxisAlignment crossAxisAlignment;
  final bool scroll;

  @override
  Widget build(BuildContext context) {
    return NoScrollBars(
      child: SingleChildScrollView(
        padding: padding,
        clipBehavior: Clip.none,
        physics: scroll ? ClampingScrollPhysics() : NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: crossAxisAlignment,
          children: children,
        ),
      ),
    );
  }
}
