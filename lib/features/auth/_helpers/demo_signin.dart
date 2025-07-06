import 'package:firebase_auth/firebase_auth.dart';

import '../../../_helpers/common/global.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/others/toast.dart';
import '../var/var.dart';
import 'error.dart';
import 'signin_ops.dart';

Future<void> signInDemo() async {
  try {
    if (state.auth.isBusy) return;

    hideKeyboard();
    state.auth.setProcess(authDemoLabel, true);

    await FirebaseAuth.instance.signInWithEmailAndPassword(email: demoEmail, password: demoPass);
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await signInOperation(user);
      state.auth.updateIsSuccessful(true);
      setDemo(true);
    } else {
      toastError('Failed to sign in.');
    }
  } on FirebaseAuthException catch (error) {
    toastError(handleFirebaseAuthError(error, process: 'start demo'), duration: 5000);
  } catch (error) {
    toastError(handleOtherErrors(error, process: 'start demo'), duration: 5000);
  }

  state.auth.setProcess(authDemoLabel, false);
}
