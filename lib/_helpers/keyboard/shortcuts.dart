import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../_state/_providers.dart';
import '../../_theme/helpers.dart';
import '../../features/home/panel/helpers.dart';
import '../../features/pomodoro/sheet.dart';
import '../../features/settings/settings_sheet.dart';
import '../nav/navigation.dart';

Map<Type, Action<Intent>> actions = {
  ThemeIntent: CallbackAction<ThemeIntent>(onInvoke: (intent) => quickSwitchThemes()),
  SettingIntent: CallbackAction<SettingIntent>(onInvoke: (intent) => showSettingsBottomSheet()),
  ManagerIntent: CallbackAction<ManagerIntent>(onInvoke: (intent) => openDrawer()),
  PanelIntent: CallbackAction<PanelIntent>(onInvoke: (intent) => togglePanel()),
  SheetIntent: CallbackAction<SheetIntent>(onInvoke: (intent) => state.sheet.updateIsMinimized(!state.sheet.isMin)),
  PomodoroIntent: CallbackAction<PomodoroIntent>(onInvoke: (intent) => showPomodoroSheet()),
};

Map<ShortcutActivator, Intent> shortcuts = {
  LogicalKeySet(LogicalKeyboardKey.altLeft, LogicalKeyboardKey.keyT): ThemeIntent(),
  LogicalKeySet(LogicalKeyboardKey.altLeft, LogicalKeyboardKey.keyS): SettingIntent(),
  LogicalKeySet(LogicalKeyboardKey.altLeft, LogicalKeyboardKey.keyD): ManagerIntent(),
  LogicalKeySet(LogicalKeyboardKey.altLeft, LogicalKeyboardKey.keyM): PanelIntent(),
  LogicalKeySet(LogicalKeyboardKey.altRight, LogicalKeyboardKey.keyM): PanelIntent(),
  LogicalKeySet(LogicalKeyboardKey.altRight, LogicalKeyboardKey.keyE): SheetIntent(),
  LogicalKeySet(LogicalKeyboardKey.altLeft, LogicalKeyboardKey.keyE): SheetIntent(),
  LogicalKeySet(LogicalKeyboardKey.altLeft, LogicalKeyboardKey.keyP): PomodoroIntent(),
  LogicalKeySet(LogicalKeyboardKey.altRight, LogicalKeyboardKey.keyP): PomodoroIntent(),
};

class ThemeIntent extends Intent {}

class SettingIntent extends Intent {}

class ManagerIntent extends Intent {}

class PanelIntent extends Intent {}

class SheetIntent extends Intent {}

class PomodoroIntent extends Intent {}
