import 'package:flutter/material.dart';

import '../_services/hive/boxes.dart';
import '../_theme/helpers.dart';
import '../_variables/constants.dart';

class ThemeProvider with ChangeNotifier {
  String themeImage = settingBox.get('themeImage', defaultValue: defaultTheme);
  String themeType = settingBox.get('themeType', defaultValue: defaultTheme);
  String themeAccent = settingBox.get('themeAccent', defaultValue: '0');

  void setThemeImage(String themeImage_, String themeType_, String themeAccent_) {
    themeImage = themeImage_;
    themeType = themeType_;
    themeAccent = themeAccent_;
    settingBox.put('themeImage', themeImage_);
    settingBox.put('themeType', themeType_);
    settingBox.put('themeAccent', themeAccent_);
    changeStatusAndNavigationBarColor(themeType_);
    notifyListeners();
  }

  void enableThemeType() {
    changeStatusAndNavigationBarColor(themeType);
    notifyListeners();
  }
}
