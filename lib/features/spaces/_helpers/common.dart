import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../_helpers/extentions/strings.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_services/hive/store.dart';
import '../../../_variables/constants.dart';
import '../../user/_helpers/helpers.dart';

String liveSpace() => globalBox.get('${liveUser()}_$currentSpace', defaultValue: noValue);
String liveSpaceTitle({String? spaceId, String? defaultValue}) => spaceNamesBox.get(
      spaceId ?? liveSpace(),
      defaultValue: defaultValue ?? '',
    );

String defaultSpace() => userInfoBox.get(userDefaultSpace, defaultValue: noValue);

bool isASpaceSelected() => liveSpace() != noValue;
bool isLiveSpace(String spaceId) => liveSpace() == spaceId;
bool isDefaultSpace(String spaceId) => userSpacesBox.get(spaceId, defaultValue: 0) == 1;

bool isSuperAdmin([String? userId]) => [superAdminPriviledge].contains(getMemberPriviledge(userId ?? liveUser()));
bool isAdmin([String? userId]) => [adminPriviledge, superAdminPriviledge].contains(getMemberPriviledge(userId ?? liveUser()));
int getMemberPriviledge(String userId) => local(members).get(userId, defaultValue: memberPriviledge);

String spaceOwner() => local(members).toMap().entries.firstWhere((member) => member.value == superAdminPriviledge).key;

Future<bool> isOwner([String? spaceId]) async {
  try {
    Box box = await Hive.openBox('${spaceId ?? liveSpace()}_$members');
    return box.get(liveUser(), defaultValue: memberPriviledge) == superAdminPriviledge;
  } catch (e) {
    return false;
  }
}

String publishedSpaceLink([bool link = false]) =>
    link ? '$sayariDefaultPath/${liveSpaceTitle().bare()}_${liveSpace()}' : '/${liveSpaceTitle().bare()}_${liveSpace()}';

String publishedSpaceId(String path) {
  try {
    return path.substring(path.length - 26);
  } catch (e) {
    return noValue;
  }
}
