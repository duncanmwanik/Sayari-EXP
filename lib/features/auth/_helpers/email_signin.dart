import 'package:firebase_auth/firebase_auth.dart';

import '../../../_helpers/nav/navigation.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/others/toast.dart';
import '../var/var.dart';
import 'error.dart';
import 'signin_ops.dart';

Future<void> signInWithEmailPassword({bool validate = true}) async {
  try {
    if (state.auth.isBusy) return;

    if (!validate || authFormKey.currentState!.validate()) {
      hideKeyboard();
      state.auth.setProcess(authSignInLabel, true);
      String email = state.input.item.data[itemEmail];
      String password = state.input.item.data[itemPassword];

      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await signInOperation(user);
        state.auth.updateIsSuccessful(true);
      } else {
        toastError('Please try to sign in again.');
      }
    }
  } on FirebaseAuthException catch (error) {
    toastError(handleFirebaseAuthError(error, process: 'sign in'), duration: 5000);
  } catch (error) {
    toastError(handleOtherErrors(error, process: 'sign in'), duration: 5000);
  }

  state.auth.setProcess(authSignInLabel, false);
}
