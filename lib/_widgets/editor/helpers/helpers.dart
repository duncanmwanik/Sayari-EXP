import '../../../_helpers/common/global.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_variables/constants.dart';

void rebuildEditor() {
  globalBox.put(editorStateRebuild, getUniqueId());
}
