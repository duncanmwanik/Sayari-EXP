import 'package:flutter/material.dart';
import '../../../../appflowy_editor.dart';

Future<void> onPerformAction(
  TextInputAction action,
  EditorState editorState,
) async {
  AppFlowyEditorLog.input.debug('onPerformAction: $action');
}
