import 'package:flutter/material.dart';
import '../../../../appflowy_editor.dart';

class RemoteSelection {
  const RemoteSelection({
    required this.id,
    required this.selection,
    required this.selectionColor,
    required this.cursorColor,
    this.builder,
  });

  final String id;
  final Selection selection;
  final Color selectionColor;
  final Color cursorColor;
  final Widget Function(
    BuildContext context,
    RemoteSelection selection,
    Rect rect,
  )? builder;
}
