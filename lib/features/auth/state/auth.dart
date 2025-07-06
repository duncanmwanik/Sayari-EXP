import 'package:flutter/material.dart';

import '../../../_variables/constants.dart';
import '../var/var.dart';

class AuthorityProvider with ChangeNotifier {
  // the process in progress
  String process = authSignInLabel;
  bool isBusy = false;
  bool isSuccessful = false;

  bool isSignIn() => process == authSignInLabel;
  bool isSignUp() => process == authSignUpLabel;
  bool isGoogleAuth() => process == authGoogleLabel;
  bool isResetPass() => process == authResetPassLabel;
  bool isDemo() => process == authDemoLabel;

  bool showAll() => !isResetPass() && !isSignUp();

  void setProcess(String value, bool busy) {
    if (isBusy && value != process) return;
    process = value;
    isBusy = busy;
    notifyListeners();
  }

  void updateIsSuccessful(bool success) {
    isBusy = false;
    isSuccessful = success;
    notifyListeners();
    Future.delayed(Duration(seconds: 5), () {
      isSuccessful = false;
      notifyListeners();
    });
  }

  void reset() {
    process = authSignInLabel;
    isBusy = false;
    isSuccessful = false;
    authFormKey.currentState!.reset();
    notifyListeners();
  }
}
