import 'dart:async';

import 'package:firebase_database/firebase_database.dart';

import '../../../_variables/constants.dart';
import '../../../features/user/_helpers/helpers.dart';
import '../../cloud/get_user_data.dart';
import '../../cloud/realtime.dart';
import '../../cloud/sync_from_cloud.dart';
import '../../hive/boxes.dart';
import '../activity_helper.dart';

StreamSubscription<DatabaseEvent>? listenForUserUpdates() {
  try {
    String userId = liveUser();

    return cloud.listen(db: users, '$userId/$activity/$activityLatest').listen((event) async {
      String newVersion = event.snapshot.value != null ? event.snapshot.value as String : '';
      String lastVersion = lastActivity(userId);
      // show('from: $lastVersion');

      if (lastVersion.isNotEmpty) {
        if (newVersion != lastVersion) {
          await cloud.getDataStartAfter(db: users, '$userId/$activity', lastVersion).then((snapshot) {
            Map newActivites = snapshot.value != null ? snapshot.value as Map : {};

            newActivites.forEach((timestamp, activity) async {
              if (timestamp != '0') await syncFromCloud(userId, timestamp, activity);
            });
          });
          // update latest version locally
          activityVersionBox.put(userId, newVersion);
        }
      } else {
        getAllUserDataFromCloud(userId);
      }
    });
  } catch (e) {
    return null;
  }
}
