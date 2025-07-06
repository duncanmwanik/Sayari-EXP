import 'package:flutter/material.dart';

import '../../_theme/variables.dart';

int getHashInt(str) {
  var hash = 5381;

  for (var i = 0; i < str.length; i++) {
    hash = ((hash << 4) + hash) + str.codeUnitAt(i) as int;
  }

  return hash;
}

Color stringToColor(String string) {
  try {
    var hash = getHashInt(string);
    var r = (hash & 0xFF0000) >> 16;
    var g = (hash & 0x00FF00) >> 8;
    var b = hash & 0x0000FF;

    var rr = '0$r';
    var gg = '0$g';
    var bb = '0$b';

    var val = int.parse('0xFF${rr.substring(rr.length - 2)}${gg.substring(gg.length - 2)}${bb.substring(bb.length - 2)}');

    return Color(val);
  } catch (err) {
    return styler.textColor(faded: true);
  }
}
