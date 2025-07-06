import '../../_helpers/common/helpers.dart';
import '../../_helpers/common/internet.dart';
import '../../_helpers/debug/debug.dart';
import '../../_variables/constants.dart';
import '../../features/spaces/_helpers/names.dart';
import '../../features/user/_helpers/helpers.dart';
import '../hive/boxes.dart';
import 'realtime.dart';

Future<void> getAllUserDataFromCloud(String userId) async {
  showSyncingLoader(true);

  if (await isOffline()) {
    showSyncingLoader(false);
    return;
  }

  try {
    // spaces
    await cloud.getData(db: users, '$userId/$spaces').then((snapshot) async {
      Map userData = snapshot.value != null ? snapshot.value as Map : {};
      if (userData.isNotEmpty) {
        await userSpacesBox.clear();
        await userSpacesBox.putAll(userData);
        await saveSpacesNamesToLocalStorage(userData);
      }
    });
    // groups
    await cloud.getData(db: users, '$userId/$groups').then((snapshot) async {
      Map groupData = snapshot.value != null ? snapshot.value as Map : {};
      if (groupData.isNotEmpty) {
        await userGroupsBox.clear();
        await userGroupsBox.putAll(groupData);
        await saveSpacesNamesToLocalStorage(groupData);
      }
    });
    // settings
    await cloud.getData(db: users, '$userId/$settings').then((snapshot) async {
      Map settingsData = snapshot.value != null ? snapshot.value as Map : {};
      if (settingsData.isNotEmpty) {
        await settingBox.clear();
        await settingBox.putAll(settingsData);
      }
    });
    // saved
    await cloud.getData(db: users, '$userId/$saved').then((snapshot) async {
      Map savedData = snapshot.value != null ? snapshot.value as Map : {};
      if (savedData.isNotEmpty) {
        await savedBox.clear();
        await savedBox.putAll(savedData);
      }
    });
    // update latest version locally
    await cloud.getData(db: users, '$userId/$activity/$activityLatest').then((snapshot) async {
      String latest = snapshot.value != null ? snapshot.value as String : '';
      if (latest.isNotEmpty) {
        activityVersionBox.put(userId, latest);
      }
    });
    show(':: Gotten all user data: ${liveUserEmail()}');
  } catch (e) {
    logError('getAllUserDataFromCloud', e);
  }

  showSyncingLoader(false);
}
