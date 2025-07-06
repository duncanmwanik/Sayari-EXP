// ignore_for_file: dead_code

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../_helpers/debug/debug.dart';
import '../../../_services/cloud/realtime.dart';
import '../../../_state/_providers.dart';
import '../../../_variables/constants.dart';
import '../../../_widgets/others/toast.dart';
import 'error.dart';
import 'signin_ops.dart';
import 'signup_ops.dart';

Future<void> signInWithGoogle({bool silently = false}) async {
  try {
    if (state.auth.isBusy) return;
    if (!silently) state.auth.setProcess(authGoogleLabel, true);

    GoogleSignIn googleSignIn = GoogleSignIn(
      clientId: '347700769995-a23ul6gu4tmdki4gk1kd01but5953hjp.apps.googleusercontent.com',
    );

    final GoogleSignInAccount? googleUser = silently ? await googleSignIn.signInSilently() : await googleSignIn.signIn();

    if (googleUser != null) {
      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // sign in with firebase
      await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await cloud.doesUserExist(user.email!).then((userId) async {
          if (userId.isNotEmpty) {
            show('exists');
            await signInOperation(user);
          } else {
            show(' not exists');
            await signUpOperation(user);
          }
        });
      }
    }
  } on FirebaseAuthException catch (error) {
    toastError(handleFirebaseAuthError(error, process: 'sign in'), duration: 5000);
  } catch (e) {
    logError('signInWithGoogle', e);
    toastError(handleOtherErrors(e, process: 'sign in'));
  }

  if (!silently) state.auth.setProcess(authGoogleLabel, false);
}
