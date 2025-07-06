import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../_helpers/nav/navigation.dart';
import '../../_theme/helpers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/styler.dart';
import '../../_theme/variables.dart';
import '../_widgets.dart';
import '../menu/model.dart';

class Planet extends StatelessWidget {
  const Planet({
    super.key,
    this.enabled = true,
    this.onPressed,
    this.onDoublePress,
    this.onLongPress,
    this.onHover,
    this.onEnter,
    this.onExit,
    this.leading,
    this.content,
    this.trailing,
    this.child,
    this.iconSize = 18,
    this.textSize,
    this.gradient,
    this.boxShadow,
    this.borderRadius,
    this.borderSide,
    this.radius,
    this.blur,
    this.customBorder,
    this.color,
    this.hoverColor,
    this.textColor,
    this.borderColor,
    this.showBorder = false,
    this.isRound = false,
    this.isSquare = false,
    this.faded = false,
    this.margin,
    this.padding,
    this.slp = false,
    this.srp = false,
    this.svp = false,
    this.dryWidth = false,
    this.noStyling = false,
    this.expand = false,
    this.blurred = false,
    this.borderWidth,
    this.minWidth,
    this.minHeight,
    this.maxWidth,
    this.maxHeight,
    this.width,
    this.height,
    this.tooltip,
    this.tooltipDirection,
    this.menu,
    this.keepMenuPosition = false,
    this.mouseCursor,
  });

  final bool enabled;
  final Function()? onPressed;
  final Function()? onDoublePress;
  final Function()? onLongPress;
  final Function(bool value)? onHover;
  final Function(PointerEnterEvent _)? onEnter;
  final Function(PointerExitEvent _)? onExit;
  final dynamic leading;
  final dynamic content;
  final dynamic trailing;
  final Widget? child;
  final double iconSize;
  final double? textSize;
  final Color? color;
  final Color? hoverColor;
  final Color? textColor;
  final Gradient? gradient;
  final BoxShadow? boxShadow;
  final Color? borderColor;
  final BorderRadius? borderRadius;
  final BoxBorder? borderSide;
  final double? radius;
  final double? blur;
  final ShapeBorder? customBorder;
  final bool showBorder;
  final bool isRound;
  final bool isSquare;
  final bool faded;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final bool slp;
  final bool srp;
  final bool svp;
  final bool dryWidth;
  final bool noStyling;
  final bool expand;
  final bool blurred;
  final double? borderWidth;
  final double? minWidth;
  final double? minHeight;
  final double? maxWidth;
  final double? maxHeight;
  final double? width;
  final double? height;
  final String? tooltip;
  final AxisDirection? tooltipDirection;
  final Menu? menu;
  final bool keepMenuPosition;
  final MouseCursor? mouseCursor;

  @override
  Widget build(BuildContext context) {
    bool isMenu = onPressed == null && menu != null;
    Color color_ = noStyling ? transparent : color ?? (styler.appColor(isDark() ? 1 : 1.5));
    Color hoverColor_ = hoverColor ?? (isLight() ? AppColors.lightHover : AppColors.darkHover);

    Widget button = Material(
      color: transparent,
      shadowColor: transparent,
      surfaceTintColor: transparent,
      child: InkWell(
        onTap: !enabled ? null : (isMenu ? () {} : onPressed),
        onDoubleTap: !enabled ? null : (isMenu ? () {} : onDoublePress),
        onLongPress: !enabled ? null : onLongPress,
        onHover: !enabled ? null : onHover,
        onTapDown: !enabled
            ? null
            : isMenu
                ? (details) {
                    if (menu!.pop) popWhatsOnTop(); //pops popupmenu
                    showAppMenu(details.globalPosition, menu);
                  }
                : null,
        customBorder: customBorder,
        borderRadius: customBorder != null
            ? null
            : borderRadius ?? BorderRadius.circular(radius ?? (isRound ? borderRadiusCrazy : borderRadiusSmall)),
        hoverColor: hoverColor_,
        highlightColor: transparent,
        splashColor: transparent,
        mouseCursor: mouseCursor,
        child: MouseRegion(
          onEnter: onEnter,
          onExit: onExit,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: minHeight ?? 0,
              minWidth: minWidth ?? 0,
              maxWidth: maxWidth ?? double.infinity,
              maxHeight: maxHeight ?? double.infinity,
            ),
            child: Ink(
              height: height,
              width: width,
              decoration: BoxDecoration(
                color: color_,
                borderRadius: borderRadius ?? BorderRadius.circular(radius ?? (isRound ? borderRadiusCrazy : borderRadiusSmall)),
                border: borderSide ??
                    (showBorder
                        ? Border.all(
                            color: borderColor ?? styler.borderColor(),
                            width: borderWidth ?? (isDark() ? 0.6 : 0.4),
                          )
                        : null),
                boxShadow: boxShadow != null ? [boxShadow!] : null,
                gradient: gradient,
              ),
              padding: padding ??
                  (isRound || isSquare
                      ? padMS()
                      : EdgeInsets.only(
                          left: slp ? 7 : 12,
                          right: srp ? 7 : 12,
                          top: svp ? 3 : 5,
                          bottom: svp ? 3 : 5,
                        )),
              child: child ??
                  Row(
                    mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
                    mainAxisAlignment: expand ? MainAxisAlignment.start : MainAxisAlignment.center,
                    children: [
                      // leading
                      if (leading != null)
                        Padding(
                          padding: leading != null && content != null ? padM('r') : noPadding,
                          child: leading.runtimeType == String
                              ? AppText(leading, size: textSize, faded: faded, color: textColor)
                              : leading.runtimeType == IconData
                                  ? AppIcon(leading, size: iconSize, faded: faded, color: textColor)
                                  : leading,
                        ),
                      // content
                      if (content != null)
                        Flexible(
                          fit: expand ? FlexFit.tight : FlexFit.loose,
                          child: content.runtimeType == String
                              ? AppText(content, size: textSize, faded: faded, color: textColor)
                              : content.runtimeType == IconData
                                  ? AppIcon(content, size: iconSize, faded: faded, color: textColor)
                                  : content,
                        ),
                      if (expand) Spacer(),
                      // trailing
                      if (trailing != null)
                        Padding(
                          padding: trailing != null && content != null ? padM('l') : noPadding,
                          child: trailing.runtimeType == String
                              ? AppText(trailing, size: textSize, faded: faded, color: textColor)
                              : trailing.runtimeType == IconData
                                  ? AppIcon(trailing, size: iconSize, faded: faded, color: textColor)
                                  : trailing,
                        ),
                      //
                    ],
                  ),
            ),
          ),
        ),
      ),
    );

    return Padding(
      padding: margin ?? noPadding,
      child: AppTooltip(
        message: tooltip,
        axisDirection: tooltipDirection,
        child: dryWidth ? DryIntrinsicWidth(child: button) : button,
      ),
    );
  }
}
