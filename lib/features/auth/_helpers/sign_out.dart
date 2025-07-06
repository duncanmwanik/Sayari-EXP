import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../../_helpers/common/global.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_services/hive/boxes.dart';
import '../../../_theme/spacing.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/dialogs/confirmation_dialog.dart';

Future<void> signOutUser() async {
  await showConfirmationDialog(
      title: 'Are you sure you want to ${isDemo() ? 'leave demo' : 'sign out'}?',
      yeslabel: isDemo() ? 'Leave' : 'Sign Out',
      content: mph(),
      onAccept: () async {
        await FirebaseAuth.instance.signOut();
        await globalBox.put(currentUser, noValue);
        if (isDemo()) setDemo(false);
        goIntro();
      });
}

Future<void> clearData() async {
  await FirebaseAuth.instance.signOut();
  await Hive.deleteFromDisk();
  goIntro();
}
