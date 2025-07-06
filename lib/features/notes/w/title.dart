import 'package:flutter/material.dart';

import '../../../_helpers/extentions/strings.dart';
import '../../../_helpers/ui/ui.dart';
import '../../../_models/item.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/editor/appflowy/appflowy_editor.dart';
import '../../../_widgets/forms/input.dart';

class NoteTitle extends StatelessWidget {
  const NoteTitle({super.key, required this.item});

  final Item item;

  @override
  Widget build(BuildContext context) {
    return DataInput(
      hintText: 'Title',
      initialValue: item.isNew ? null : item.title(),
      onChanged: (value) {
        state.input.update(itemTitle, value.trim(), notify: false);
        setWindowTitle((value.trim().isNotEmpty ? value : 'Untitled').cap());
      },
      onFieldSubmitted: (_) => state.editor.editorState.moveCursor(SelectionMoveDirection.backward),
      fontSize: 26,
      weight: FontWeight.bold,
      textCapitalization: TextCapitalization.sentences,
      clean: true,
      autofocus: item.isNew,
    );
  }
}
