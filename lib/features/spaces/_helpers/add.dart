import '../../../_helpers/common/internet.dart';
import '../../../_helpers/forms/regex_checks.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_services/cloud/_helpers/helpers.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_widgets/others/toast.dart';
import '../../user/_helpers/actions.dart';
import '../../user/_helpers/helpers.dart';

Future<void> addSpaceFromId(String spaceId) async {
  try {
    if (spaceId.isNotEmpty) {
      if (isValidSpaceId(spaceId)) {
        hideKeyboard();
        if (await isOffline()) return;

        if (!isSpaceAlreadyAdded(spaceId)) {
          await doesSpaceExist(spaceId).then((spaceName) async {
            if (spaceName.isNotEmpty) {
              await spaceNamesBox.put(spaceId, spaceName);
              await addSpaceToUserData(liveUser(), spaceId);
              popWhatsOnTop();
              toastSuccess('Added space $spaceName');
            } else {
              toastError('That space does not exist');
            }
          });
        } else {
          toastInfo('Space is already added');
        }
      } else {
        toastError('Enter a valid space id');
      }
    } else {
      toastError('Enter space id');
    }
  } catch (error) {
    toastError('Could not add space');
  }
}
