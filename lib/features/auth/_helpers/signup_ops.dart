import 'package:firebase_auth/firebase_auth.dart';

import '../../../_helpers/debug/debug.dart';
import '../../../_services/cloud/sync.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/others/toast.dart';
import '../../spaces/_helpers/create.dart';
import '../../user/_helpers/helpers.dart';

Future<bool> signUpOperation(User user) async {
  try {
    // save user data to cloud
    await sync.create(
      db: users,
      space: user.uid,
      parent: info,
      value: {itemUsername: user.displayName, itemEmail: user.email},
      log: false,
    );
    await setUser(user.uid, {itemEmail: user.email, itemUsername: user.displayName});
    await createSpace(isDefault: true);
    toastSuccess('Signed up successfully...');
    return true;
  } catch (e) {
    logError('sign up ops', e);
    return false;
  }
}
