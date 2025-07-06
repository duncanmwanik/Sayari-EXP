import 'package:firebase_auth/firebase_auth.dart';

import '../../../_helpers/debug/debug.dart';
import '../../../_services/cloud/realtime.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/others/toast.dart';
import '../../spaces/_helpers/select.dart';
import '../../user/_helpers/helpers.dart';

Future<bool> signInOperation(User user) async {
  try {
    // update latest version locally
    await cloud.getData(db: users, '${user.uid}/$info').then((snapshot) async {
      Map userInfo = snapshot.value != null ? snapshot.value as Map : {};
      if (userInfo.isNotEmpty) {
        toastSuccess('Signed in successfully...');
        await setUser(user.uid, userInfo);
        await selectNewSpace(userInfo[userDefaultSpace]);
      }
    });

    return true;
  } catch (e) {
    logError('signInOperation', e);
    return false;
  }
}
