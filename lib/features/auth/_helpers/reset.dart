import 'package:firebase_auth/firebase_auth.dart';

import '../../../_helpers/common/internet.dart';
import '../../../_helpers/debug/debug.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/others/toast.dart';
import '../../user/_helpers/helpers.dart';
import '../var/var.dart';
import 'error.dart';

Future<void> resetPassword() async {
  if (state.auth.isBusy) return;

  state.auth.setProcess(authResetPassLabel, true);

  String email = state.auth.isResetPass() ? state.input.item.data[itemEmail] : liveUserEmail();

  if (authFormKey.currentState!.validate()) {
    if (await isOffline()) return;

    await FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((_) {
      state.auth.updateIsSuccessful(true);
      toastSuccess('Check your email for the password reset link.');
    }).catchError((e) {
      toastError(handleFirebaseAuthError(e, process: 'reset password'), duration: 5000);
      logError('resetPassword', e);
    });
  }

  state.auth.setProcess(authResetPassLabel, false);
}

Future<void> quickResetPassword() async {
  if (await isOffline()) return;

  await FirebaseAuth.instance.sendPasswordResetEmail(email: liveUserEmail()).then((_) {
    state.auth.updateIsSuccessful(true);
    toastSuccess('Check your email for the password reset link.');
  }).catchError((e) {
    toastError(handleFirebaseAuthError(e, process: 'reset password'), duration: 5000);
    logError('resetPassword', e);
  });
}
