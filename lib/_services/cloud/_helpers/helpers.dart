import 'package:firebase_database/firebase_database.dart';

import '../../../_variables/constants.dart';
import '../../../features/spaces/_helpers/common.dart';
import '../../../features/user/_helpers/helpers.dart';
import '../realtime.dart';

Future<String> doesSpaceExist(String spaceId) async {
  try {
    DataSnapshot snapshot = await cloud.getData(db: spaces, '$spaceId/info/t');
    return snapshot.value != null ? snapshot.value as String : '';
  } catch (e) {
    return '';
  }
}

Future<String> getUserEmailFromCloud(String userId) async {
  try {
    DataSnapshot userData = await cloud.getData(db: spaces, '$userId/info/e');
    return userData.value as String;
  } catch (e) {
    return 'No email';
  }
}

Future<bool> isSpaceAdminCloud() async {
  String userId = liveUser();
  String spaceId = liveSpace();
  DataSnapshot snapshot = await cloud.getData(db: spaces, '$spaceId/members/$userId');
  return snapshot.exists;
}

Future<bool> isSpaceOwnerCloud(String spaceId, String userId) async {
  try {
    DataSnapshot snapshot = await cloud.getData(db: spaces, '$spaceId/members/$userId');
    return (snapshot.value as String) == '2';
  } catch (_) {
    return false;
  }
}

Future<bool> isAlreadyAdmin(String spaceId, String userEmail) async {
  DataSnapshot snapshot = await cloud.getData(db: spaces, '$spaceId/members/$userEmail');
  return snapshot.exists;
}
