import '../../../_services/hive/boxes.dart';
import '../../../_state/_providers.dart';
import '../../../_widgets/editor/appflowy/editor/editor.dart';
import '../../spaces/_helpers/common.dart';

void setItemCount(int length) => globalBox.put('${liveSpace()}_${state.views.docView}_itemCount', length);

int getItemCount() => globalBox.get('${liveSpace()}_${state.views.docView}_itemCount', defaultValue: 0);

String getEditorText() {
  final document = state.editor.editorState.document;
  final root = document.root;
  // not consider the nested nodes
  final plainText = root.children.fold('', (previousValue, node) {
    final delta = node.delta;
    if (delta != null) {
      return '$previousValue\n${delta.toPlainText()}';
    }
    // if you want to process the node without delta, you can use the following code
    // just an example here.
    if (node.type == DividerBlockKeys.type) {
      return '$previousValue\n---';
    }
    // ...
    return previousValue;
  });

  return plainText;
}
