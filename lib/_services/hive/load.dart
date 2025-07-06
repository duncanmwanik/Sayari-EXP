import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../_variables/constants.dart';
import '../../_variables/features.dart';
import '../../features/spaces/_helpers/common.dart';
import '../../features/user/_helpers/helpers.dart';
import 'boxes.dart';

Future<void> initializeHive() async {
  await Hive.initFlutter();
  await loadAllBoxes();
}

Future<void> loadAllBoxes() async {
  globalBox = await Hive.openBox('global');
  spaceNamesBox = await Hive.openBox('spaceName');
  userEmailsBox = await Hive.openBox('userEmails');
  pendingBox = await Hive.openBox('pending');
  fileBox = await Hive.openBox('fileBox');
  offlineFilesBox = await Hive.openBox('offlineFilesBox');
  cachedFileUrlsBox = await Hive.openBox('cachedFile');
  rebuildBox = await Hive.openBox('rebuildBox');
  activityVersionBox = await Hive.openBox('${activity}_version');

  await loadUserBoxes(liveUser());
  await loadSpaceBoxes(liveSpace());
  await loadSpaceBoxes(noValue); // avoid errors when no space is selected
}

Future<void> loadSpaceBoxes(String spaceId) async {
  await Hive.openBox(spaceId);
  await Hive.openBox('${spaceId}_$info');
  await Hive.openBox('${spaceId}_$members');
  await Hive.openBox('${spaceId}_$activity');
  await Hive.openBox('${spaceId}_$notifications');
  await Hive.openBox('${spaceId}_${features.timeline}');
  await Hive.openBox('${spaceId}_${features.todo}');
  await Hive.openBox('${spaceId}_${features.calendar}');
  await Hive.openBox('${spaceId}_${features.docs}');
  await Hive.openBox('${spaceId}_${features.chat}');
  await Hive.openBox('${spaceId}_${features.flags}');
  await Hive.openBox('${spaceId}_${features.tags}');
  await Hive.openBox('${spaceId}_${features.subTypes}');
  await Hive.openBox('${spaceId}_$settings');
}

Future<void> loadUserBoxes(String userId) async {
  await Hive.openBox(userId);
  userInfoBox = await Hive.openBox('${userId}_$info');
  userSpacesBox = await Hive.openBox('${userId}_$spaces');
  userGroupsBox = await Hive.openBox('${userId}_$groups');
  settingBox = await Hive.openBox('${userId}_$settings');
  savedBox = await Hive.openBox('${userId}_$saved');
}
