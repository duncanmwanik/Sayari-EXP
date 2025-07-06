import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import '../../../_helpers/common/helpers.dart';
import '../../../_variables/constants.dart';
import '../../../features/spaces/_helpers/common.dart';
import '../../../features/spaces/_helpers/delete.dart';
import '../../cloud/get_space_data.dart';
import '../../cloud/realtime.dart';
import '../../cloud/sync_from_cloud.dart';
import '../../hive/boxes.dart';
import '../activity_helper.dart';

StreamSubscription<DatabaseEvent>? listenForSpaceUpdates() {
  try {
    String spaceId = liveSpace();
    if (isASpaceSelected()) {
      return cloud.listen(db: spaces, '$spaceId/activity/0').listen((event) async {
        if (event.snapshot.value != null) {
          String lastVersion = lastActivity(spaceId);
          String newVersion = event.snapshot.value as String;

          if (lastVersion.isNotEmpty) {
            if (newVersion != lastVersion) {
              showSyncingLoader(true);

              await cloud.getDataStartAfter(db: spaces, '$spaceId/activity', lastVersion).then((snapshot) {
                Map newActivites = snapshot.value != null ? snapshot.value as Map : {};
                newActivites.forEach((timestamp, activity) async {
                  if (!isActivityActedOn(spaceId, timestamp) && timestamp != '0') {
                    await syncFromCloud(spaceId, timestamp, activity);
                  }
                });
              });
              // update latest version locally
              activityVersionBox.put(spaceId, newVersion);

              showSyncingLoader(false);
            }
          } else {
            getAllSpaceDataFromCloud(spaceId);
          }
        } else {
          removeMissingSpace(spaceId: spaceId);
        }
      });
    } else {
      return null;
    }
  } catch (e) {
    showSyncingLoader(false);
    return null;
  }
}
