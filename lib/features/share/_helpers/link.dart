import '../../../_helpers/common/global.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_services/cloud/realtime.dart';
import '../../../_services/cloud/sync.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/others/toast.dart';

Future<void> changeCustomLink(String newLink) async {
  isBusy(true);

  try {
    if (newLink.isNotEmpty) {
      String oldLink = state.input.item.customLink();

      if (oldLink != newLink) {
        // check if new link is available
        bool exists = await cloud.doesDataExist(db: shared, newLink);
        if (exists) {
          toastError('That link is already in use. Try another one.');
        } else {
          // delete old link
          if (oldLink.isNotEmpty) await sync.delete(db: shared, space: oldLink, log: false);
          // add new link
          await sync.create(db: shared, space: newLink, value: state.input.item.sharedLink(), log: false);
          // update input
          state.input.update(itemCustomLink, newLink);
          closeDialog();
        }
      } else {
        closeDialog();
      }
    } else {
      toastError("Link can't be empty.");
    }
  } catch (e) {
    toastError('Failed to change link.');
  }

  isBusy(false);
}
