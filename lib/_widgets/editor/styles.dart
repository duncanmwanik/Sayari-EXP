import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../_theme/variables.dart';
import 'appflowy/appflowy_editor.dart';

EditorStyle customEditorStyle({required double scale, bool faded = false}) {
  double size = normal;

  return EditorStyle(
    textScaleFactor: scale,
    padding: noPadding,
    cursorColor: styler.accent(),
    selectionColor: styler.accent(6),
    dragHandleColor: styler.accent(),
    textStyleConfiguration: TextStyleConfiguration(
      lineHeight: 1.5 * scale * (scale != 1 ? 1.2 : 1),
      applyHeightToFirstAscent: true,
      applyHeightToLastDescent: true,
      text: TextStyle(fontSize: size, color: styler.textColor(faded: faded)),
      href: TextStyle(
        color: Colors.amber,
        decoration: TextDecoration.combine([TextDecoration.overline, TextDecoration.underline]),
      ),
      code: TextStyle(
        fontSize: size,
        color: styler.textColor(faded: faded),
        backgroundColor: styler.appColor(1),
      ),
    ),
    textSpanDecorator: (context, node, index, text, before, after) {
      final attributes = text.attributes;
      final href = attributes?[AppFlowyRichTextKeys.href];
      if (href != null) {
        return TextSpan(
          text: text.text,
          style: after.style,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              debugPrint('onTap: $href');
            },
        );
      }
      return after;
    },
  );
}

SelectionMenuStyle selectionMenuStyle = SelectionMenuStyle(
  selectionMenuBackgroundColor: styler.secondaryColor(),
  selectionMenuItemTextColor: styler.textColor(),
  selectionMenuItemIconColor: styler.textColor(),
  selectionMenuItemSelectedTextColor: styler.appColor(1),
  selectionMenuItemSelectedIconColor: styler.appColor(1),
  selectionMenuItemSelectedColor: styler.tertiaryColor(),
);
