import 'package:collection/collection.dart';
import '../../../appflowy_editor.dart';

Node? getCellNode(Node tableNode, int col, int row) {
  return tableNode.children.firstWhereOrNull(
    (n) => n.attributes[TableCellBlockKeys.colPosition] == col && n.attributes[TableCellBlockKeys.rowPosition] == row,
  );
}
