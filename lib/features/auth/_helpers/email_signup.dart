import 'package:firebase_auth/firebase_auth.dart';

import '../../../_helpers/nav/navigation.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/others/toast.dart';
import '../var/var.dart';
import 'error.dart';
import 'signup_ops.dart';

Future<void> signUpWithEmailPassword() async {
  try {
    if (state.auth.isBusy) return;

    if (authFormKey.currentState!.validate()) {
      hideKeyboard();
      state.auth.setProcess(authSignUpLabel, true);
      String name = state.input.item.data[itemUsername];
      String email = state.input.item.data[itemEmail];
      String password = state.input.item.data[itemPassword];
      String confirmPassword = state.input.item.data[itemConfirmPassword];

      if (password == confirmPassword) {
        UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
        User? user = userCredential.user;
        await user!.updateDisplayName(name);
        await user.reload();
        user = FirebaseAuth.instance.currentUser;

        if (user != null) {
          await signUpOperation(user);
          state.auth.updateIsSuccessful(true);
        } else {
          toastError('Please try to sign up again.');
        }
      } else {
        toastError('Passwords should match');
      }
    }
  } on FirebaseAuthException catch (error) {
    toastError(handleFirebaseAuthError(error, process: 'sign up'), duration: 5000);
  } catch (error) {
    toastError(handleOtherErrors(error, process: 'sign up'), duration: 5000);
  }

  state.auth.setProcess(authSignUpLabel, false);
}
