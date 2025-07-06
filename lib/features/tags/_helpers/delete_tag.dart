import '../../../_helpers/debug/debug.dart';
import '../../../_services/cloud/sync/quick_edit.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/features.dart';
import 'helpers.dart';

Future<void> deleteTag(String tagId) async {
  try {
    if (isSelectedTag(tagId)) state.views.updateSelectedTag('All');
    await quickEdit(parent: features.tags, action: 'd', id: tagId);
  } catch (e) {
    logError('deleteTag', e);
  }
}
