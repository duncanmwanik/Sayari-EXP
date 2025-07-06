import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../_helpers/extentions/dynamic.dart';
import '../../_state/_providers.dart';
import '../../_theme/spacing.dart';
import '../../_theme/variables.dart';
import '../../_variables/constants.dart';
import '../buttons/planet.dart';
import '../others/icons.dart';

class DataInput extends StatefulWidget {
  const DataInput({
    super.key,
    this.controller,
    this.inputKey = itemTitle,
    this.parentKey = '',
    this.hintText = 'Untitled',
    this.autoFill,
    this.initialValue,
    this.focusNode,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTapOutside,
    this.onTap,
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.textCapitalization = TextCapitalization.none,
    this.inputFormatters,
    this.minLines = 1,
    this.maxLines,
    this.autofocus = false,
    this.enabled = true,
    this.filled = false,
    this.clean = false,
    this.showBorder = false,
    this.isPassword = false,
    this.notify = true,
    this.color,
    this.textColor,
    this.cursorColor,
    this.hoverColor,
    this.bgColor,
    this.weight = ft4,
    this.contentPadding,
    this.margin,
    this.fontSize = medium,
    this.radius = borderRadiusSmall,
    this.prefix,
    this.suffix,
  });

  final TextEditingController? controller;
  final String inputKey;
  final String parentKey;
  final String hintText;
  final String? autoFill;
  final String? initialValue;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function(PointerDownEvent)? onTapOutside;
  final Function()? onTap;
  final TextInputType keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final List<TextInputFormatter>? inputFormatters;
  final int minLines;
  final int? maxLines;
  final bool autofocus;
  final bool enabled;
  final bool filled;
  final bool clean;
  final bool showBorder;
  final bool isPassword;
  final bool notify;
  final Color? color;
  final Color? textColor;
  final Color? cursorColor;
  final Color? hoverColor;
  final String? bgColor;
  final FontWeight weight;
  final EdgeInsets? contentPadding;
  final EdgeInsets? margin;
  final double fontSize;
  final double radius;
  final Widget? prefix;
  final Widget? suffix;

  @override
  State<DataInput> createState() => _DataInputState();
}

class _DataInputState extends State<DataInput> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    bool showSuffix = widget.isPassword || widget.suffix != null;

    return Planet(
      enabled: widget.enabled,
      margin: widget.margin ?? noPadding,
      padding: widget.clean ? noPadding : widget.contentPadding ?? padC(showSuffix ? 'l12,r5,t5,b5' : 'l12,r12,t10,b10'),
      noStyling: widget.clean,
      color: widget.color ?? styler.appColor(0.1),
      showBorder: widget.showBorder && !widget.clean,
      borderWidth: 0.6,
      radius: widget.radius,
      hoverColor: widget.hoverColor ?? styler.appColor(0.1),
      child: TextFormField(
        mouseCursor: widget.enabled ? null : SystemMouseCursors.click,
        controller: widget.controller,
        validator: widget.validator,
        onChanged: widget.onChanged ??
            (widget.controller == null
                ? (value) {
                    state.input.update(
                      widget.inputKey,
                      parentKey: widget.parentKey,
                      value.trim(),
                      notify: widget.notify,
                    );
                  }
                : null),
        onFieldSubmitted: widget.onFieldSubmitted,
        onTapOutside: widget.onTapOutside,
        onTap: widget.onTap,
        obscureText: widget.isPassword && !showPassword,
        focusNode: widget.focusNode,
        enabled: widget.enabled,
        autofocus: widget.autofocus,
        initialValue: widget.controller == null
            ? widget.initialValue ??
                (widget.parentKey.isNotEmpty
                    ? state.input.item.data[widget.parentKey][widget.inputKey]
                    : state.input.item.data[widget.inputKey])
            : null,
        minLines: widget.minLines,
        maxLines: widget.maxLines,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        textCapitalization: widget.textCapitalization,
        autofillHints: widget.autoFill.ok() ? [widget.autoFill!] : null,
        inputFormatters: widget.inputFormatters,
        style: GoogleFonts.inter(
            fontSize: widget.fontSize, color: widget.textColor ?? styler.textColor(bgColor: widget.bgColor), fontWeight: widget.weight),
        textAlignVertical: TextAlignVertical.center,
        cursorColor: widget.cursorColor ?? styler.accent(),
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: GoogleFonts.inter(
              fontSize: widget.fontSize,
              color: widget.textColor ?? styler.textColor(faded: true, bgColor: widget.bgColor),
              fontWeight: widget.weight),
          errorStyle: GoogleFonts.inter(fontSize: small, color: red, fontWeight: ft6),
          // labelText: widget.hintText,
          // labelStyle: GoogleFonts.inter(
          //     fontSize: widget.fontSize,
          //     color: widget.textColor ?? styler.textColor(faded: true, bgColor: widget.bgColor),
          //     fontWeight: widget.weight),
          // floatingLabelStyle: GoogleFonts.inter(
          //     fontSize: small,
          //     color: widget.textColor ?? styler.textColor(faded: true, bgColor: widget.bgColor),
          //     fontWeight: widget.weight),
          isDense: true,
          filled: false,
          fillColor: transparent,
          focusColor: transparent,
          hoverColor: transparent,
          border: InputBorder.none,
          prefixIcon: widget.prefix,
          suffixIcon: widget.suffix ??
              (widget.isPassword
                  ? Planet(
                      onPressed: () => setState(() => showPassword = !showPassword),
                      noStyling: true,
                      isSquare: true,
                      radius: widget.radius - 1.5,
                      child: AppIcon(
                        showPassword ? Icons.visibility_rounded : Icons.visibility_off_rounded,
                        size: extra,
                        extraFaded: true,
                      ),
                    )
                  : null),
          suffixIconConstraints: const BoxConstraints(minHeight: 0, minWidth: 0),
        ),
      ),
    );
  }
}
