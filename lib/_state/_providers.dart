import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../_widgets/editor/state/editor.dart';
import '../features/auth/state/auth.dart';
import '../features/bookings/_state/date.dart';
import '../features/calendar/_state/date.dart';
import '../features/chat/state/chat.dart';
import '../features/notes/state/active.dart';
import '../features/notes/state/data.dart';
import '../features/notes/state/selection.dart';
import '../features/notes/state/sheet.dart';
import '../features/pomodoro/state/pomodoro.dart';
import '../features/share/state/share.dart';
import '../features/tts/_state/tts_provider.dart';
import 'focus.dart';
import 'global.dart';
import 'input.dart';
import 'input2.dart';
import 'temp.dart';
import 'theme.dart';
import 'views.dart';

//
// all app providers
//

List<SingleChildWidget> allProviders = [
  ChangeNotifierProvider(create: (context) => DocProvider()),
  ChangeNotifierProvider(create: (context) => DataProvider()),
  ChangeNotifierProvider(create: (context) => InputProvider()),
  ChangeNotifierProvider(create: (context) => InputProvider2()),
  //
  ChangeNotifierProvider(create: (context) => EditorProvider()),
  ChangeNotifierProvider(create: (context) => TTSProvider()),
  ChangeNotifierProvider(create: (context) => PomodoroProvider()),
  ChangeNotifierProvider(create: (context) => ChatProvider()),
  ChangeNotifierProvider(create: (context) => BookingProvider()),
  //
  ChangeNotifierProvider(create: (context) => GlobalProvider()),
  ChangeNotifierProvider(create: (context) => ThemeProvider()),
  ChangeNotifierProvider(create: (context) => ViewsProvider()),
  ChangeNotifierProvider(create: (context) => DateProvider()),
  ChangeNotifierProvider(create: (context) => SelectionProvider()),
  ChangeNotifierProvider(create: (context) => SheetProvider()),
  // misc
  ChangeNotifierProvider(create: (context) => FocusProvider()),
  ChangeNotifierProvider(create: (context) => TempProvider()),
  ChangeNotifierProvider(create: (context) => ShareProvider()),
  ChangeNotifierProvider(create: (context) => AuthorityProvider()),
];

//
// custom state shortcuts... i love shortcuts ;)
//

class AppState {
  late ThemeProvider theme;
  late GlobalProvider global;
  late DataProvider data;
  late InputProvider input;
  late InputProvider2 input2;
  late DocProvider doc;
  late EditorProvider editor;
  late DateProvider dates;
  late ViewsProvider views;
  late SelectionProvider selection;
  late TTSProvider tts;
  late PomodoroProvider pomodoro;
  late ChatProvider chat;
  late BookingProvider bookings;
  late FocusProvider focus;
  late ShareProvider share;
  late TempProvider temp;
  late AuthorityProvider auth;
  late SheetProvider sheet;

  void initialize(BuildContext appContext) {
    theme = appContext.read<ThemeProvider>();
    global = appContext.read<GlobalProvider>();
    data = appContext.read<DataProvider>();
    input = appContext.read<InputProvider>();
    input2 = appContext.read<InputProvider2>();
    doc = appContext.read<DocProvider>();
    editor = appContext.read<EditorProvider>();
    dates = appContext.read<DateProvider>();
    views = appContext.read<ViewsProvider>();
    selection = appContext.read<SelectionProvider>();
    tts = appContext.read<TTSProvider>();
    pomodoro = appContext.read<PomodoroProvider>();
    chat = appContext.read<ChatProvider>();
    bookings = appContext.read<BookingProvider>();
    focus = appContext.read<FocusProvider>();
    share = appContext.read<ShareProvider>();
    temp = appContext.read<TempProvider>();
    auth = appContext.read<AuthorityProvider>();
    sheet = appContext.read<SheetProvider>();
  }
}

AppState state = AppState();
