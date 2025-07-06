import '../../_helpers/common/global.dart';
import '../../_helpers/common/helpers.dart';
import '../../_helpers/debug/debug.dart';
import '../../_variables/constants.dart';
import '../../_variables/features.dart';
import '../../features/spaces/_helpers/common.dart';
import '../../features/spaces/_helpers/names.dart';
import '../hive/boxes.dart';
import '../hive/store.dart';
import 'realtime.dart';

Future<void> getAllSpaceDataFromCloud(String spaceId, {bool? isFirstTime}) async {
  showSyncingLoader(true);

  await getSpaceInfo(spaceId);
  await getSpaceNameFromCloud(spaceId);
  await getSpaceMemberData(spaceId);
  await getSpaceData(spaceId, features.timeline);
  await getSpaceData(spaceId, features.todo);
  await getSpaceData(spaceId, features.calendar);
  await getSpaceData(spaceId, features.docs);
  await getSpaceData(spaceId, features.tags);
  await getSpaceData(spaceId, features.flags);
  await getSpaceData(spaceId, features.subTypes);
  await getSpaceData(spaceId, features.chat);
  await getSpaceActivityVersion(spaceId);

  showSyncingLoader(false);
  show(':: Gotten all space data: ${liveSpaceTitle(spaceId: spaceId)}');
  resetApp();
}

Future<void> getSpaceInfo(String spaceId) async {
  try {
    await cloud.getData(db: spaces, '$spaceId/info').then((snapshot) async {
      Map data = snapshot.value != null ? snapshot.value as Map : {};
      local('info', space: spaceId).putAll(data);
      updateSpaceName(space: spaceId, name: data[itemTitle]);
    });
  } catch (e) {
    logError('getSpaceInfo', e);
  }
}

Future<void> getSpaceMemberData(String spaceId) async {
  try {
    await cloud.getData(db: spaces, '$spaceId/members').then((snapshot) async {
      Map data = snapshot.value != null ? snapshot.value as Map : {};
      if (data.isNotEmpty) {
        local('members', space: spaceId).clear();
        local('members', space: spaceId).putAll(data);
      }
    });
  } catch (e) {
    logError('getSpaceMemberData', e);
  }
}

Future<void> getSpaceActivityVersion(String spaceId) async {
  try {
    await cloud.getData(db: spaces, '$spaceId/activity/0').then((snapshot) {
      if (snapshot.value != null) {
        activityVersionBox.put(spaceId, snapshot.value as String);
      }
    });
  } catch (e) {
    logError('getSpaceActivityVersion', e);
  }
}

Future<void> getSpaceData(String spaceId, String type) async {
  try {
    await cloud.getData(db: spaces, '$spaceId/$type').then((snapshot) async {
      Map data = snapshot.value != null ? snapshot.value as Map : {};
      local(type, space: spaceId).putAll(data);
    });
  } catch (e) {
    logError('getSpaceData: $spaceId - $type', e);
  }
}
