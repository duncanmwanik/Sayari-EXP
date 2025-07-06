import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../_services/hive/boxes.dart';
import '../../_state/_providers.dart';
import '../../_variables/constants.dart';
import '../../_variables/navigation.dart';
import '../../_widgets/others/snackbar.dart';

void hideKeyboard() {
  try {
    FocusManager.instance.primaryFocus?.unfocus();
  } catch (_) {}
}

void removeFocus() {
  try {
    FocusScope.of(navigatorState.currentContext!).requestFocus(FocusNode());
  } catch (_) {}
}

void onBuildOperation(Function()? operation) {
  WidgetsBinding.instance.addPostFrameCallback((_) => operation);
}

void popWhatsOnTop({dynamic value, void Function()? todo, void Function()? todoLast, bool pop = true}) {
  if (todo != null) todo();
  if (pop && navigatorState.currentContext!.canPop()) navigatorState.currentContext!.pop(value);
  if (todoLast != null) todoLast();
}

void closeDialog() => popWhatsOnTop();
void closeAllSnackBars() => ScaffoldMessenger.of(navigatorState.currentContext!).clearSnackBars();

void closeBottomSheet() {
  if (state.global.isBottomSheetOpen) {
    popWhatsOnTop();
    state.global.updateIsBottomSheetOpen(false);
  }
}

Future<void> closeDrawer() async {
  scaffoldState.currentState?.closeDrawer();
  scaffoldState.currentState?.closeEndDrawer();
}

void openDrawer([String type = spaceManagerType]) {
  globalBox.put(drawerType, type);
  scaffoldState.currentState!.openDrawer();
}

void openEndDrawer() => scaffoldState.currentState!.openEndDrawer();
bool isDrawerOpened() => scaffoldState.currentState?.isDrawerOpen == true;

Future<bool> confirmExitApp() async {
  if (isDrawerOpened()) {
    closeDrawer();
    return false;
  } else {
    if (exitApp) {
      return true;
    } else {
      exitApp = true;
      showSnackBar('Tap again to exit...');
      Future.delayed(const Duration(seconds: 5), () {
        exitApp = false;
      });
      return false;
    }
  }
}

void goHome() => navigatorState.currentContext!.go('/');
void goIntro() => navigatorState.currentContext!.go('/signin');
