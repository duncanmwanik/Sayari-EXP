import '../../../_services/hive/boxes.dart';
import '../../../_services/hive/load.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/files/_helpers/helper.dart';

Future<void> setUser(String userId, Map info) async {
  await globalBox.put(currentUser, userId);
  // add user's email to email tracking box
  await userEmailsBox.put(userId, info[itemEmail]);
  // we reload the hive boxes to initialize the user's boxes
  await loadAllBoxes();
  // save user details locally
  await userInfoBox.putAll(info);
}

bool isSignedIn() => liveUser() != noValue;
String liveUser() => globalBox.get(currentUser, defaultValue: noValue);
String liveUserEmail() => userInfoBox.get('e', defaultValue: '');
String liveUserName() => userInfoBox.get(itemContent, defaultValue: '');

String userDpName() => userInfoBox.get(itemUserDp, defaultValue: ''); // eg: fl12345678.png
String userDpId() => getfileNameOnly(userDpName()); // fl12345678
bool hasUserDp() => userDpName() != '';

bool isSpaceAlreadyAdded(String spaceId) => userSpacesBox.containsKey(spaceId);
