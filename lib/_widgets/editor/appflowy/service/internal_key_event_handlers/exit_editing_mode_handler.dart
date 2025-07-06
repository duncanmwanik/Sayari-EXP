import 'package:flutter/material.dart';
import '../shortcut_event/shortcut_event_handler.dart';

ShortcutEventHandler exitEditingModeEventHandler = (editorState, event) {
  editorState.service.selectionService.clearSelection();
  return KeyEventResult.handled;
};
