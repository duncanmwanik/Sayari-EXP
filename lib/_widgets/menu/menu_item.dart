import 'package:flutter/material.dart';

import '../../_helpers/nav/navigation.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../buttons/planet.dart';
import '../others/divider.dart';
import '../others/icons.dart';
import '../others/text.dart';
import 'model.dart';

class MenuItem extends StatefulWidget {
  const MenuItem({
    super.key,
    required this.label,
    this.onTap,
    this.menu,
    this.menuWidth,
    this.leading,
    this.trailing,
    this.color,
    this.backgroundColor,
    this.trailingColor,
    this.hoverColor,
    this.labelSize,
    this.leadingSize,
    this.trailingSize,
    this.dyncamicLeading = false,
    this.sh = false,
    this.faded = false,
    this.isSelected = false,
    this.center = false,
    this.pop = true,
    this.popTrailing = false,
  });

  final String label;
  final dynamic leading;
  final Function()? onTap;
  final Menu? menu;
  final double? menuWidth;
  final IconData? trailing;
  final Color? color;
  final Color? backgroundColor;
  final Color? trailingColor;
  final Color? hoverColor;
  final double? labelSize;
  final double? leadingSize;
  final double? trailingSize;
  final bool sh;
  final bool dyncamicLeading;
  final bool faded;
  final bool isSelected;
  final bool center;
  final bool pop;
  final bool popTrailing;

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    if (widget.menu != null) {
      widget.menu?.pop = true;
    }

    return MouseRegion(
      onEnter: (event) => setState(() => isHovered = true),
      onExit: (event) => setState(() => isHovered = false),
      child: Planet(
        onPressed: widget.onTap != null
            ? () {
                if (widget.pop) popWhatsOnTop(); //pops popupmenu
                Future.delayed(const Duration(seconds: 0), widget.onTap); // Future.delayed prevents onTap not working
              }
            : null,
        width: widget.menuWidth,
        menu: widget.menu,
        padding: pad(
          l: 8,
          t: widget.sh ? 1 : 6,
          b: widget.sh ? 1 : 6,
          r: widget.trailing != null ? 8 : (widget.popTrailing ? 0 : 8),
        ),
        hoverColor: widget.hoverColor,
        color: widget.backgroundColor ?? transparent,
        child: Row(
          children: [
            // leading
            if (widget.leading != null)
              widget.dyncamicLeading
                  ? widget.leading
                  : AppIcon(
                      widget.leading,
                      size: widget.leadingSize ?? normal,
                      faded: true,
                      color: widget.isSelected ? styler.accent() : widget.color,
                    ),
            // text
            if (widget.leading != null) spw(),
            Expanded(
              child: AppText(
                widget.label,
                size: widget.labelSize,
                color: widget.isSelected ? styler.accent() : widget.color,
                faded: widget.faded,
                textAlign: widget.center ? TextAlign.center : null,
              ),
            ),
            // trailing
            if (widget.trailing != null || widget.popTrailing) spw(),
            if (widget.trailing != null)
              AppIcon(
                widget.trailing,
                size: widget.trailingSize ?? normal,
                faded: true,
                color: widget.isSelected ? styler.accent() : widget.color,
              ),
            // pop
            if (widget.popTrailing)
              Planet(
                onPressed: () => popWhatsOnTop(),
                padding: padS(),
                noStyling: true,
                isSquare: true,
                child: AppIcon(closeIcon, size: widget.trailingSize ?? extra, faded: true),
              ),
          ],
        ),
      ),
    );
  }
}

Widget menuDivider({Color? color}) => AppDivider(height: th(), color: color);
