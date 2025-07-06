import 'package:flutter/material.dart';
import '../../../../appflowy_editor.dart';

class BlockComponentContext {
  const BlockComponentContext(
    this.buildContext,
    this.node, {
    this.header,
    this.footer,
  });

  final BuildContext buildContext;
  final Node node;

  /// the header and the footer only work for root node.
  final Widget? header;
  final Widget? footer;
}
