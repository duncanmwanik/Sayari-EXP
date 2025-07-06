import '../../../_helpers/debug/debug.dart';
import '../../../_services/activity/pending/pending_actions.dart';
import '../../../_services/cloud/sync.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../../_widgets/others/toast.dart';
import '../../user/_helpers/actions.dart';
import '../../user/_helpers/helpers.dart';
import 'common.dart';
import 'select.dart';

Future<void> deleteSpace(String spaceId) async {
  String spaceName = spaceNamesBox.get(spaceId, defaultValue: '');

  try {
    //  the default space should not be deleted
    if (isDefaultSpace(spaceId)) {
      toastInfo('Your default space cannot be deleted.');
    } else {
      await showConfirmationDialog(
        title: 'Delete space <b>$spaceName</b>?',
        yeslabel: 'Delete',
        content: 'You will lose all data. Members will lose the space when they open it the next time.',
        onAccept: () async {
          await sync.delete(space: spaceId);
          await removeSpaceForUser(liveUser(), spaceId);
          // unselect space if it was the app-wide selected space
          if (isLiveSpace(spaceId)) await updateSelectedSpace(defaultSpace());
        },
      );
    }
  } catch (e) {
    logError('deleteSpace', e);
    toastError('Could not delete space.');
    await addToPendingActions(db: spaces, space: spaceId, action: 'd', parent: 'user', value: {'spaceName': spaceName});
  }
}

Future<void> removeSpace(String spaceId) async {
  String spaceName = spaceNamesBox.get(spaceId, defaultValue: '');

  try {
    // Removes a space from non - space owners
    // Confirm for removal
    await showConfirmationDialog(
      title: 'Remove space <b>$spaceName</b>?',
      yeslabel: 'Remove',
      content: 'The space will be completely removed from all your devices.',
      onAccept: () async {
        // remove space from local and cloud user data
        await removeSpaceForUser(liveUser(), spaceId);
        // unselect space if it was the app-wide selectesd space
        await updateSelectedSpace(defaultSpace());
      },
    );
  } catch (e) {
    logError('removeSpace', e);
    toastError('Could not remove space');
  }
}

Future<void> removeMissingSpace({required String spaceId}) async {
  try {
    // If the space data from the cloud is missing, it has been deleted by it's owner
    // So we remove the space form all other users still having the space
    String spaceName = spaceNamesBox.get(spaceId, defaultValue: '');
    toastInfo('The space $spaceName is no longer available.');
    await removeSpaceForUser(liveUser(), spaceId);
    // unselect space if it was the app-wide selected space
    if (isLiveSpace(spaceId)) await updateSelectedSpace(noValue);
    //
  } catch (e) {
    logError('removeMissingSpace', e);
  }
}
