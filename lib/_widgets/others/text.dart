import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:styled_text/styled_text.dart';

import '../../_theme/helpers.dart';
import '../../_theme/variables.dart';

class AppText extends StatelessWidget {
  const AppText(
    this.text, {
    super.key,
    this.size,
    this.weight,
    this.overflow,
    this.color,
    this.textAlign,
    this.decoration,
    this.padding,
    this.maxlines,
    this.mildFaded = false,
    this.faded = false,
    this.bold = false,
    this.extraFaded = false,
    this.isCrossed = false,
  });

  final double? size;
  final String text;
  final FontWeight? weight;
  final TextOverflow? overflow;
  final TextAlign? textAlign;
  final Color? color;
  final TextDecoration? decoration;
  final EdgeInsets? padding;
  final int? maxlines;
  final bool bold;
  final bool mildFaded;
  final bool faded;
  final bool extraFaded;
  final bool isCrossed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? noPadding,
      child: StyledText(
        text: text,
        textAlign: textAlign,
        overflow: overflow ?? TextOverflow.visible,
        maxLines: maxlines,
        style: GoogleFonts.inter(
          fontSize: size ?? 13,
          fontWeight: weight ?? (bold ? FontWeight.bold : (isDark() ? FontWeight.w400 : FontWeight.w500)),
          color: color ?? styler.textColor(mildFaded: mildFaded, faded: faded, extraFaded: extraFaded),
          decoration: decoration ?? (isCrossed ? TextDecoration.lineThrough : null),
          decorationColor: styler.textColor(faded: faded, extraFaded: extraFaded),
        ),
        tags: {
          'b': StyledTextTag(
            style: GoogleFonts.inter(
              fontSize: size ?? 13,
              fontWeight: FontWeight.w600,
              color: color ?? styler.textColor(faded: faded, extraFaded: extraFaded),
              decoration: decoration ?? (isCrossed ? TextDecoration.lineThrough : null),
              decorationColor: styler.textColor(faded: faded, extraFaded: extraFaded),
            ),
          ),
        },
      ),
    );
  }
}
