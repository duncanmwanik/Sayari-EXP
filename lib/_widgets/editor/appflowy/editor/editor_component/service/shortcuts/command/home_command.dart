import 'package:flutter/material.dart';
import '../../../../../appflowy_editor.dart';

/// Home key event.
///
/// - support
///   - desktop
///   - web
///
final CommandShortcutEvent homeCommand = CommandShortcutEvent(
  key: 'scroll to the top of the document',
  getDescription: () => AppFlowyEditorL10n.current.cmdScrollToTop,
  command: 'ctrl+home',
  macOSCommand: 'home',
  handler: _homeCommandHandler,
);

CommandShortcutEventHandler _homeCommandHandler = (editorState) {
  final scrollService = editorState.service.scrollService;
  if (scrollService == null) {
    return KeyEventResult.ignored;
  }
  // scroll the document to the top
  scrollService.scrollTo(
    scrollService.minScrollExtent,
    duration: const Duration(milliseconds: 150),
  );
  return KeyEventResult.handled;
};
