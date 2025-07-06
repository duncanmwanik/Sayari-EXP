import '../../../_helpers/common/global.dart';
import '../../../_helpers/debug/debug.dart';
import '../../../_helpers/forms/regex_checks.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_services/cloud/sync.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_services/hive/sync_to_local.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/others/toast.dart';
import '../../spaces/manager/_w/select_groups.dart';
import 'helpers.dart';

Future<void> addSpaceToGroup(String spaceId) async {
  try {
    state.temp.reset();

    await showSelectGroupsDialog();
    List groupIds = state.temp.tempList;

    if (groupIds.isNotEmpty) {
      for (String groupId in groupIds) {
        Map groupSpaces = userGroupsBox.get(groupId, defaultValue: {});
        groupSpaces[spaceId] = placeHolder;
        syncToLocal(space: liveUser(), action: 'c', parent: groups, id: groupId, value: groupSpaces);
        sync.create(db: users, space: liveUser(), parent: groups, id: groupId, key: spaceId, value: placeHolder);
      }
    }
  } catch (e) {
    logError('addSpaceToGroup', e);
  }
}

Future<void> removeSpaceFromGroup(String spaceId, String groupId) async {
  try {
    syncToLocal(space: liveUser(), action: 'd', parent: groups, id: groupId, key: spaceId);
    sync.delete(db: users, space: liveUser(), parent: groups, id: groupId, key: spaceId);
  } catch (e) {
    logError('removeSpaceFromGroup', e);
  }
}

Future<void> addSpaceToUserData(String userId, String spaceId, {bool isDefault = false}) async {
  try {
    syncToLocal(space: liveUser(), action: 'c', parent: spaces, id: spaceId, value: isDefault ? placeHolder1 : placeHolder);
    sync.create(db: users, space: userId, parent: spaces, id: spaceId, value: isDefault ? placeHolder1 : placeHolder);
    if (isDefault) sync.create(db: users, space: userId, parent: info, id: userDefaultSpace, value: spaceId);
    //
  } catch (e) {
    logError('addSpaceToUserData', e);
  }
}

Future<void> removeSpaceForUser(String userId, String spaceId) async {
  try {
    // remove space from all spaces folder
    if (userSpacesBox.containsKey(spaceId)) {
      userSpacesBox.delete(spaceId);
      sync.delete(db: users, space: userId, parent: spaces, id: spaceId);
    }

    // remove space from groups
    userGroupsBox.toMap().forEach((groupId, groupData) async {
      Map groupSpaces = groupData as Map;
      Map newSpaces = {...groupSpaces};

      if (groupSpaces.containsKey(spaceId)) {
        newSpaces.remove(spaceId);
        sync.delete(db: users, space: userId, parent: groups, id: groupId, key: spaceId);
      }
      syncToLocal(space: liveUser(), action: 'c', parent: groups, id: groupId, value: newSpaces);
    });
    //
  } catch (e) {
    logError('removeSpaceForUser', e);
  }
}

Future<void> createGroup(String groupName, {String? groupId}) async {
  try {
    if (groupName.isNotEmpty && isValidGroupName(groupName)) {
      hideKeyboard();
      popWhatsOnTop();
      String id = groupId ?? getUniqueId();
      syncToLocal(space: liveUser(), action: 'c', parent: groups, id: id, key: itemTitle, value: groupName);
      sync.create(db: users, space: liveUser(), parent: groups, id: id, key: itemTitle, value: groupName);
    } else {
      toastError('Enter a valid name');
    }
  } catch (e) {
    logError('createGroup', e);
  }
}

Future<void> deleteGroup(String groupId) async {
  try {
    syncToLocal(space: liveUser(), action: 'd', parent: groups, id: groupId);
    sync.delete(db: users, space: liveUser(), parent: groups, id: groupId);
  } catch (e) {
    logError('deleteGroup', e);
  }
}
