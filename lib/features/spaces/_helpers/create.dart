import '../../../_helpers/common/global.dart';
import '../../../_helpers/debug/debug.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_services/cloud/sync.dart';
import '../../../_services/cloud/sync/validation.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_services/hive/load.dart';
import '../../../_services/hive/sync_to_local.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';
import '../../user/_helpers/actions.dart';
import '../../user/_helpers/helpers.dart';
import 'select.dart';

Future<void> createSpace({bool isDefault = false}) async {
  try {
    hideKeyboard();

    if (validateItemData(true)) {
      String userId = liveUser();
      String spaceId = '${userId.substring(0, 7)}${getUniqueId()}';
      String spaceName = isDefault ? defaultSpaceName : state.input.item.title();
      Map data = {
        info: {itemTitle: spaceName},
        members: {userId: superAdminPriviledge},
      };
      if (!isDefault) data[info] = state.input.item.data;

      await loadSpaceBoxes(spaceId);
      await syncToLocal(space: spaceId, action: 'c', parent: info, value: data[info]);
      await syncToLocal(space: spaceId, action: 'c', parent: members, value: data[members]);
      await sync.create(space: spaceId, value: data);
      await spaceNamesBox.put(spaceId, spaceName);
      await addSpaceToUserData(userId, spaceId, isDefault: isDefault);
      await selectNewSpace(spaceId);
      popWhatsOnTop();
    }
  } catch (e) {
    logError('createSpace', e);
  }
}
