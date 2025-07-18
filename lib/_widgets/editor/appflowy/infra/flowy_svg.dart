import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../appflowy_editor.dart';

class EditorSvg extends StatelessWidget {
  const EditorSvg({
    super.key,
    this.name,
    this.width,
    this.height,
    this.color,
    this.number,
    this.padding,
  });

  final String? name;
  final double? width;
  final double? height;
  final Color? color;
  final int? number;
  final EdgeInsets? padding;

  final _defaultWidth = 20.0;
  final _defaultHeight = 20.0;

  @override
  Widget build(BuildContext context) {
    final scaleFactor = context.read<EditorState?>()?.editorStyle.textScaleFactor ?? 1.0;
    final height = (this.height ?? _defaultHeight) * scaleFactor;
    final width = (this.width ?? _defaultWidth) * scaleFactor;
    return Padding(
      padding: padding ?? const EdgeInsets.all(0),
      child: _buildSvg(
        height,
        width,
      ),
    );
  }

  Widget _buildSvg(
    double height,
    double width,
  ) {
    if (name != null) {
      // here
      return SvgPicture.asset(
        'assets/editor/images/$name.svg',
        colorFilter: color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        fit: BoxFit.fill,
        height: height,
        width: width,
        // package: 'appflowy_editor',
      );
    } else if (number != null) {
      final numberText =
          '<svg width="200" height="200" xmlns="http://www.w3.org/2000/svg"><text x="30" y="150" fill="black" font-size="160">$number.</text></svg>';
      return SvgPicture.string(
        numberText,
        width: width,
        height: height,
      );
    }
    return Container();
  }
}
