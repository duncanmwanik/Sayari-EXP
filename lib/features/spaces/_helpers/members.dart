// ignore_for_file: dead_code

import '../../../_helpers/common/internet.dart';
import '../../../_helpers/debug/debug.dart';
import '../../../_helpers/forms/regex_checks.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_services/cloud/_helpers/helpers.dart';
import '../../../_services/cloud/realtime.dart';
import '../../../_services/cloud/sync.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_services/hive/store.dart';
import '../../../_services/hive/sync_to_local.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';
import '../../../_widgets/others/toast.dart';
import 'common.dart';

Future<void> addMemberToSpace(String email) async {
  try {
    if (!isValidEmail(email)) {
      toastError('Enter a valid email');
      return;
    }
    if (await isOffline()) return;
    hideKeyboard();

    // FIX

    await cloud.doesUserExist(email).then((userId) async {
      if (userId.isNotEmpty) {
        show(userId);
        return;
        String spaceId = liveSpace();

        await isAlreadyAdmin(spaceId, email).then((isAlreadyAdmin) async {
          if (!isAlreadyAdmin) {
            await sync.create(parent: members, id: userId, value: memberPriviledge);
            await syncToLocal(action: 'c', parent: members, id: userId, value: memberPriviledge);
            userEmailsBox.put(userId, email);
            closeDialog();
            toastSuccess('Added new member <b>$email</b>');
          } else {
            toastSuccess('User is already a member');
          }
        });
      } else {
        toastError('User does not exist');
      }
    });
  } catch (e) {
    logError('addMemberToSpace', e);
    toastError('Failed to add member');
  }
}

Future<void> removeMemberFromSpace(String userId, String userEmail) async {
  try {
    await showConfirmationDialog(
      title: 'Remove member <b>$userEmail</b>?',
      yeslabel: 'Remove',
      onAccept: () async {
        String spaceId = liveSpace();
        await isSpaceOwnerCloud(spaceId, userId).then((isOwner) async {
          if (!isOwner) {
            local('members', space: spaceId).delete(userId);
            await sync.delete(space: spaceId, parent: 'members', id: userId);
            toastSuccess('Removed member <b>$userEmail</b>');
          } else {
            toastInfo('Space owner cannot be removed.');
          }
        });
      },
    );
  } catch (e) {
    logError('remove-member', e);
    toastError('Could not remove member');
  }
}

Future<void> changeMemberPriviledge(String userId, int priviledge) async {
  try {
    await syncToLocal(action: 'c', parent: members, id: userId, value: priviledge);
    await sync.create(parent: members, id: userId, value: priviledge);
  } catch (e) {
    logError('changeMemberPriviledge', e);
  }
}

Future<void> getAdminEmail(String userId) async {
  try {
    String memberEmail = await getUserEmailFromCloud(userId);
    userEmailsBox.put(userId, memberEmail);
  } catch (e) {
    logError('getAdminEmail', e);
  }
}
