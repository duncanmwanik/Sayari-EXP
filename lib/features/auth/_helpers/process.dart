import '../../../_helpers/debug/debug.dart';
import '../../../_helpers/nav/navigation.dart';
import '../../../_state/_providers.dart';
import 'email_signin.dart';
import 'email_signup.dart';
import 'reset.dart';

Future<void> doAuth() async {
  {
    hideKeyboard();
    //
    if (state.auth.isSignUp()) {
      show('Creating new account......');
      await signUpWithEmailPassword();
    }
    //
    if (state.auth.isSignIn()) {
      show('Signing in......');
      await signInWithEmailPassword();
    }
    //
    if (state.auth.isResetPass()) {
      show('Resetting password......');
      await resetPassword();
    }
  }
}
