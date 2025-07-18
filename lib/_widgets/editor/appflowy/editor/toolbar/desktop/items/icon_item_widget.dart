import 'package:flutter/material.dart';

import '../../../../appflowy_editor.dart';

class SVGIconItemWidget extends StatelessWidget {
  const SVGIconItemWidget({
    super.key,
    this.size = const Size.square(30.0),
    this.iconSize = const Size.square(18.0),
    this.iconName,
    this.iconBuilder,
    required this.isHighlight,
    required this.highlightColor,
    this.iconColor,
    this.onPressed,
  });

  final Size size;
  final Size iconSize;
  final String? iconName;
  final WidgetBuilder? iconBuilder;
  final bool isHighlight;
  final Color highlightColor;
  final Color? iconColor;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    Widget child = iconBuilder != null
        ? iconBuilder!(context)
        : EditorSvg(
            name: iconName,
            color: isHighlight ? highlightColor : iconColor,
            width: iconSize.width,
            height: iconSize.height,
          );
    if (onPressed != null) {
      child = MouseRegion(
        cursor: SystemMouseCursors.click,
        child: IconButton(
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          padding: EdgeInsets.zero,
          icon: child,
          iconSize: size.width,
          onPressed: onPressed,
        ),
      );
    }

    return SizedBox(
      width: size.width,
      height: size.height,
      child: child,
    );
  }
}
