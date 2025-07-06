import 'dart:math';

import 'package:flutter/material.dart';
import '../../../../../appflowy_editor.dart';

/// Page down key event.
///
/// - support
///   - desktop
///   - web
///
final CommandShortcutEvent pageDownCommand = CommandShortcutEvent(
  key: 'scroll one page down',
  getDescription: () => AppFlowyEditorL10n.current.cmdScrollPageDown,
  command: 'page down',
  handler: _pageUpCommandHandler,
);

CommandShortcutEventHandler _pageUpCommandHandler = (editorState) {
  final scrollService = editorState.service.scrollService;
  if (scrollService == null) {
    return KeyEventResult.ignored;
  }

  final scrollHeight = scrollService.onePageHeight;
  final dy = max(0, scrollService.dy);
  if (scrollHeight == null) {
    return KeyEventResult.ignored;
  }
  scrollService.scrollTo(
    dy + scrollHeight,
    duration: const Duration(milliseconds: 150),
  );
  return KeyEventResult.handled;
};
